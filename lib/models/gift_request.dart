class GiftRequestAddVo {
  String? gGuid;
  String? gCGuid;
  String? msgRequest;
  String? content2;
  int? skuid;

  GiftRequestAddVo({
    this.gGuid,
    this.gCGuid,
    this.msgRequest,
    this.skuid,
    this.content2,
  });

  GiftRequestAddVo.fromJson(Map<String, dynamic> json) {
    gGuid = json['g_guid'];
    gCGuid = json['GC_Guid'];
    msgRequest = json['msg_request'];
    content2 = json['content2'];
    skuid = json['skuid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['g_guid'] = gGuid;
    data['GC_Guid'] = gCGuid;
    data['msg_request'] = msgRequest;
    data['content2'] = content2;
    data['skuid'] = skuid;
    return data;
  }
}

class GiftRequestResultVo {
  int? id;
  String? rGuid;
  String? wGuid;
  int? userId;
  String? nickName;
  String? headSrc;
  String? phone;
  String? phonePrefix;
  String? gGuid;
  String? giftName;
  String? cCoverImg;
  double? buyPrice;
  String? gCGuid;
  String? title1;
  String? bigImg;
  String? msgRequest;
  int? skuId;
  String? skuContent;
  String? createTime;

  GiftRequestResultVo(
      {this.id,
      this.rGuid,
      this.wGuid,
      this.userId,
      this.nickName,
      this.headSrc,
      this.phone,
      this.phonePrefix,
      this.gGuid,
      this.giftName,
      this.cCoverImg,
      this.buyPrice,
      this.gCGuid,
      this.title1,
      this.bigImg,
      this.msgRequest,
      this.skuId,
      this.skuContent,
      this.createTime});

  GiftRequestResultVo.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    rGuid = json['R_Guid'];
    wGuid = json['W_Guid'];
    userId = json['User_id'];
    nickName = json['NickName'];
    headSrc = json['Head_Src'];
    phone = json['Phone'];
    phonePrefix = json['PhonePrefix'];
    gGuid = json['G_Guid'];
    giftName = json['GiftName'];
    cCoverImg = json['C_CoverImg'];
    buyPrice = json['BuyPrice'];
    gCGuid = json['GC_Guid'];
    title1 = json['Title1'];
    bigImg = json['BigImg'];
    msgRequest = json['Msg_request'];
    skuId = json['SkuId'];
    skuContent = json['SkuContent'];
    createTime = json['CreateTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = id;
    data['R_Guid'] = rGuid;
    data['W_Guid'] = wGuid;
    data['User_id'] = userId;
    data['NickName'] = nickName;
    data['Head_Src'] = headSrc;
    data['Phone'] = phone;
    data['PhonePrefix'] = phonePrefix;
    data['G_Guid'] = gGuid;
    data['GiftName'] = giftName;
    data['C_CoverImg'] = cCoverImg;
    data['BuyPrice'] = buyPrice;
    data['GC_Guid'] = gCGuid;
    data['Title1'] = title1;
    data['BigImg'] = bigImg;
    data['Msg_request'] = msgRequest;
    data['SkuId'] = skuId;
    data['SkuContent'] = skuContent;
    data['CreateTime'] = createTime;
    return data;
  }
}
