class HomeGiftVo {
  int? id;
  String? gGuid;
  String? giftName;
  String? cCoverImg;
  String? originalPrice;
  double? buyPrice;
  String? bussinessName;
  int? sendingMethod;
  int? buy1Get1FREE;
  int? favorite;

  HomeGiftVo({
    this.id,
    this.gGuid,
    this.giftName,
    this.cCoverImg,
    this.originalPrice,
    this.buyPrice,
    this.bussinessName,
    this.sendingMethod,
    this.buy1Get1FREE,
    this.favorite,
  });

  HomeGiftVo.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    gGuid = json['G_Guid'];
    giftName = json['GiftName'];
    cCoverImg = json['C_CoverImg'];
    originalPrice = json['OriginalPrice'];
    buyPrice = json['BuyPrice'];
    bussinessName = json['BussinessName'];
    sendingMethod = json['SendingMethod'];
    buy1Get1FREE = json['Buy1Get1FREE'];
    favorite = json['Favorite'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = id;
    data['G_Guid'] = gGuid;
    data['GiftName'] = giftName;
    data['C_CoverImg'] = cCoverImg;
    data['OriginalPrice'] = originalPrice;
    data['BuyPrice'] = buyPrice;
    data['BussinessName'] = bussinessName;
    data['SendingMethod'] = sendingMethod;
    data['Buy1Get1FREE'] = buy1Get1FREE;
    data['Favorite'] = favorite;
    return data;
  }
}

class GiftVo {
  int? id;
  String? bussinessName;
  String? bussinessImg;
  String? className;
  String? gGuid;
  String? bussinessNo;
  String? gCGuid;
  String? giftName;
  String? originalPrice;
  double? buyPrice;
  double? buyPriceForCharity;
  int? forCharity;
  String? cCoverImg;
  String? cDescript;
  String? cDetail;
  String? cDetailImg;
  String? createTime;
  String? createUserId;
  int? effectStatus;
  num? amount;
  int? popularityN;
  int? recommendN;
  int? printingN;
  int? jifenN;
  String? expirationTime;
  String? scene;
  double? commissionValue;
  int? commissionType;
  int? sendingMethod;
  int? isEnable;
  dynamic exchangeTerms;
  int? buy1Get1FREE;
  int? writeoffCodeType;
  int? estimatedDeliveryTimeTN;
  String? keywords;
  int? favorite;

  GiftVo(
      {this.id,
      this.bussinessName,
      this.bussinessImg,
      this.className,
      this.gGuid,
      this.bussinessNo,
      this.gCGuid,
      this.giftName,
      this.originalPrice,
      this.buyPrice,
      this.buyPriceForCharity,
      this.forCharity,
      this.cCoverImg,
      this.cDescript,
      this.cDetail,
      this.cDetailImg,
      this.createTime,
      this.createUserId,
      this.effectStatus,
      this.amount,
      this.popularityN,
      this.recommendN,
      this.printingN,
      this.jifenN,
      this.expirationTime,
      this.scene,
      this.commissionValue,
      this.commissionType,
      this.sendingMethod,
      this.isEnable,
      this.exchangeTerms,
      this.buy1Get1FREE,
      this.writeoffCodeType,
      this.estimatedDeliveryTimeTN,
      this.keywords,
      this.favorite});

  GiftVo.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    bussinessName = json['BussinessName'];
    bussinessImg = json['BussinessImg'];
    className = json['ClassName'];
    gGuid = json['G_Guid'];
    bussinessNo = json['BussinessNo'];
    gCGuid = json['GC_Guid'];
    giftName = json['GiftName'];
    originalPrice = json['OriginalPrice'];
    buyPrice = json['BuyPrice'];
    buyPriceForCharity = json['BuyPrice_For_Charity'];
    forCharity = json['For_Charity'];
    cCoverImg = json['C_CoverImg'];
    cDescript = json['C_Descript'];
    cDetail = json['C_Detail'];
    cDetailImg = json['C_Detail_Img'];
    createTime = json['CreateTime'];
    createUserId = json['CreateUserId'];
    effectStatus = json['EffectStatus'];
    amount = json['Amount'];
    popularityN = json['Popularity_n'];
    recommendN = json['Recommend_n'];
    printingN = json['Printing_n'];
    jifenN = json['Jifen_n'];
    expirationTime = json['Expiration_time'];
    scene = json['Scene'];
    commissionValue = json['Commission_value'];
    commissionType = json['Commission_type'];
    sendingMethod = json['SendingMethod'];
    isEnable = json['IsEnable'];
    exchangeTerms = json['ExchangeTerms'];
    buy1Get1FREE = json['Buy1Get1FREE'];
    writeoffCodeType = json['Writeoff_CodeType'];
    estimatedDeliveryTimeTN = json['EstimatedDeliveryTime_TN'];
    keywords = json['Keywords'];
    favorite = json['Favorite'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = id;
    data['BussinessName'] = bussinessName;
    data['BussinessImg'] = bussinessImg;
    data['ClassName'] = className;
    data['G_Guid'] = gGuid;
    data['BussinessNo'] = bussinessNo;
    data['GC_Guid'] = gCGuid;
    data['GiftName'] = giftName;
    data['OriginalPrice'] = originalPrice;
    data['BuyPrice'] = buyPrice;
    data['BuyPrice_For_Charity'] = buyPriceForCharity;
    data['For_Charity'] = forCharity;
    data['C_CoverImg'] = cCoverImg;
    data['C_Descript'] = cDescript;
    data['C_Detail'] = cDetail;
    data['C_Detail_Img'] = cDetailImg;
    data['CreateTime'] = createTime;
    data['CreateUserId'] = createUserId;
    data['EffectStatus'] = effectStatus;
    data['Amount'] = amount;
    data['Popularity_n'] = popularityN;
    data['Recommend_n'] = recommendN;
    data['Printing_n'] = printingN;
    data['Jifen_n'] = jifenN;
    data['Expiration_time'] = expirationTime;
    data['Scene'] = scene;
    data['Commission_value'] = commissionValue;
    data['Commission_type'] = commissionType;
    data['SendingMethod'] = sendingMethod;
    data['IsEnable'] = isEnable;
    data['ExchangeTerms'] = exchangeTerms;
    data['Buy1Get1FREE'] = buy1Get1FREE;
    data['Writeoff_CodeType'] = writeoffCodeType;
    data['EstimatedDeliveryTime_TN'] = estimatedDeliveryTimeTN;
    data['Keywords'] = keywords;
    data['Favorite'] = favorite;
    return data;
  }
}

class GiftCategoryVo {
  int? id;
  String? gcGuid;
  String? className;
  String? classImg;

  GiftCategoryVo({
    this.id,
    this.gcGuid,
    this.className,
    this.classImg,
  });

  GiftCategoryVo.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    gcGuid = json['GC_Guid'];
    className = json['ClassName'];
    classImg = json['ClassImg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = id;
    data['GC_Guid'] = gcGuid;
    data['ClassName'] = className;
    data['ClassImg'] = classImg;
    return data;
  }
}

class GiftSceneVo {
  int? id;
  String? sGuid;
  String? className;
  String? classImg;

  GiftSceneVo({
    this.id,
    this.sGuid,
    this.className,
    this.classImg,
  });

  GiftSceneVo.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    sGuid = json['S_Guid'];
    className = json['ClassName'];
    classImg = json['ClassImg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = id;
    data['S_Guid'] = sGuid;
    data['ClassName'] = className;
    data['ClassImg'] = classImg;
    return data;
  }
}
