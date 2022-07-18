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
