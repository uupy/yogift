class CharityFavoritesItemDetailVo {
  int? id;
  String? fGuid;
  int? orderStatus;
  String? bussinessName;
  String? bussinessNo;
  int? buyPrice;
  String? originalPrice;
  int? buyPriceForCharity;
  int? forCharityMin;
  int? charityId;
  String? charityImg;
  String? charityName;
  String? cCoverImg;
  String? cGuid;
  String? giftName;
  String? gGuid;
  int? quantity;
  int? quantityGet;
  String? receivingTime;
  String? deliveryTime;
  String? estimatedDeliveryTime;
  String? exchangeTerms;
  int? giftId;
  int? skuId;
  String? skuContent;
  String? logisticsNumber;
  String? logisticsCompany;
  List<Orders>? orders;
  String? lastOrderCreateTime;
  String? createTime;
  int? status;
  String? remark;
  String? expiryDate;

  CharityFavoritesItemDetailVo(
      {this.id,
      this.fGuid,
      this.orderStatus,
      this.bussinessName,
      this.bussinessNo,
      this.buyPrice,
      this.originalPrice,
      this.buyPriceForCharity,
      this.forCharityMin,
      this.charityId,
      this.charityImg,
      this.charityName,
      this.cCoverImg,
      this.cGuid,
      this.giftName,
      this.gGuid,
      this.quantity,
      this.quantityGet,
      this.receivingTime,
      this.deliveryTime,
      this.estimatedDeliveryTime,
      this.exchangeTerms,
      this.giftId,
      this.skuId,
      this.skuContent,
      this.logisticsNumber,
      this.logisticsCompany,
      this.orders,
      this.lastOrderCreateTime,
      this.createTime,
      this.status,
      this.remark,
      this.expiryDate});

  CharityFavoritesItemDetailVo.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    fGuid = json['F_Guid'];
    orderStatus = json['OrderStatus'];
    bussinessName = json['BussinessName'];
    bussinessNo = json['BussinessNo'];
    buyPrice = json['BuyPrice'];
    originalPrice = json['OriginalPrice'];
    buyPriceForCharity = json['BuyPrice_For_Charity'];
    forCharityMin = json['For_Charity_Min'];
    charityId = json['CharityId'];
    charityImg = json['CharityImg'];
    charityName = json['CharityName'];
    cCoverImg = json['C_CoverImg'];
    cGuid = json['C_Guid'];
    giftName = json['GiftName'];
    gGuid = json['G_Guid'];
    quantity = json['Quantity'];
    quantityGet = json['Quantity_get'];
    receivingTime = json['ReceivingTime'];
    deliveryTime = json['DeliveryTime'];
    estimatedDeliveryTime = json['EstimatedDeliveryTime'];
    exchangeTerms = json['ExchangeTerms'];
    giftId = json['GiftId'];
    skuId = json['SkuId'];
    skuContent = json['SkuContent'];
    logisticsNumber = json['Logistics_Number'];
    logisticsCompany = json['Logistics_Company'];
    if (json['Orders'] != null) {
      orders = <Orders>[];
      json['Orders'].forEach((v) {
        orders?.add(Orders.fromJson(v));
      });
    }
    lastOrderCreateTime = json['LastOrderCreateTime'];
    createTime = json['CreateTime'];
    status = json['Status'];
    remark = json['Remark'];
    expiryDate = json['Expiry_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = id;
    data['F_Guid'] = fGuid;
    data['OrderStatus'] = orderStatus;
    data['BussinessName'] = bussinessName;
    data['BussinessNo'] = bussinessNo;
    data['BuyPrice'] = buyPrice;
    data['OriginalPrice'] = originalPrice;
    data['BuyPrice_For_Charity'] = buyPriceForCharity;
    data['For_Charity_Min'] = forCharityMin;
    data['CharityId'] = charityId;
    data['CharityImg'] = charityImg;
    data['CharityName'] = charityName;
    data['C_CoverImg'] = cCoverImg;
    data['C_Guid'] = cGuid;
    data['GiftName'] = giftName;
    data['G_Guid'] = gGuid;
    data['Quantity'] = quantity;
    data['Quantity_get'] = quantityGet;
    data['ReceivingTime'] = receivingTime;
    data['DeliveryTime'] = deliveryTime;
    data['EstimatedDeliveryTime'] = estimatedDeliveryTime;
    data['ExchangeTerms'] = exchangeTerms;
    data['GiftId'] = giftId;
    data['SkuId'] = skuId;
    data['SkuContent'] = skuContent;
    data['Logistics_Number'] = logisticsNumber;
    data['Logistics_Company'] = logisticsCompany;
    if (orders != null) {
      data['Orders'] = orders?.map((v) => v.toJson()).toList();
    }
    data['LastOrderCreateTime'] = lastOrderCreateTime;
    data['CreateTime'] = createTime;
    data['Status'] = status;
    data['Remark'] = remark;
    data['Expiry_date'] = expiryDate;
    return data;
  }
}

class Orders {
  int? id;
  String? oGuid;
  int? userId;
  String? nickName;
  String? bgGive;
  String? msgGive;
  String? createTime;
  int? nums;
  String? expirationTime;
  String? bussinessName;
  String? bigImg;

  Orders(
      {this.id,
      this.oGuid,
      this.userId,
      this.nickName,
      this.bgGive,
      this.msgGive,
      this.createTime,
      this.nums,
      this.expirationTime,
      this.bussinessName,
      this.bigImg});

  Orders.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    oGuid = json['O_Guid'];
    userId = json['User_id'];
    nickName = json['NickName'];
    bgGive = json['Bg_give'];
    msgGive = json['Msg_give'];
    createTime = json['CreateTime'];
    nums = json['Nums'];
    expirationTime = json['Expiration_time'];
    bussinessName = json['BussinessName'];
    bigImg = json['BigImg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = id;
    data['O_Guid'] = oGuid;
    data['User_id'] = userId;
    data['NickName'] = nickName;
    data['Bg_give'] = bgGive;
    data['Msg_give'] = msgGive;
    data['CreateTime'] = createTime;
    data['Nums'] = nums;
    data['Expiration_time'] = expirationTime;
    data['BussinessName'] = bussinessName;
    data['BigImg'] = bigImg;
    return data;
  }
}
