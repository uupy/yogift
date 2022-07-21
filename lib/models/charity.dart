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
