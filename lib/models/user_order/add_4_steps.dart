class Add4StepsVo {
  String? phone;
  String? phoneprefix;

  /// 登入方式：1验证码，2密码
  int? logintype;
  String? codePassword;

  /// 同意推广 1,0
  int? acceptnotice;

  /// 收货区域1
  int? receivingaddressArea0Id;

  /// 收货区域2
  int? receivingaddressArea1Id;
  String? receivingaddressContact;
  String? receivingaddressPhone;
  String? receivingaddressAddress;

  /// 礼物数量，1
  int? num;

  /// 礼物Id或guid
  String? giftIdGuid;
  int? skuid;
  double? money;

  /// 注册来源,h5=1
  String? regfrom;
  String? bgGive;
  String? msgGive;
  String? requestGuid;

  /// 介绍人,可以是编号或者昵称。
  String? introducer;

  /// 推荐码
  String? recommendationcode;
  String? content2;

  Add4StepsVo(
      {this.phone,
      this.phoneprefix,
      this.logintype,
      this.codePassword,
      this.acceptnotice,
      this.receivingaddressArea0Id,
      this.receivingaddressArea1Id,
      this.receivingaddressContact,
      this.receivingaddressPhone,
      this.receivingaddressAddress,
      this.num,
      this.giftIdGuid,
      this.skuid,
      this.money,
      this.regfrom,
      this.bgGive,
      this.msgGive,
      this.requestGuid,
      this.introducer,
      this.recommendationcode,
      this.content2});

  Add4StepsVo.fromJson(Map<String, dynamic> json) {
    phone = json['phone'];
    phoneprefix = json['phoneprefix'];
    logintype = json['logintype'];
    codePassword = json['code_password'];
    acceptnotice = json['acceptnotice'];
    receivingaddressArea0Id = json['receivingaddress_area0_id'];
    receivingaddressArea1Id = json['receivingaddress_area1_id'];
    receivingaddressContact = json['receivingaddress_contact'];
    receivingaddressPhone = json['receivingaddress_phone'];
    receivingaddressAddress = json['receivingaddress_address'];
    num = json['num'];
    giftIdGuid = json['gift_id_guid'];
    skuid = json['skuid'];
    money = json['money'];
    regfrom = json['regfrom'];
    bgGive = json['bg_give'];
    msgGive = json['msg_give'];
    requestGuid = json['request_guid'];
    introducer = json['introducer'];
    recommendationcode = json['recommendationcode'];
    content2 = json['content2'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['phone'] = phone;
    data['phoneprefix'] = phoneprefix;
    data['logintype'] = logintype;
    data['code_password'] = codePassword;
    data['acceptnotice'] = acceptnotice;
    data['receivingaddress_area0_id'] = receivingaddressArea0Id;
    data['receivingaddress_area1_id'] = receivingaddressArea1Id;
    data['receivingaddress_contact'] = receivingaddressContact;
    data['receivingaddress_phone'] = receivingaddressPhone;
    data['receivingaddress_address'] = receivingaddressAddress;
    data['num'] = num;
    data['gift_id_guid'] = giftIdGuid;
    data['skuid'] = skuid;
    data['money'] = money;
    data['regfrom'] = regfrom;
    data['bg_give'] = bgGive;
    data['msg_give'] = msgGive;
    data['request_guid'] = requestGuid;
    data['introducer'] = introducer;
    data['recommendationcode'] = recommendationcode;
    data['content2'] = content2;
    return data;
  }
}
