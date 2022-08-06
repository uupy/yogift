class CharityListItemVo {
  int? id;
  String? cCGuid;
  String? className;
  String? classNameEn;
  List<ChildModel>? childModel;

  CharityListItemVo({
    this.id,
    this.cCGuid,
    this.className,
    this.classNameEn,
    this.childModel,
  });

  CharityListItemVo.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    cCGuid = json['CC_Guid'];
    className = json['ClassName'];
    classNameEn = json['ClassNameEn'];
    if (json['childModel'] != null) {
      childModel = <ChildModel>[];
      json['childModel'].forEach((v) {
        childModel?.add(ChildModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = id;
    data['CC_Guid'] = cCGuid;
    data['ClassName'] = className;
    data['ClassNameEn'] = classNameEn;
    if (childModel != null) {
      data['childModel'] = childModel?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ChildModel {
  int? id;
  String? cGuid;
  String? charityName;
  String? charityImg;

  ChildModel({this.id, this.cGuid, this.charityName, this.charityImg});

  ChildModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cGuid = json['C_Guid'];
    charityName = json['CharityName'];
    charityImg = json['CharityImg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['C_Guid'] = cGuid;
    data['CharityName'] = charityName;
    data['CharityImg'] = charityImg;
    return data;
  }
}

class CharityItemVo {
  int? id;
  String? cGuid;
  String? charityName;
  String? cCGuid;
  String? email;
  String? address;
  String? cDetail;
  String? keywords;
  String? charityImg;
  String? charityBImg;
  String? lastUpdateTime;
  String? charityNo;
  String? phone;
  String? phonePrefix;

  CharityItemVo(
      {this.id,
      this.cGuid,
      this.charityName,
      this.cCGuid,
      this.email,
      this.address,
      this.cDetail,
      this.keywords,
      this.charityImg,
      this.charityBImg,
      this.lastUpdateTime,
      this.charityNo,
      this.phone,
      this.phonePrefix});

  CharityItemVo.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    cGuid = json['C_Guid'];
    charityName = json['CharityName'];
    cCGuid = json['CC_Guid'];
    email = json['Email'];
    address = json['Address'];
    cDetail = json['C_Detail'];
    keywords = json['Keywords'];
    charityImg = json['CharityImg'];
    charityBImg = json['CharityBImg'];
    lastUpdateTime = json['LastUpdateTime'];
    charityNo = json['CharityNo'];
    phone = json['Phone'];
    phonePrefix = json['PhonePrefix'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = id;
    data['C_Guid'] = cGuid;
    data['CharityName'] = charityName;
    data['CC_Guid'] = cCGuid;
    data['Email'] = email;
    data['Address'] = address;
    data['C_Detail'] = cDetail;
    data['Keywords'] = keywords;
    data['CharityImg'] = charityImg;
    data['CharityBImg'] = charityBImg;
    data['LastUpdateTime'] = lastUpdateTime;
    data['CharityNo'] = charityNo;
    data['Phone'] = phone;
    data['PhonePrefix'] = phonePrefix;
    return data;
  }
}
