class GiftCouponItem {
  num? id;
  num? ygcouponId;
  String? ygcouponTitle1;
  String? endTime;
  String? addtime1;
  num? status;
  num? minimumAmount;
  double? cash;
  String? remarks;
  String? termsOfUse;
  num? ygcouponType;
  String? discountAmount;

  GiftCouponItem(
      {this.id,
      this.ygcouponId,
      this.ygcouponTitle1,
      this.endTime,
      this.addtime1,
      this.status,
      this.minimumAmount,
      this.cash,
      this.remarks,
      this.termsOfUse,
      this.ygcouponType,
      this.discountAmount});

  GiftCouponItem.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    ygcouponId = json['YgcouponId'];
    ygcouponTitle1 = json['YgcouponTitle1'];
    endTime = json['EndTime'];
    addtime1 = json['Addtime1'];
    status = json['Status'];
    minimumAmount = json['MinimumAmount'];
    cash = json['Cash'];
    remarks = json['Remarks'];
    termsOfUse = json['TermsOfUse'];
    ygcouponType = json['YgcouponType'];
    discountAmount = json['DiscountAmount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = id;
    data['YgcouponId'] = ygcouponId;
    data['YgcouponTitle1'] = ygcouponTitle1;
    data['EndTime'] = endTime;
    data['Addtime1'] = addtime1;
    data['Status'] = status;
    data['MinimumAmount'] = minimumAmount;
    data['Cash'] = cash;
    data['Remarks'] = remarks;
    data['TermsOfUse'] = termsOfUse;
    data['YgcouponType'] = ygcouponType;
    data['DiscountAmount'] = discountAmount;
    return data;
  }
}
