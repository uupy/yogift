import 'dart:convert';
import 'dart:math';
import 'package:crypto/crypto.dart';

class OssUtil {
  OssUtil._internal();

  static OssUtil? _instance;

  factory OssUtil.getInstance() => _instance ??= OssUtil._internal();

  //验证文本域
  static const String _policyText =
      '{"expiration": "2069-05-22T03:15:00.000Z","conditions": [["content-length-range", 0, 1048576000]]}'; //UTC时间+8=北京时间

  //进行utf8编码
  // ignore: non_constant_identifier_names
  static final List<int> _policyText_utf8 = utf8.encode(_policyText);

  //进行base64编码
  static String policy = base64.encode(_policyText_utf8);

  //再次进行utf8编码
  // ignore: non_constant_identifier_names
  static final List<int> _policy_utf8 = utf8.encode(policy);

  /// 获取signature签名参数
  static String getSignature(String _accessKeySecret) {
    /// 进行utf8 编码
    List<int> accessKeySecretUtf8 = utf8.encode(_accessKeySecret);

    /// 通过hmac,使用sha1进行加密
    List<int> signaturePre =
        Hmac(sha1, accessKeySecretUtf8).convert(_policy_utf8).bytes;

    /// 最后一步，将上述所得进行base64 编码
    String signature = base64.encode(signaturePre);
    return signature;
  }

  /// 生成上传上传文件的名称 ,获得的格式:photo/20171027175940_oCiobK
  /// 可以定义上传的路径uploadPath(Oss中保存文件夹的名称)
  /// @param uploadPath 上传的路径 如：/app
  /// @return app/20171027175940_oCiobK
  static String getUploadName(String filePath, [String dirPath = '']) {
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    String name = timestamp.toString() + "_" + getRandom(6);
    String ext = getFileExt(filePath);

    if (dirPath.isNotEmpty) {
      name = dirPath + "/" + name;
    }

    return name + ext;
  }

  static String getFileExt(String path) {
    return path.substring(path.lastIndexOf("."), path.length);
  }

  static String getFileName(String path) {
    return path.substring(path.lastIndexOf("/") + 1, path.length);
  }

  /// 生成固定长度的随机字符串
  static String getRandom(int num) {
    String alphabet = 'qwertyuiopasdfghjklzxcvbnmQWERTYUIOPASDFGHJKLZXCVBNM';
    String left = '';
    for (var i = 0; i < num; i++) {
      left = left + alphabet[Random().nextInt(alphabet.length)];
    }
    return left;
  }
}
