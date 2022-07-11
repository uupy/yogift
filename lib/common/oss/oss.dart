import 'package:yo_gift/common/app_storage.dart';
import 'package:yo_gift/common/http.dart';
import 'package:yo_gift/common/logger.dart';
import 'package:dio/dio.dart';

import 'oss_data.dart';
import 'oss_task.dart';
import 'oss_util.dart';

export 'oss_data.dart';
export 'oss_util.dart';

Dio dio = Dio(BaseOptions(
  connectTimeout: 600000,
));

final Oss oss = Oss.getInstance();

class Oss {
  Oss._internal();

  static Oss? _instance;

  factory Oss.getInstance() => _instance ??= Oss._internal();

  OssData? data;
  bool uploading = false;
  List<OssTask> taskList = [];
  Map<String, CancelToken> cancelTokens = {};

  Future<OssData?> init() async {
    try {
      final res =
          await http.get('/wms/api/common/oss/sts', data: {'dir': 'app/'});
      final result = res.data['data'];

      data = OssData.fromJson(result ?? {});

      return data;
    } catch (e) {
      return null;
    }
  }

  Future start() async {
    if (uploading) return;

    try {
      final items = await ossUploadTask.get() ?? [];

      taskList = items.map((e) => OssTask.fromJson(e)).toList();

      uploading = true;

      if (taskList.isNotEmpty) {
        OssTask currentTask = taskList.first;
        if (currentTask.cancelTokenKey?.isEmpty ?? true) {
          currentTask.cancelTokenKey = currentTask.uploadPath;
          cancelTokens[currentTask.cancelTokenKey!] = CancelToken();
        }
        await upload(currentTask);
        taskList.remove(currentTask);

        await ossUploadTask.set(taskList.map((e) => e.toJson()).toList());
        await start();
      }
    } catch (err) {
      logger.e('oss start error: $err');
      if (taskList.isNotEmpty) {
        await Future.delayed(const Duration(seconds: 5));
        await start();
      }
    } finally {
      uploading = false;
    }
  }

  Future<OssTask> addTask(String filePath, [String type = 'image']) async {
    OssTask task = OssTask(
      filePath: filePath,
      type: type,
    );
    task.fileName = OssUtil.getFileName(filePath);
    task.uploadPath = OssUtil.getUploadName(filePath, 'app');
    taskList.add(task);
    await ossUploadTask.set(taskList.map((e) => e.toJson()).toList());
    start();
    return task;
  }

  Future removeTask(String path) async {
    final task = taskList.singleWhere((e) {
      final paths = [e.filePath, e.uploadPath, '${data?.host}/${e.uploadPath}'];
      return paths.contains(path);
    }, orElse: () => OssTask());
    final cancelKey = task.cancelTokenKey ?? '';
    final cancelToken = cancelTokens[cancelKey];
    taskList.remove(task);
    await ossUploadTask.set(taskList.map((e) => e.toJson()).toList());
    cancelToken?.cancel();
    cancelTokens.remove(cancelKey);
  }

  Future<String?> upload(OssTask task) async {
    final expire = int.parse(data?.expire ?? '') * 1000;
    try {
      if (expire < DateTime.now().millisecondsSinceEpoch) {
        await init();
      }
      String filePath = task.filePath ?? '';
      String uploadName = task.uploadPath ?? '';
      FormData formData = FormData.fromMap({
        // 文件名，随意
        'Filename': uploadName,
        // "可以填写文件夹名（对应于oss服务中的文件夹）/" + fileName
        'key': uploadName, //上传后的文件名
        'policy': data?.policy,
        // Bucket 拥有者的AccessKeyId。
        'OSSAccessKeyId': data?.accessId,
        // 让服务端返回200，不然，默认会返回204
        'success_action_status': '200',
        'signature': data?.signature,
        // 临时用户授权时必须，需要携带后台返回的security-token
        // 'x-oss-security-token': data['SecurityToken'],
        'file': await MultipartFile.fromFile(
          filePath,
          filename: task.fileName,
        )
      });
      dio.options.responseType = ResponseType.plain;
      String host = data?.host ?? '';
      final cancelKey = task.cancelTokenKey ?? '';
      final cancelToken = cancelTokens[cancelKey];
      await dio.post(host, data: formData, cancelToken: cancelToken);
      return '$host/$uploadName';
    } catch (err) {
      // app.showToast('上传失败');
      logger.e('oss upload error: $err');
      rethrow;
    }
  }
}
