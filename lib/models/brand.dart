class BrandCategoryVo {
  int? id;
  String? iGuid;
  String? className;
  List<BrandBussinessVo>? bussiness;

  BrandCategoryVo({
    this.id,
    this.iGuid,
    this.className,
    this.bussiness,
  });

  BrandCategoryVo.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    iGuid = json['I_Guid'];
    className = json['ClassName'];
    if (json['Bussiness'] != null) {
      bussiness = <BrandBussinessVo>[];
      json['Bussiness'].forEach((v) {
        bussiness?.add(BrandBussinessVo.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = id;
    data['I_Guid'] = iGuid;
    data['ClassName'] = className;
    if (bussiness != null) {
      data['Bussiness'] = bussiness?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BrandBussinessVo {
  int? id;
  String? bGuid;
  String? bussinessNo;
  String? bussinessName;
  String? bussinessImg;
  String? bussinessImgBg;
  String? cDetail;
  List<String>? keywords;

  BrandBussinessVo({
    this.id,
    this.bGuid,
    this.bussinessNo,
    this.bussinessName,
    this.bussinessImg,
    this.bussinessImgBg,
    this.cDetail,
    this.keywords,
  });

  BrandBussinessVo.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    bGuid = json['B_Guid'];
    bussinessNo = json['BussinessNo'];
    bussinessName = json['BussinessName'];
    bussinessImg = json['BussinessImg'];
    bussinessImgBg = json['BussinessImg_bg'];
    cDetail = json['C_Detail'];
    keywords = json['Keywords']?.cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = id;
    data['B_Guid'] = bGuid;
    data['BussinessNo'] = bussinessNo;
    data['BussinessName'] = bussinessName;
    data['BussinessImg'] = bussinessImg;
    data['BussinessImg_bg'] = bussinessImgBg;
    data['C_Detail'] = cDetail;
    data['Keywords'] = keywords?.map((e) => e.toString()).toList();
    return data;
  }
}
