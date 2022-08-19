class GetPayTypeDataVo {
  /// 訂單id或guid
  String? idGuid;

  /// 支付场景: 1普通浏览器h5 2微信浏览器h5 3小程序 4app 5电脑pc网页
  int? scene;

  /// 回调网址
  String? paycallbackurl;

  GetPayTypeDataVo({this.idGuid, this.scene, this.paycallbackurl});

  GetPayTypeDataVo.fromJson(Map<String, dynamic> json) {
    idGuid = json['id_guid'];
    scene = json['scene'];
    paycallbackurl = json['paycallbackurl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id_guid'] = idGuid;
    data['scene'] = scene;
    data['paycallbackurl'] = paycallbackurl;
    return data;
  }
}

class PayTypeVo {
  String? title;
  String? desc;
  String? key;
  String? icon;
  int? id;

  PayTypeVo({
    this.title,
    this.desc,
    this.key,
    this.icon,
    this.id,
  });

  PayTypeVo.fromJson(Map<String, dynamic> json) {
    title = json['Title'];
    desc = json['Desc'];
    key = json['Key'];
    icon = json['Icon'];
    id = json['Id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Title'] = title;
    data['Desc'] = desc;
    data['Key'] = key;
    data['Icon'] = icon;
    data['Id'] = id;
    return data;
  }
}
