class UserFavoritesItemVo {
  int? id;
  String? fGuid;
  String? cCoverImg;
  int? sendingMethod;
  String? giftName;
  String? gGuid;
  double? buyPrice;
  String? bussinessName;

  UserFavoritesItemVo(
      {this.id,
      this.fGuid,
      this.cCoverImg,
      this.sendingMethod,
      this.giftName,
      this.gGuid,
      this.buyPrice,
      this.bussinessName});

  UserFavoritesItemVo.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    fGuid = json['F_Guid'];
    cCoverImg = json['C_CoverImg'];
    sendingMethod = json['SendingMethod'];
    giftName = json['GiftName'];
    gGuid = json['G_Guid'];
    buyPrice = json['BuyPrice'];
    bussinessName = json['BussinessName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = id;
    data['F_Guid'] = fGuid;
    data['C_CoverImg'] = cCoverImg;
    data['SendingMethod'] = sendingMethod;
    data['GiftName'] = giftName;
    data['G_Guid'] = gGuid;
    data['BuyPrice'] = buyPrice;
    data['BussinessName'] = bussinessName;
    return data;
  }
}
