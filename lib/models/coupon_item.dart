class CouponItem {
  int? id;
  int? ygcouponId;
  String? ygcouponTitle1;
  int? status;
  String? endTime;
  String? addtime1;
  String? remarks;
  String? termsOfUse;
  String? minimumAmount;
  double? cash;
  int? ygcouponType;

  CouponItem({
    this.id,
    this.ygcouponId,
    this.ygcouponTitle1,
    this.status,
    this.endTime,
    this.addtime1,
    this.remarks,
    this.termsOfUse,
    this.minimumAmount,
    this.cash,
    this.ygcouponType
  });

  CouponItem.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    ygcouponId = json['YgcouponId'];
    ygcouponTitle1 = json['YgcouponTitle1'];
    status = json['Status'];
    endTime = json['EndTime'];
    addtime1 = json['Addtime1'];
    remarks = json['Remarks'];
    termsOfUse = json['TermsOfUse'];
    minimumAmount = json['MinimumAmount'];
    cash = json['Cash'];
    ygcouponType = json['YgcouponType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = id;
    data['YgcouponId'] = ygcouponId;
    data['YgcouponTitle1'] = ygcouponTitle1;
    data['Status'] = status;
    data['EndTime'] = endTime;
    data['Addtime1'] = addtime1;
    data['Remarks'] = remarks;
    data['TermsOfUse'] = termsOfUse;
    data['MinimumAmount'] = minimumAmount;
    data['Cash'] = cash;
    data['YgcouponType'] = ygcouponType;
    return data;
  }
}
