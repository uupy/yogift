/// 应用全局配置
class AppConfig {
  AppConfig._();

  /// 测试环境的包名
  static List<String> testPackageNames = [
    'com.bckj.app_warehouse_test',
  ];

  /// 是否生产打包
  static const bool isProdEnv = bool.fromEnvironment('dart.vm.product');

  /// 开发环境
  static String devBaseUrl = 'https://test.api.yogift.hk';

  /// 测试环境
  static String testBaseUrl = 'https://test.api.yogift.hk';

  /// 生产环境
  static String prodBaseUrl = 'https://test.api.yogift.hk';

  /// api基础路径
  static String baseUrl = isProdEnv ? prodBaseUrl : devBaseUrl;
}
