class AppConfigVo {
  String? title;
  List<AreaCodeVo>? areacodelist;
  List<PopupWindow>? popupWindow;
  SetupConfig? setupConfig;

  AppConfigVo({
    this.title,
    this.areacodelist,
    this.popupWindow,
    this.setupConfig,
  });

  AppConfigVo.fromJson(Map<String, dynamic> json) {
    title = json['Title'];
    if (json['Areacodelist'] != null) {
      areacodelist = <AreaCodeVo>[];
      json['Areacodelist'].forEach((v) {
        areacodelist?.add(AreaCodeVo.fromJson(v));
      });
    }
    if (json['PopupWindow'] != null) {
      popupWindow = <PopupWindow>[];
      json['PopupWindow'].forEach((v) {
        popupWindow?.add(PopupWindow.fromJson(v));
      });
    }
    setupConfig = json['SetupConfig'] != null
        ? SetupConfig.fromJson(json['SetupConfig'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Title'] = title;
    data['Areacodelist'] = areacodelist?.map((v) => v.toJson()).toList();
    data['PopupWindow'] = popupWindow?.map((v) => v.toJson()).toList();
    data['SetupConfig'] = setupConfig?.toJson();
    return data;
  }
}

class AreaCodeVo {
  String? area;
  String? code;

  AreaCodeVo({this.area, this.code});

  AreaCodeVo.fromJson(Map<String, dynamic> json) {
    area = json['Area'];
    code = json['Code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Area'] = area;
    data['Code'] = code;
    return data;
  }
}

class PopupWindow {
  String? bannerImg;
  String? link;

  PopupWindow({this.bannerImg, this.link});

  PopupWindow.fromJson(Map<String, dynamic> json) {
    bannerImg = json['BannerImg'];
    link = json['Link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['BannerImg'] = bannerImg;
    data['Link'] = link;
    return data;
  }
}

class SetupConfig {
  EnumVo? webclose;
  EnumVo? webreg;
  EnumVo? logo;
  EnumVo? siteBeian;
  EnumVo? sitePhone;
  EnumVo? freeOneText;
  EnumVo? freeOneBtnText;
  EnumVo? test;
  EnumVo? shareOrderText;
  EnumVo? askFriendText;
  EnumVo? internalemailnotification;
  EnumVo? ordersconsultation;
  EnumVo? recommendationCodeUrl;
  EnumVo? mobileAreaCodeList;
  EnumVo? introduceGifts;
  EnumVo? introduceGiftTitle;
  EnumVo? introduceGiftStatus;

  SetupConfig(
      {this.webclose,
      this.webreg,
      this.logo,
      this.siteBeian,
      this.sitePhone,
      this.freeOneText,
      this.freeOneBtnText,
      this.test,
      this.shareOrderText,
      this.askFriendText,
      this.internalemailnotification,
      this.ordersconsultation,
      this.recommendationCodeUrl,
      this.mobileAreaCodeList,
      this.introduceGifts,
      this.introduceGiftTitle,
      this.introduceGiftStatus});

  SetupConfig.fromJson(Map<String, dynamic> json) {
    webclose =
        json['webclose'] != null ? EnumVo.fromJson(json['webclose']) : null;
    webreg = json['webreg'] != null ? EnumVo.fromJson(json['webreg']) : null;
    logo = json['logo'] != null ? EnumVo.fromJson(json['logo']) : null;
    siteBeian =
        json['siteBeian'] != null ? EnumVo.fromJson(json['siteBeian']) : null;
    sitePhone =
        json['sitePhone'] != null ? EnumVo.fromJson(json['sitePhone']) : null;
    freeOneText = json['freeOneText'] != null
        ? EnumVo.fromJson(json['freeOneText'])
        : null;
    freeOneBtnText = json['freeOneBtnText'] != null
        ? EnumVo.fromJson(json['freeOneBtnText'])
        : null;
    test = json['test'] != null ? EnumVo.fromJson(json['test']) : null;
    shareOrderText = json['shareOrderText'] != null
        ? EnumVo.fromJson(json['shareOrderText'])
        : null;
    askFriendText = json['askFriendText'] != null
        ? EnumVo.fromJson(json['askFriendText'])
        : null;
    internalemailnotification = json['Internalemailnotification'] != null
        ? EnumVo.fromJson(json['Internalemailnotification'])
        : null;
    ordersconsultation = json['ordersconsultation'] != null
        ? EnumVo.fromJson(json['ordersconsultation'])
        : null;
    recommendationCodeUrl = json['RecommendationCodeUrl'] != null
        ? EnumVo.fromJson(json['RecommendationCodeUrl'])
        : null;
    mobileAreaCodeList = json['MobileAreaCodeList'] != null
        ? EnumVo.fromJson(json['MobileAreaCodeList'])
        : null;
    introduceGifts = json['IntroduceGifts'] != null
        ? EnumVo.fromJson(json['IntroduceGifts'])
        : null;
    introduceGiftTitle = json['introduceGiftTitle'] != null
        ? EnumVo.fromJson(json['introduceGiftTitle'])
        : null;
    introduceGiftStatus = json['introduceGiftStatus'] != null
        ? EnumVo.fromJson(json['introduceGiftStatus'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['webclose'] = webclose?.toJson();
    data['webreg'] = webreg?.toJson();
    data['logo'] = logo?.toJson();
    data['siteBeian'] = siteBeian?.toJson();
    data['sitePhone'] = sitePhone?.toJson();
    data['freeOneText'] = freeOneText?.toJson();
    data['freeOneBtnText'] = freeOneBtnText?.toJson();
    data['test'] = test?.toJson();
    data['shareOrderText'] = shareOrderText?.toJson();
    data['askFriendText'] = askFriendText?.toJson();
    data['Internalemailnotification'] = internalemailnotification?.toJson();
    data['ordersconsultation'] = ordersconsultation?.toJson();
    data['RecommendationCodeUrl'] = recommendationCodeUrl?.toJson();
    data['MobileAreaCodeList'] = mobileAreaCodeList?.toJson();
    data['IntroduceGifts'] = introduceGifts?.toJson();
    data['introduceGiftTitle'] = introduceGiftTitle?.toJson();
    data['introduceGiftStatus'] = introduceGiftStatus?.toJson();
    return data;
  }
}

class EnumVo {
  String? value;
  String? desc;

  EnumVo({this.value, this.desc});

  EnumVo.fromJson(Map<String, dynamic> json) {
    value = json['Value'];
    desc = json['Desc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Value'] = value;
    data['Desc'] = desc;
    return data;
  }
}

class BannerVo {
  String? type1;
  String? bannerImg;
  String? link;

  BannerVo({
    this.type1,
    this.bannerImg,
    this.link,
  });

  BannerVo.fromJson(Map<String, dynamic> json) {
    type1 = json['Type1'];
    bannerImg = json['BannerImg'];
    link = json['Link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Type1'] = type1;
    data['BannerImg'] = bannerImg;
    data['Link'] = link;
    return data;
  }
}
