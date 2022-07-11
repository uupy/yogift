class OssData {
  String? dir;
  String? expire;
  String? host;
  String? accessId;
  String? policy;
  String? signature;

  OssData({
    this.dir,
    this.expire,
    this.host,
    this.accessId,
    this.policy,
    this.signature,
  });

  OssData.fromJson(Map<String, dynamic> json) {
    dir = json['dir'];
    expire = json['expire'];
    host = json['host'];
    accessId = json['accessId'];
    policy = json['policy'];
    signature = json['signature'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['dir'] = dir;
    data['expire'] = expire;
    data['host'] = host;
    data['accessId'] = accessId;
    data['policy'] = policy;
    data['signature'] = signature;
    return data;
  }
}
