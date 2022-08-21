class OrderListItemVo {
  int? orderStatus;
  int? id;
  String? gGuid;
  String? oGuid;
  String? cCoverImg;
  int? sendingMethod;
  String? giftName;
  double? buyPrice;
  int? nums;
  String? createTime;
  double? orderMoney;
  String? receivingTime;
  String? estimatedDeliveryTime;
  String? deliveryTime;
  String? expirationTime;
  String? skuContent;
  int? skuId;
  int? payStatus;
  int? canIGive;
  int? canIExchange;

  OrderListItemVo({
    this.orderStatus,
    this.id,
    this.gGuid,
    this.oGuid,
    this.cCoverImg,
    this.sendingMethod,
    this.giftName,
    this.buyPrice,
    this.nums,
    this.createTime,
    this.orderMoney,
    this.receivingTime,
    this.estimatedDeliveryTime,
    this.deliveryTime,
    this.expirationTime,
    this.skuContent,
    this.skuId,
    this.payStatus,
    this.canIGive,
    this.canIExchange,
  });

  OrderListItemVo.fromJson(Map<String, dynamic> json) {
    orderStatus = json['OrderStatus'];
    id = json['Id'];
    gGuid = json['G_Guid'];
    oGuid = json['O_Guid'];
    cCoverImg = json['C_CoverImg'];
    sendingMethod = json['SendingMethod'];
    giftName = json['GiftName'];
    buyPrice = json['BuyPrice'];
    nums = json['Nums'];
    createTime = json['CreateTime'];
    orderMoney = json['OrderMoney'];
    receivingTime = json['ReceivingTime'];
    estimatedDeliveryTime = json['EstimatedDeliveryTime'];
    deliveryTime = json['DeliveryTime'];
    expirationTime = json['Expiration_time'];
    skuContent = json['SkuContent'];
    skuId = json['SkuId'];
    payStatus = json['PayStatus'];
    canIGive = json['CanIGive'];
    canIExchange = json['CanIExchange'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['OrderStatus'] = orderStatus;
    data['Id'] = id;
    data['G_Guid'] = gGuid;
    data['O_Guid'] = oGuid;
    data['C_CoverImg'] = cCoverImg;
    data['SendingMethod'] = sendingMethod;
    data['GiftName'] = giftName;
    data['BuyPrice'] = buyPrice;
    data['Nums'] = nums;
    data['CreateTime'] = createTime;
    data['OrderMoney'] = orderMoney;
    data['ReceivingTime'] = receivingTime;
    data['EstimatedDeliveryTime'] = estimatedDeliveryTime;
    data['DeliveryTime'] = deliveryTime;
    data['Expiration_time'] = expirationTime;
    data['SkuContent'] = skuContent;
    data['SkuId'] = skuId;
    data['PayStatus'] = payStatus;
    data['CanIGive'] = canIGive;
    data['CanIExchange'] = canIExchange;
    return data;
  }
}
