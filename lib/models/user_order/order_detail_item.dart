class OrderDetailItemVo {
  int? id;
  String? oGuid;
  int? userId;
  String? nickName;
  String? wGuid;
  String? gGuid;
  double? buyPrice0;
  double? orderMoney;
  int? printingN0;
  int? jifenN0;
  String? giftName0;
  String? cCoverImg0;
  String? expirationTime;
  String? createTime;
  String? orderNo;
  String? phone;
  String? phonePrefix;
  String? prepayId;
  int? payStatus;
  int? userId1;
  String? nickName1;
  String? wGuid1;
  String? giveTime;
  String? payTime;
  int? isGive;
  String? bgGive;
  String? msgGive;
  String? giftrequestGuid;
  String? payType;
  int? nums;
  int? openId;
  int? isCallBack;
  String? outTransactionId;
  String? transactionId;
  String? bussinessNo;
  String? bussinessName;
  int? charityId;
  String? charityFavoritesGuid;
  int? buy1Get1FREE;
  int? writeoff;
  int? writeoffVerifyuserinfoId;
  String? writeoffVerifyuserinfoName;
  String? writeoffTime;
  String? writeoffCode;
  String? writeoffCodeCreateTime;
  int? receivingaddressArea0Id;
  int? receivingaddressArea1Id;
  String? receivingaddressArea0;
  String? receivingaddressArea1;
  String? receivingaddressContact;
  String? receivingaddressPhone;
  String? receivingaddressAddress;
  String? thankyoumessage;
  int? sendingMethod;
  String? deliveryTime;
  String? receivingTime;
  int? orderStatus;
  int? orderStatusOld;
  String? logisticsNumber;
  String? logisticsCompany;
  String? estimatedDeliveryTime;
  int? isFree;
  int? orderIdRelation;
  int? skuId;
  String? skuContent;
  String? content1;
  int? orderClose;
  String? content2;
  int? canIGive;
  int? canIExchange;
  String? userIP;

  OrderDetailItemVo(
      {this.id,
      this.oGuid,
      this.userId,
      this.nickName,
      this.wGuid,
      this.gGuid,
      this.buyPrice0,
      this.orderMoney,
      this.printingN0,
      this.jifenN0,
      this.giftName0,
      this.cCoverImg0,
      this.expirationTime,
      this.createTime,
      this.orderNo,
      this.phone,
      this.phonePrefix,
      this.prepayId,
      this.payStatus,
      this.userId1,
      this.nickName1,
      this.wGuid1,
      this.giveTime,
      this.payTime,
      this.isGive,
      this.bgGive,
      this.msgGive,
      this.giftrequestGuid,
      this.payType,
      this.nums,
      this.openId,
      this.isCallBack,
      this.outTransactionId,
      this.transactionId,
      this.bussinessNo,
      this.bussinessName,
      this.charityId,
      this.charityFavoritesGuid,
      this.buy1Get1FREE,
      this.writeoff,
      this.writeoffVerifyuserinfoId,
      this.writeoffVerifyuserinfoName,
      this.writeoffTime,
      this.writeoffCode,
      this.writeoffCodeCreateTime,
      this.receivingaddressArea0Id,
      this.receivingaddressArea1Id,
      this.receivingaddressArea0,
      this.receivingaddressArea1,
      this.receivingaddressContact,
      this.receivingaddressPhone,
      this.receivingaddressAddress,
      this.thankyoumessage,
      this.sendingMethod,
      this.deliveryTime,
      this.receivingTime,
      this.orderStatus,
      this.orderStatusOld,
      this.logisticsNumber,
      this.logisticsCompany,
      this.estimatedDeliveryTime,
      this.isFree,
      this.orderIdRelation,
      this.skuId,
      this.skuContent,
      this.content1,
      this.orderClose,
      this.content2,
      this.canIGive,
      this.canIExchange,
      this.userIP});

  OrderDetailItemVo.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    oGuid = json['O_Guid'];
    userId = json['User_id'];
    nickName = json['NickName'];
    wGuid = json['W_Guid'];
    gGuid = json['G_Guid'];
    buyPrice0 = json['BuyPrice0'];
    orderMoney = json['OrderMoney'];
    printingN0 = json['Printing_n0'];
    jifenN0 = json['Jifen_n0'];
    giftName0 = json['GiftName0'];
    cCoverImg0 = json['C_CoverImg0'];
    expirationTime = json['Expiration_time'];
    createTime = json['CreateTime'];
    orderNo = json['OrderNo'];
    phone = json['Phone'];
    phonePrefix = json['PhonePrefix'];
    prepayId = json['Prepay_id'];
    payStatus = json['PayStatus'];
    userId1 = json['User_id1'];
    nickName1 = json['NickName1'];
    wGuid1 = json['W_Guid1'];
    giveTime = json['GiveTime'];
    payTime = json['PayTime'];
    isGive = json['Is_give'];
    bgGive = json['Bg_give'];
    msgGive = json['Msg_give'];
    giftrequestGuid = json['Giftrequest_Guid'];
    payType = json['PayType'];
    nums = json['Nums'];
    openId = json['OpenId'];
    isCallBack = json['IsCallBack'];
    outTransactionId = json['Out_transaction_id'];
    transactionId = json['Transaction_id'];
    bussinessNo = json['BussinessNo'];
    bussinessName = json['BussinessName'];
    charityId = json['CharityId'];
    charityFavoritesGuid = json['CharityFavorites_Guid'];
    buy1Get1FREE = json['Buy1Get1FREE'];
    writeoff = json['Writeoff'];
    writeoffVerifyuserinfoId = json['Writeoff_verifyuserinfo_Id'];
    writeoffVerifyuserinfoName = json['Writeoff_verifyuserinfo_Name'];
    writeoffTime = json['Writeoff_Time'];
    writeoffCode = json['Writeoff_Code'];
    writeoffCodeCreateTime = json['Writeoff_Code_CreateTime'];
    receivingaddressArea0Id = json['Receivingaddress_area0_id'];
    receivingaddressArea1Id = json['Receivingaddress_area1_id'];
    receivingaddressArea0 = json['Receivingaddress_area0'];
    receivingaddressArea1 = json['Receivingaddress_area1'];
    receivingaddressContact = json['Receivingaddress_contact'];
    receivingaddressPhone = json['Receivingaddress_phone'];
    receivingaddressAddress = json['Receivingaddress_address'];
    thankyoumessage = json['Thankyoumessage'];
    sendingMethod = json['SendingMethod'];
    deliveryTime = json['DeliveryTime'];
    receivingTime = json['ReceivingTime'];
    orderStatus = json['OrderStatus'];
    orderStatusOld = json['OrderStatus_Old'];
    logisticsNumber = json['Logistics_Number'];
    logisticsCompany = json['Logistics_Company'];
    estimatedDeliveryTime = json['EstimatedDeliveryTime'];
    isFree = json['IsFree'];
    orderIdRelation = json['OrderId_relation'];
    skuId = json['SkuId'];
    skuContent = json['SkuContent'];
    content1 = json['Content1'];
    orderClose = json['OrderClose'];
    content2 = json['Content2'];
    canIGive = json['CanIGive'];
    canIExchange = json['CanIExchange'];
    userIP = json['UserIP'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = id;
    data['O_Guid'] = oGuid;
    data['User_id'] = userId;
    data['NickName'] = nickName;
    data['W_Guid'] = wGuid;
    data['G_Guid'] = gGuid;
    data['BuyPrice0'] = buyPrice0;
    data['OrderMoney'] = orderMoney;
    data['Printing_n0'] = printingN0;
    data['Jifen_n0'] = jifenN0;
    data['GiftName0'] = giftName0;
    data['C_CoverImg0'] = cCoverImg0;
    data['Expiration_time'] = expirationTime;
    data['CreateTime'] = createTime;
    data['OrderNo'] = orderNo;
    data['Phone'] = phone;
    data['PhonePrefix'] = phonePrefix;
    data['Prepay_id'] = prepayId;
    data['PayStatus'] = payStatus;
    data['User_id1'] = userId1;
    data['NickName1'] = nickName1;
    data['W_Guid1'] = wGuid1;
    data['GiveTime'] = giveTime;
    data['PayTime'] = payTime;
    data['Is_give'] = isGive;
    data['Bg_give'] = bgGive;
    data['Msg_give'] = msgGive;
    data['Giftrequest_Guid'] = giftrequestGuid;
    data['PayType'] = payType;
    data['Nums'] = nums;
    data['OpenId'] = openId;
    data['IsCallBack'] = isCallBack;
    data['Out_transaction_id'] = outTransactionId;
    data['Transaction_id'] = transactionId;
    data['BussinessNo'] = bussinessNo;
    data['BussinessName'] = bussinessName;
    data['CharityId'] = charityId;
    data['CharityFavorites_Guid'] = charityFavoritesGuid;
    data['Buy1Get1FREE'] = buy1Get1FREE;
    data['Writeoff'] = writeoff;
    data['Writeoff_verifyuserinfo_Id'] = writeoffVerifyuserinfoId;
    data['Writeoff_verifyuserinfo_Name'] = writeoffVerifyuserinfoName;
    data['Writeoff_Time'] = writeoffTime;
    data['Writeoff_Code'] = writeoffCode;
    data['Writeoff_Code_CreateTime'] = writeoffCodeCreateTime;
    data['Receivingaddress_area0_id'] = receivingaddressArea0Id;
    data['Receivingaddress_area1_id'] = receivingaddressArea1Id;
    data['Receivingaddress_area0'] = receivingaddressArea0;
    data['Receivingaddress_area1'] = receivingaddressArea1;
    data['Receivingaddress_contact'] = receivingaddressContact;
    data['Receivingaddress_phone'] = receivingaddressPhone;
    data['Receivingaddress_address'] = receivingaddressAddress;
    data['Thankyoumessage'] = thankyoumessage;
    data['SendingMethod'] = sendingMethod;
    data['DeliveryTime'] = deliveryTime;
    data['ReceivingTime'] = receivingTime;
    data['OrderStatus'] = orderStatus;
    data['OrderStatus_Old'] = orderStatusOld;
    data['Logistics_Number'] = logisticsNumber;
    data['Logistics_Company'] = logisticsCompany;
    data['EstimatedDeliveryTime'] = estimatedDeliveryTime;
    data['IsFree'] = isFree;
    data['OrderId_relation'] = orderIdRelation;
    data['SkuId'] = skuId;
    data['SkuContent'] = skuContent;
    data['Content1'] = content1;
    data['OrderClose'] = orderClose;
    data['Content2'] = content2;
    data['CanIGive'] = canIGive;
    data['CanIExchange'] = canIExchange;
    data['UserIP'] = userIP;
    return data;
  }
}
