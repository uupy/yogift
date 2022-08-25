class OrderDetailItemVo {
  String? receiveInfo;
  int? id;
  String? oGuid;
  String? createTime;
  String? orderNo;
  double? orderMoney;
  int? printingN;
  int? jifenN;
  int? orderStatus;
  int? nums;
  int? sendingMethod;
  int? buy1Get1FREE;
  int? isFree;
  int? skuId;
  String? skuContent;
  int? userId;
  String? headSrc;
  String? nickName;
  String? phone;
  String? phonePrefix;
  String? wGuid;
  int? userId1;
  String? headSrc1;
  String? nickName1;
  String? phone1;
  String? phonePrefix1;
  String? wGuid1;
  String? gGuid;
  String? cCoverImg;
  double? buyPrice;
  String? giftName;
  String? exchangeTerms;
  int? payStatus;
  String? payTime;
  String? bussinessNo;
  String? bussinessName;
  String? bGuid;
  String? giftrequestGuid;
  String? bgGive;
  String? msgGive;
  String? greetingcardBigImg;
  int? isGive;
  String? giveTime;
  int? charityId;
  String? charityImg;
  String? charityName;
  String? charityFavoritesGuid;
  String? charityGuid;
  String? charityAddress;
  String? charityPhone;
  String? charityPhonePrefix;
  int? writeoff;
  String? writeoffTime;
  int? writeoffTimeN;
  String? writeoffCode;
  int? writeoffCodeType;
  double? ygcoupon1Cash;
  String? ygcoupon1Title1;
  String? writeoffCodeCreateTime;
  String? receivingaddressContact;
  String? receivingaddressArea0;
  String? receivingaddressArea1;
  String? receivingaddressPhone;
  String? receivingaddressAddress;
  String? thankyoumessage;
  String? receivingTime;
  String? deliveryTime;
  String? expirationTime;
  String? estimatedDeliveryTime;
  String? logisticsNumber;
  String? logisticsCompany;
  int? canIGive;
  int? canIExchange;

  OrderDetailItemVo({
    this.receiveInfo,
    this.id,
    this.oGuid,
    this.createTime,
    this.orderNo,
    this.orderMoney,
    this.printingN,
    this.jifenN,
    this.orderStatus,
    this.nums,
    this.sendingMethod,
    this.buy1Get1FREE,
    this.isFree,
    this.skuId,
    this.skuContent,
    this.userId,
    this.headSrc,
    this.nickName,
    this.phone,
    this.phonePrefix,
    this.wGuid,
    this.userId1,
    this.headSrc1,
    this.nickName1,
    this.phone1,
    this.phonePrefix1,
    this.wGuid1,
    this.gGuid,
    this.cCoverImg,
    this.buyPrice,
    this.giftName,
    this.exchangeTerms,
    this.payStatus,
    this.payTime,
    this.bussinessNo,
    this.bussinessName,
    this.bGuid,
    this.giftrequestGuid,
    this.bgGive,
    this.msgGive,
    this.greetingcardBigImg,
    this.isGive,
    this.giveTime,
    this.charityId,
    this.charityImg,
    this.charityName,
    this.charityFavoritesGuid,
    this.charityGuid,
    this.charityAddress,
    this.charityPhone,
    this.charityPhonePrefix,
    this.writeoff,
    this.writeoffTime,
    this.writeoffTimeN,
    this.writeoffCode,
    this.writeoffCodeType,
    this.writeoffCodeCreateTime,
    this.ygcoupon1Cash,
    this.ygcoupon1Title1,
    this.receivingaddressContact,
    this.receivingaddressArea0,
    this.receivingaddressArea1,
    this.receivingaddressPhone,
    this.receivingaddressAddress,
    this.thankyoumessage,
    this.receivingTime,
    this.deliveryTime,
    this.expirationTime,
    this.estimatedDeliveryTime,
    this.logisticsNumber,
    this.logisticsCompany,
    this.canIGive,
    this.canIExchange,
  });

  OrderDetailItemVo.fromJson(Map<String, dynamic> json) {
    receiveInfo = json['ReceiveInfo'];
    id = json['Id'];
    oGuid = json['O_Guid'];
    createTime = json['CreateTime'];
    orderNo = json['OrderNo'];
    orderMoney = json['OrderMoney'];
    printingN = json['Printing_n'];
    jifenN = json['Jifen_n'];
    orderStatus = json['OrderStatus'];
    nums = json['Nums'];
    sendingMethod = json['SendingMethod'];
    buy1Get1FREE = json['Buy1Get1FREE'];
    isFree = json['IsFree'];
    skuId = json['SkuId'];
    skuContent = json['SkuContent'];
    userId = json['User_id'];
    headSrc = json['Head_Src'];
    nickName = json['NickName'];
    phone = json['Phone'];
    phonePrefix = json['PhonePrefix'];
    wGuid = json['W_Guid'];
    userId1 = json['User_id1'];
    headSrc1 = json['Head_Src1'];
    nickName1 = json['NickName1'];
    phone1 = json['Phone1'];
    phonePrefix1 = json['PhonePrefix1'];
    wGuid1 = json['W_Guid1'];
    gGuid = json['G_Guid'];
    cCoverImg = json['C_CoverImg'];
    buyPrice = json['BuyPrice'];
    giftName = json['GiftName'];
    exchangeTerms = json['ExchangeTerms'];
    payStatus = json['PayStatus'];
    payTime = json['PayTime'];
    bussinessNo = json['BussinessNo'];
    bussinessName = json['BussinessName'];
    bGuid = json['B_Guid'];
    giftrequestGuid = json['Giftrequest_Guid'];
    bgGive = json['Bg_give'];
    msgGive = json['Msg_give'];
    greetingcardBigImg = json['Greetingcard_BigImg'];
    isGive = json['Is_give'];
    giveTime = json['GiveTime'];
    charityId = json['CharityId'];
    charityImg = json['CharityImg'];
    charityName = json['CharityName'];
    charityFavoritesGuid = json['CharityFavorites_Guid'];
    charityGuid = json['CharityGuid'];
    charityAddress = json['CharityAddress'];
    charityPhone = json['CharityPhone'];
    charityPhonePrefix = json['CharityPhonePrefix'];
    writeoff = json['Writeoff'];
    writeoffTime = json['Writeoff_Time'];
    writeoffTimeN = json['Writeoff_Time_n'];
    writeoffCode = json['Writeoff_Code'];
    writeoffCodeType = json['Writeoff_CodeType'];
    ygcoupon1Cash = json['Ygcoupon1Cash'];
    ygcoupon1Title1 = json['Ygcoupon1Title1'];
    writeoffCodeCreateTime = json['Writeoff_Code_CreateTime'];
    receivingaddressContact = json['Receivingaddress_contact'];
    receivingaddressArea0 = json['Receivingaddress_area0'];
    receivingaddressArea1 = json['Receivingaddress_area1'];
    receivingaddressPhone = json['Receivingaddress_phone'];
    receivingaddressAddress = json['Receivingaddress_address'];
    thankyoumessage = json['Thankyoumessage'];
    receivingTime = json['ReceivingTime'];
    deliveryTime = json['DeliveryTime'];
    expirationTime = json['Expiration_time'];
    estimatedDeliveryTime = json['EstimatedDeliveryTime'];
    logisticsNumber = json['Logistics_Number'];
    logisticsCompany = json['Logistics_Company'];
    canIGive = json['CanIGive'];
    canIExchange = json['CanIExchange'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ReceiveInfo'] = receiveInfo;
    data['Id'] = id;
    data['O_Guid'] = oGuid;
    data['CreateTime'] = createTime;
    data['OrderNo'] = orderNo;
    data['OrderMoney'] = orderMoney;
    data['Printing_n'] = printingN;
    data['Jifen_n'] = jifenN;
    data['OrderStatus'] = orderStatus;
    data['Nums'] = nums;
    data['SendingMethod'] = sendingMethod;
    data['Buy1Get1FREE'] = buy1Get1FREE;
    data['IsFree'] = isFree;
    data['SkuId'] = skuId;
    data['SkuContent'] = skuContent;
    data['User_id'] = userId;
    data['Head_Src'] = headSrc;
    data['NickName'] = nickName;
    data['Phone'] = phone;
    data['PhonePrefix'] = phonePrefix;
    data['W_Guid'] = wGuid;
    data['User_id1'] = userId1;
    data['Head_Src1'] = headSrc1;
    data['NickName1'] = nickName1;
    data['Phone1'] = phone1;
    data['PhonePrefix1'] = phonePrefix1;
    data['W_Guid1'] = wGuid1;
    data['G_Guid'] = gGuid;
    data['C_CoverImg'] = cCoverImg;
    data['BuyPrice'] = buyPrice;
    data['GiftName'] = giftName;
    data['ExchangeTerms'] = exchangeTerms;
    data['PayStatus'] = payStatus;
    data['PayTime'] = payTime;
    data['BussinessNo'] = bussinessNo;
    data['BussinessName'] = bussinessName;
    data['B_Guid'] = bGuid;
    data['Giftrequest_Guid'] = giftrequestGuid;
    data['Bg_give'] = bgGive;
    data['Msg_give'] = msgGive;
    data['Greetingcard_BigImg'] = greetingcardBigImg;
    data['Is_give'] = isGive;
    data['GiveTime'] = giveTime;
    data['CharityId'] = charityId;
    data['CharityImg'] = charityImg;
    data['CharityName'] = charityName;
    data['CharityFavorites_Guid'] = charityFavoritesGuid;
    data['CharityGuid'] = charityGuid;
    data['CharityAddress'] = charityAddress;
    data['CharityPhone'] = charityPhone;
    data['CharityPhonePrefix'] = charityPhonePrefix;
    data['Writeoff'] = writeoff;
    data['Writeoff_Time'] = writeoffTime;
    data['Writeoff_Time_n'] = writeoffTimeN;
    data['Writeoff_Code'] = writeoffCode;
    data['Writeoff_CodeType'] = writeoffCodeType;
    data['Ygcoupon1Cash'] = ygcoupon1Cash;
    data['Ygcoupon1Title1'] = ygcoupon1Title1;
    data['Writeoff_Code_CreateTime'] = writeoffCodeCreateTime;
    data['Receivingaddress_contact'] = receivingaddressContact;
    data['Receivingaddress_area0'] = receivingaddressArea0;
    data['Receivingaddress_area1'] = receivingaddressArea1;
    data['Receivingaddress_phone'] = receivingaddressPhone;
    data['Receivingaddress_address'] = receivingaddressAddress;
    data['Thankyoumessage'] = thankyoumessage;
    data['ReceivingTime'] = receivingTime;
    data['DeliveryTime'] = deliveryTime;
    data['Expiration_time'] = expirationTime;
    data['EstimatedDeliveryTime'] = estimatedDeliveryTime;
    data['Logistics_Number'] = logisticsNumber;
    data['Logistics_Company'] = logisticsCompany;
    data['CanIGive'] = canIGive;
    data['CanIExchange'] = canIExchange;
    return data;
  }
}
