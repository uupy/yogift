class OrderListItemVo {
  int? orderStatus;
  int? id;
  String? oGuid;
  String? cCoverImg;
  int? sendingMethod;
  String? giftName;
  int? buyPrice;
  int? nums;
  String? createTime;
  int? orderMoney;
  String? receivingTime;
  String? estimatedDeliveryTime;
  String? deliveryTime;
  String? expirationTime;
  int? payStatus;

  OrderListItemVo(
      {this.orderStatus,
      this.id,
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
      this.payStatus});

  OrderListItemVo.fromJson(Map<String, dynamic> json) {
    orderStatus = json['OrderStatus'];
    id = json['Id'];
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
    payStatus = json['PayStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['OrderStatus'] = orderStatus;
    data['Id'] = id;
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
    data['PayStatus'] = payStatus;
    return data;
  }
}
