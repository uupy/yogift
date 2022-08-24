class DonationItemVo {
  int? id;
  String? oGuid;
  String? cCoverImg;
  int? sendingMethod;
  String? giftName;
  double? buyPrice;
  int? nums;
  String? createTime;
  double? orderMoney;
  int? orderStatus;
  int? charityId;
  String? charityImg;
  String? charityName;
  String? charityAddress;
  String? charityGuid;
  String? charityFavoritesGuid;
  int? quantity;
  int? quantityGet;
  String? bussinessNo;
  String? bussinessName;
  String? receivingTime;
  String? deliveryTime;
  String? expirationTime;
  String? estimatedDeliveryTime;
  int? skuId;
  String? skuContent;

  DonationItemVo({
    this.id,
    this.oGuid,
    this.cCoverImg,
    this.sendingMethod,
    this.giftName,
    this.buyPrice,
    this.nums,
    this.createTime,
    this.orderMoney,
    this.orderStatus,
    this.charityId,
    this.charityImg,
    this.charityName,
    this.charityAddress,
    this.charityGuid,
    this.charityFavoritesGuid,
    this.quantity,
    this.quantityGet,
    this.bussinessNo,
    this.bussinessName,
    this.receivingTime,
    this.deliveryTime,
    this.expirationTime,
    this.estimatedDeliveryTime,
    this.skuId,
    this.skuContent,
  });

  DonationItemVo.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    oGuid = json['O_Guid'];
    cCoverImg = json['C_CoverImg'];
    sendingMethod = json['SendingMethod'];
    giftName = json['GiftName'];
    buyPrice = json['BuyPrice'];
    nums = json['Nums'];
    createTime = json['CreateTime'];
    orderMoney = json['OrderMoney'];
    orderStatus = json['OrderStatus'];
    charityId = json['CharityId'];
    charityImg = json['CharityImg'];
    charityName = json['CharityName'];
    charityAddress = json['CharityAddress'];
    charityGuid = json['CharityGuid'];
    charityFavoritesGuid = json['CharityFavorites_Guid'];
    quantity = json['Quantity'];
    quantityGet = json['Quantity_get'];
    bussinessNo = json['BussinessNo'];
    bussinessName = json['BussinessName'];
    receivingTime = json['ReceivingTime'];
    deliveryTime = json['DeliveryTime'];
    expirationTime = json['Expiration_time'];
    estimatedDeliveryTime = json['EstimatedDeliveryTime'];
    skuId = json['SkuId'];
    skuContent = json['SkuContent'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = id;
    data['O_Guid'] = oGuid;
    data['C_CoverImg'] = cCoverImg;
    data['SendingMethod'] = sendingMethod;
    data['GiftName'] = giftName;
    data['BuyPrice'] = buyPrice;
    data['Nums'] = nums;
    data['CreateTime'] = createTime;
    data['OrderMoney'] = orderMoney;
    data['OrderStatus'] = orderStatus;
    data['CharityId'] = charityId;
    data['CharityImg'] = charityImg;
    data['CharityName'] = charityName;
    data['CharityAddress'] = charityAddress;
    data['CharityGuid'] = charityGuid;
    data['CharityFavorites_Guid'] = charityFavoritesGuid;
    data['Quantity'] = quantity;
    data['Quantity_get'] = quantityGet;
    data['BussinessNo'] = bussinessNo;
    data['BussinessName'] = bussinessName;
    data['ReceivingTime'] = receivingTime;
    data['DeliveryTime'] = deliveryTime;
    data['Expiration_time'] = expirationTime;
    data['EstimatedDeliveryTime'] = estimatedDeliveryTime;
    data['SkuId'] = skuId;
    data['SkuContent'] = skuContent;
    return data;
  }
}
