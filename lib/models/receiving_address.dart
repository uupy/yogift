class ReceivingAddressVo {
  int? id;
  int? area0Id;
  int? area1Id;
  String? area0;
  String? area1;
  String? contact;
  String? phone;
  String? address;

  ReceivingAddressVo(
      {this.id,
      this.area0Id,
      this.area1Id,
      this.area0,
      this.area1,
      this.contact,
      this.phone,
      this.address});

  ReceivingAddressVo.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    area0Id = json['Area0_id'];
    area1Id = json['Area1_id'];
    area0 = json['Area0'];
    area1 = json['Area1'];
    contact = json['Contact'];
    phone = json['Phone'];
    address = json['Address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = id;
    data['Area0_id'] = area0Id;
    data['Area1_id'] = area1Id;
    data['Area0'] = area0;
    data['Area1'] = area1;
    data['Contact'] = contact;
    data['Phone'] = phone;
    data['Address'] = address;
    return data;
  }
}

class ReceivingAddressAddVo {
  int? area0Id;
  int? area1Id;
  String? contact;
  String? phone;
  String? address;

  ReceivingAddressAddVo(
      {this.area0Id, this.area1Id, this.contact, this.phone, this.address});

  ReceivingAddressAddVo.fromJson(Map<String, dynamic> json) {
    area0Id = json['area0_id'];
    area1Id = json['area1_id'];
    contact = json['contact'];
    phone = json['phone'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['area0_id'] = area0Id;
    data['area1_id'] = area1Id;
    data['contact'] = contact;
    data['phone'] = phone;
    data['address'] = address;
    return data;
  }
}
