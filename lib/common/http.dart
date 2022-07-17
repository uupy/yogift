import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:yo_gift/config/env_config.dart';

import 'app.dart';
import 'app_storage.dart';
import 'logger.dart';

Map<int, String> errorMessages = {
  400: 'Bad Request',
  401: 'Login expired',
  403: 'No access',
  502: '502 Bad Gateway',
};

/// dio interceptor
Interceptor requestInterceptor() {
  int? code;
  String? msg;
  String _token;
  return InterceptorsWrapper(
    onRequest: (options, handler) async {
      if (app.hasNetWork) {
        _token = await authToken.get() ?? '';

        if (_token.isNotEmpty) {
          options.headers['Authorization'] = 'Bearer $_token';
        }

        return handler.next(options);
      } else {
        return handler.reject(
          DioError(
            requestOptions: options,
          ),
          true,
        );
      }
    },
    onResponse: (options, handler) {
      final req = options.requestOptions;
      final res = options.data ?? {};
      final code = res['code'];
      final msg = res['message'] ?? errorMessages[code];
      bool isSilent = req.extra['silent'] ?? false;

      if (code != null && code != 200) {
        if (!isSilent) {
          app.showToast(msg ?? '');
        }

        req.extra['silent'] = true;
        handler.reject(
          DioError(requestOptions: req, response: options),
          true,
        );
      }

      return handler.next(options);
    },
    onError: (error, handler) {
      RequestOptions errReq = error.requestOptions;
      Response? errRes = error.response;
      Map<String, dynamic>? errMap = json.decode(errRes.toString());
      code = errRes?.statusCode;
      msg = errMap?['message'] ?? errorMessages[code] ?? 'Server exception';
      bool isSilent = errReq.extra['silent'] ?? false;

      if (!app.hasNetWork) {
        msg = '请检查网络设置';
      }

      if (!isSilent) {
        app.showToast(msg ?? '');
        if (code == 401) {
          /// 登录过期
          app.logout();
        }
      }

      logger.e('http error[$code]: path - ${errReq.path}');

      handler.next(error);
    },
  );
}

class Http {
  Dio dio = Dio(BaseOptions(
    baseUrl: Env.config.baseUrl,
    connectTimeout: 60000,
  ));

  static Http? _instance;

  factory Http.getInstance() => _instance ??= Http._internal();

  Http._internal() {
    dio.interceptors.add(requestInterceptor());
  }

  /// get请求
  Future get(String path, {data, queryParameters, Options? options}) async {
    return await dio.get(
      path,
      queryParameters: data ?? queryParameters,
      options: options,
    );
  }

  /// post请求
  Future post(String path, {data, Options? options}) async {
    /// 请求的Content-Type，默认值是"application/json; charset=utf-8".
    /// 如果您想以"application/x-www-form-urlencoded"格式编码请求数据,
    /// 可以设置此选项为 `Headers.formUrlEncodedContentType`,  这样[Dio]
    /// 就会自动编码请求体.
    Options _options = options ?? Options();
    _options.contentType = Headers.formUrlEncodedContentType;
    return await dio.post(
      path,
      data: data,
      options: _options,
    );
  }

  /// post请求
  Future postJson(String path, {data, Options? options}) async {
    return await dio.post(
      path,
      data: data,
      options: options,
    );
  }

  /// post请求
  Future put(String path, {data, Options? options}) async {
    return await dio.put(
      path,
      data: data,
      options: options,
    );
  }

  /// post请求
  Future delete(String path, {data, Options? options}) async {
    return await dio.delete(
      path,
      data: data,
      options: options,
    );
  }
}

final Http http = Http.getInstance();
