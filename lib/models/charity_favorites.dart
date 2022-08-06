class CharityFavoritesItemVo {
  int? id;
  String? fGuid;
  int? charityId;
  String? charityName;
  String? charityImg;
  String? cGuid;
  String? gGuid;
  String? giftName;
  String? cCoverImg;
  String? originalPrice;
  double? buyPrice;
  double? buyPriceForCharity;
  String? bussinessName;
  String? bussinessNo;
  int? quantity;
  int? quantityGet;
  String? createTime;
  int? status;
  String? remark;
  String? expiryDate;
  int? skuId;
  String? skuContent;

  CharityFavoritesItemVo(
      {this.id,
      this.fGuid,
      this.charityId,
      this.charityName,
      this.charityImg,
      this.cGuid,
      this.gGuid,
      this.giftName,
      this.cCoverImg,
      this.originalPrice,
      this.buyPrice,
      this.buyPriceForCharity,
      this.bussinessName,
      this.bussinessNo,
      this.quantity,
      this.quantityGet,
      this.createTime,
      this.status,
      this.remark,
      this.expiryDate,
      this.skuId,
      this.skuContent});

  CharityFavoritesItemVo.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    fGuid = json['F_Guid'];
    charityId = json['CharityId'];
    charityName = json['CharityName'];
    charityImg = json['CharityImg'];
    cGuid = json['C_Guid'];
    gGuid = json['G_Guid'];
    giftName = json['GiftName'];
    cCoverImg = json['C_CoverImg'];
    originalPrice = json['OriginalPrice'];
    buyPrice = json['BuyPrice'];
    buyPriceForCharity = json['BuyPrice_For_Charity'];
    bussinessName = json['BussinessName'];
    bussinessNo = json['BussinessNo'];
    quantity = json['Quantity'];
    quantityGet = json['Quantity_get'];
    createTime = json['CreateTime'];
    status = json['Status'];
    remark = json['Remark'];
    expiryDate = json['Expiry_date'];
    skuId = json['SkuId'];
    skuContent = json['SkuContent'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = id;
    data['F_Guid'] = fGuid;
    data['CharityId'] = charityId;
    data['CharityName'] = charityName;
    data['CharityImg'] = charityImg;
    data['C_Guid'] = cGuid;
    data['G_Guid'] = gGuid;
    data['GiftName'] = giftName;
    data['C_CoverImg'] = cCoverImg;
    data['OriginalPrice'] = originalPrice;
    data['BuyPrice'] = buyPrice;
    data['BuyPrice_For_Charity'] = buyPriceForCharity;
    data['BussinessName'] = bussinessName;
    data['BussinessNo'] = bussinessNo;
    data['Quantity'] = quantity;
    data['Quantity_get'] = quantityGet;
    data['CreateTime'] = createTime;
    data['Status'] = status;
    data['Remark'] = remark;
    data['Expiry_date'] = expiryDate;
    data['SkuId'] = skuId;
    data['SkuContent'] = skuContent;
    return data;
  }
}
