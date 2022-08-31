class GiftDetailVo {
  int? id;
  String? gGuid;
  String? gCGuid;
  String? giftName;
  String? originalPrice;
  double? buyPrice;
  double? buyPriceForCharity;
  num? forCharity;
  String? cCoverImg;
  String? cDetail;
  List<String>? cDetailImg;
  int? sendingMethod;
  int? jifenN;
  String? bussinessNo;
  String? bussinessName;
  String? bGuid;
  int? effectiveDays;
  String? effectiveTime;
  num? estimatedDeliveryTimeTN;
  List<String>? keywords;
  num? commissionValue;
  String? exchangeTerms;
  int? buy1Get1FREE;
  int? favorite;
  int? skuType;
  String? specIds;
  String? specValueIds;
  List<Skus>? skus;
  List<Specs>? specs;

  GiftDetailVo(
      {this.id,
      this.gGuid,
      this.gCGuid,
      this.giftName,
      this.originalPrice,
      this.buyPrice,
      this.buyPriceForCharity,
      this.forCharity,
      this.cCoverImg,
      this.cDetail,
      this.cDetailImg,
      this.sendingMethod,
      this.jifenN,
      this.bussinessNo,
      this.bussinessName,
      this.bGuid,
      this.effectiveDays,
      this.effectiveTime,
      this.estimatedDeliveryTimeTN,
      this.keywords,
      this.commissionValue,
      this.exchangeTerms,
      this.buy1Get1FREE,
      this.favorite,
      this.skuType,
      this.specIds,
      this.specValueIds,
      this.skus,
      this.specs});

  GiftDetailVo.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    gGuid = json['G_Guid'];
    gCGuid = json['GC_Guid'];
    giftName = json['GiftName'];
    originalPrice = json['OriginalPrice'];
    buyPrice = json['BuyPrice'];
    buyPriceForCharity = json['BuyPrice_For_Charity'];
    forCharity = json['For_Charity'];
    cCoverImg = json['C_CoverImg'];
    cDetail = json['C_Detail'];
    cDetailImg = json['C_Detail_Img']?.cast<String>();
    sendingMethod = json['SendingMethod'];
    jifenN = json['Jifen_n'];
    bussinessNo = json['BussinessNo'];
    bussinessName = json['BussinessName'];
    bGuid = json['B_Guid'];
    effectiveDays = json['EffectiveDays'];
    effectiveTime = json['EffectiveTime'];
    estimatedDeliveryTimeTN = json['EstimatedDeliveryTime_TN'];
    keywords = json['Keywords']?.cast<String>();
    commissionValue = json['Commission_value'];
    exchangeTerms = json['ExchangeTerms'];
    buy1Get1FREE = json['Buy1Get1FREE'];
    favorite = json['Favorite'];
    skuType = json['SkuType'];
    specIds = json['SpecIds'];
    specValueIds = json['SpecValueIds'];
    if (json['Skus'] != null) {
      skus = <Skus>[];
      json['Skus'].forEach((v) {
        skus?.add(Skus.fromJson(v));
      });
    }
    if (json['Specs'] != null) {
      specs = <Specs>[];
      json['Specs'].forEach((v) {
        specs?.add(Specs.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = id;
    data['G_Guid'] = gGuid;
    data['GC_Guid'] = gCGuid;
    data['GiftName'] = giftName;
    data['OriginalPrice'] = originalPrice;
    data['BuyPrice'] = buyPrice;
    data['BuyPrice_For_Charity'] = buyPriceForCharity;
    data['For_Charity'] = forCharity;
    data['C_CoverImg'] = cCoverImg;
    data['C_Detail'] = cDetail;
    data['C_Detail_Img'] = cDetailImg;
    data['SendingMethod'] = sendingMethod;
    data['Jifen_n'] = jifenN;
    data['BussinessNo'] = bussinessNo;
    data['BussinessName'] = bussinessName;
    data['B_Guid'] = bGuid;
    data['EffectiveDays'] = effectiveDays;
    data['EffectiveTime'] = effectiveTime;
    data['EstimatedDeliveryTime_TN'] = estimatedDeliveryTimeTN;
    data['Keywords'] = keywords;
    data['Commission_value'] = commissionValue;
    data['ExchangeTerms'] = exchangeTerms;
    data['Buy1Get1FREE'] = buy1Get1FREE;
    data['Favorite'] = favorite;
    data['SkuType'] = skuType;
    data['SpecIds'] = specIds;
    data['SpecValueIds'] = specValueIds;
    if (skus != null) {
      data['Skus'] = skus?.map((v) => v.toJson()).toList();
    }
    if (specs != null) {
      data['Specs'] = specs?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Skus {
  num? id;
  num? goodsId;
  String? skey;
  String? barcode;
  String? sn;
  num? buyPrice;
  num? costPrice;
  num? originalPrice;
  num? buyPriceForCharity;
  num? weight;
  num? amount;
  num? isDefalut;
  String? cCoverImg;
  num? forCharityMin;
  num? estimatedDeliveryTimeTN;
  num? favorite1;
  num? quantity;
  num? quantityGet;
  String? charityFavoritesGuid;

  Skus(
      {this.id,
      this.goodsId,
      this.skey,
      this.barcode,
      this.sn,
      this.buyPrice,
      this.costPrice,
      this.originalPrice,
      this.buyPriceForCharity,
      this.weight,
      this.amount,
      this.isDefalut,
      this.cCoverImg,
      this.forCharityMin,
      this.estimatedDeliveryTimeTN,
      this.favorite1,
      this.quantity,
      this.quantityGet,
      this.charityFavoritesGuid});

  Skus.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    goodsId = json['GoodsId'];
    skey = json['Skey'];
    barcode = json['Barcode'];
    sn = json['Sn'];
    buyPrice = json['BuyPrice'];
    costPrice = json['CostPrice'];
    originalPrice = json['OriginalPrice'];
    buyPriceForCharity = json['BuyPrice_For_Charity'];
    weight = json['Weight'];
    amount = json['Amount'];
    isDefalut = json['IsDefalut'];
    cCoverImg = json['C_CoverImg'];
    forCharityMin = json['For_Charity_Min'];
    estimatedDeliveryTimeTN = json['EstimatedDeliveryTime_TN'];
    favorite1 = json['favorite1'];
    quantity = json['Quantity'];
    quantityGet = json['Quantity_get'];
    charityFavoritesGuid = json['CharityFavorites_Guid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = id;
    data['GoodsId'] = goodsId;
    data['Skey'] = skey;
    data['Barcode'] = barcode;
    data['Sn'] = sn;
    data['BuyPrice'] = buyPrice;
    data['CostPrice'] = costPrice;
    data['OriginalPrice'] = originalPrice;
    data['BuyPrice_For_Charity'] = buyPriceForCharity;
    data['Weight'] = weight;
    data['Amount'] = amount;
    data['IsDefalut'] = isDefalut;
    data['C_CoverImg'] = cCoverImg;
    data['For_Charity_Min'] = forCharityMin;
    data['EstimatedDeliveryTime_TN'] = estimatedDeliveryTimeTN;
    data['favorite1'] = favorite1;
    data['Quantity'] = quantity;
    data['Quantity_get'] = quantityGet;
    data['CharityFavorites_Guid'] = charityFavoritesGuid;
    return data;
  }
}

class Specs {
  num? id;
  String? name;
  num? sort;
  List<SpecValues>? specValues;
  List? specValuesArr;

  Specs({this.id, this.name, this.sort, this.specValues, this.specValuesArr});

  Specs.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    name = json['Name'];
    sort = json['Sort'];
    if (json['specValues'] != null) {
      specValues = <SpecValues>[];
      json['specValues'].forEach((v) {
        specValues?.add(SpecValues.fromJson(v));
      });
    }
    if (json['specValuesArr'] != null) {
      specValuesArr = <Null>[];
      json['specValuesArr'].forEach((v) {
        specValuesArr?.add(v);
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = id;
    data['Name'] = name;
    data['Sort'] = sort;
    if (specValues != null) {
      data['specValues'] = specValues?.map((v) => v.toJson()).toList();
    }
    if (specValuesArr != null) {
      data['specValuesArr'] = specValuesArr?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SpecValues {
  num? id;
  num? specId;
  String? value;
  num? sort;

  SpecValues({this.id, this.specId, this.value, this.sort});

  SpecValues.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    specId = json['SpecId'];
    value = json['Value'];
    sort = json['Sort'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = id;
    data['SpecId'] = specId;
    data['Value'] = value;
    data['Sort'] = sort;
    return data;
  }
}
