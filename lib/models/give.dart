class GiveItemVo {
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
  String? nickName;
  String? phone;
  String? phonePrefix;
  String? headSrc;
  String? receivingTime;
  String? deliveryTime;
  String? expirationTime;
  String? giveTime;
  String? estimatedDeliveryTime;
  int? skuId;
  String? skuContent;
  int? isGive;
  int? buy1Get1FREE;
  int? isFree;
  int? canIGive;
  int? canIExchange;

  GiveItemVo(
      {this.id,
      this.oGuid,
      this.cCoverImg,
      this.sendingMethod,
      this.giftName,
      this.buyPrice,
      this.nums,
      this.createTime,
      this.orderMoney,
      this.orderStatus,
      this.nickName,
      this.phone,
      this.phonePrefix,
      this.headSrc,
      this.receivingTime,
      this.deliveryTime,
      this.expirationTime,
      this.giveTime,
      this.estimatedDeliveryTime,
      this.skuId,
      this.skuContent,
      this.isGive,
      this.buy1Get1FREE,
      this.isFree,
      this.canIGive,
      this.canIExchange});

  GiveItemVo.fromJson(Map<String, dynamic> json) {
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
    nickName = json['NickName'];
    phone = json['Phone'];
    phonePrefix = json['PhonePrefix'];
    headSrc = json['Head_Src'];
    receivingTime = json['ReceivingTime'];
    deliveryTime = json['DeliveryTime'];
    expirationTime = json['Expiration_time'];
    giveTime = json['GiveTime'];
    estimatedDeliveryTime = json['EstimatedDeliveryTime'];
    skuId = json['SkuId'];
    skuContent = json['SkuContent'];
    isGive = json['Is_give'];
    buy1Get1FREE = json['Buy1Get1FREE'];
    isFree = json['IsFree'];
    canIGive = json['CanIGive'];
    canIExchange = json['CanIExchange'];
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
    data['NickName'] = nickName;
    data['Phone'] = phone;
    data['PhonePrefix'] = phonePrefix;
    data['Head_Src'] = headSrc;
    data['ReceivingTime'] = receivingTime;
    data['DeliveryTime'] = deliveryTime;
    data['Expiration_time'] = expirationTime;
    data['GiveTime'] = giveTime;
    data['EstimatedDeliveryTime'] = estimatedDeliveryTime;
    data['SkuId'] = skuId;
    data['SkuContent'] = skuContent;
    data['Is_give'] = isGive;
    data['Buy1Get1FREE'] = buy1Get1FREE;
    data['IsFree'] = isFree;
    data['CanIGive'] = canIGive;
    data['CanIExchange'] = canIExchange;
    return data;
  }
}
