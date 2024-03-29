import 'package:yo_gift/config/env_name.dart';

/// 环境配置
class EnvConfig {
  /// 应用名称
  final String appTitle;

  /// http 请求域名
  final String baseUrl;
  final String h5website;

  /// 资源文件夹路径
  final String resourceDirPath;

  /// 微信应用appId
  final String wxAppId;
  final String universalLink;

  /// facebook appId
  final String facebookAppId;

  final bool isDebug;

  EnvConfig({
    required this.appTitle,
    required this.baseUrl,
    this.isDebug = false,
    this.h5website = '',
    this.resourceDirPath = '',
    this.wxAppId = '',
    this.facebookAppId = '',
    this.universalLink = '',
  });
}

class Env {
  static const isProd = bool.fromEnvironment('dart.vm.product');
  static const appEnv = String.fromEnvironment(EnvName.envKey);

  /// 开发环境
  static final _debugConfig = EnvConfig(
    appTitle: "YO!GIFT",
    baseUrl: "https://test.api.yogift.hk",
    h5website: "https://test.www.yogift.hk",
    resourceDirPath: '/dev',
    wxAppId: 'wx121ad59c9a64ccd9',
    facebookAppId: '1180431849520042',
    universalLink: 'https://www.yogift.hk/',
    isDebug: true,
  );

  /// 测试环境
  static final _testConfig = EnvConfig(
    appTitle: "YO!GIFT",
    baseUrl: "https://test.api.yogift.hk",
    h5website: "https://test.www.yogift.hk",
    resourceDirPath: '/dev',
    wxAppId: 'wx121ad59c9a64ccd9',
    facebookAppId: '1180431849520042',
    universalLink: 'https://www.yogift.hk/',
  );

  /// 生产环境
  static final _productionConfig = EnvConfig(
    appTitle: "YO!GIFT",
    baseUrl: "https://api.yogift.hk",
    h5website: "https://www.yogift.hk",
    wxAppId: 'wx121ad59c9a64ccd9',
    facebookAppId: '1180431849520042',
    universalLink: 'https://www.yogift.hk/',
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
