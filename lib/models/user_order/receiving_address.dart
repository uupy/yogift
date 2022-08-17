class ReceivingAddressVo {
  String? idGuid;
  int? receivingaddressArea0Id;
  int? receivingaddressArea1Id;
  String? receivingaddressContact;
  String? receivingaddressPhone;
  String? receivingaddressAddress;

  ReceivingAddressVo(
      {this.idGuid,
      this.receivingaddressArea0Id,
      this.receivingaddressArea1Id,
      this.receivingaddressContact,
      this.receivingaddressPhone,
      this.receivingaddressAddress});

  ReceivingAddressVo.fromJson(Map<String, dynamic> json) {
    idGuid = json['id_guid'];
    receivingaddressArea0Id = json['receivingaddress_area0_id'];
    receivingaddressArea1Id = json['receivingaddress_area1_id'];
    receivingaddressContact = json['receivingaddress_contact'];
    receivingaddressPhone = json['receivingaddress_phone'];
    receivingaddressAddress = json['Receivingaddress_address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id_guid'] = idGuid;
    data['receivingaddress_area0_id'] = receivingaddressArea0Id;
    data['receivingaddress_area1_id'] = receivingaddressArea1Id;
    data['receivingaddress_contact'] = receivingaddressContact;
    data['receivingaddress_phone'] = receivingaddressPhone;
    data['Receivingaddress_address'] = receivingaddressAddress;
    return data;
  }
}
