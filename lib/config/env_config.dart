import 'package:yo_gift/config/env_name.dart';

/// 环境配置
class EnvConfig {
  /// 应用名称
  final String appTitle;

  /// http 请求域名
  final String baseUrl;

  final bool isDebug;

  EnvConfig({
    required this.appTitle,
    required this.baseUrl,
    this.isDebug = false,
  });
}

class Env {
  static const isProd = bool.fromEnvironment('dart.vm.product');
  static const appEnv = String.fromEnvironment(EnvName.envKey);

  /// 开发环境
  static final _debugConfig = EnvConfig(
    appTitle: "YO!GIFT",
    baseUrl: "https://test.api.yogift.hk",
    isDebug: true,
  );

  /// 测试环境
  static final _testConfig = EnvConfig(
    appTitle: "YO!GIFT",
    baseUrl: "https://test.api.yogift.hk",
  );

  /// 生产环境
  static final _productionConfig = EnvConfig(
    appTitle: "YO!GIFT",
    baseUrl: "https://test.api.yogift.hk",
  );

  static EnvConfig get config => _getEnvConfig();

  static EnvConfig _getEnvConfig() {
    switch (appEnv) {
      case EnvName.test:
        return _testConfig;
      case EnvName.release:
      case EnvName.production:
        return _productionConfig;
      case EnvName.debug:
        return _debugConfig;
      default:
        return _debugConfig;
    }
  }
}
