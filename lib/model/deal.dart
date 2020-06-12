import 'package:json_annotation/json_annotation.dart';

part 'deal.g.dart';

@JsonSerializable()
class Deal {
  int dealId;
  String customerName;

  String statusName;
  int statusId;

  String listingTypeName;
  String propertyTypeName;
  String scorecardType;
  String formatMinPrice;
  String formatMaxPrice;
  String districtNames;

  int numberTour;

  Deal(this.dealId, this.customerName, this.statusName, this.statusId, this.listingTypeName, this.propertyTypeName, this.scorecardType,
      this.formatMinPrice, this.formatMaxPrice, this.districtNames, this.numberTour, this.listingClassify);

  Map<String, int> listingClassify;

  factory Deal.fromJson(Map<String, dynamic> json) => _$DealFromJson(json);

  Map<String, dynamic> toJson() => _$DealToJson(this);

  String getDealLabelImage() {
    if (this.scorecardType == null) return 'assets/images/ic_deal_label_l_0.png';
    switch (this.scorecardType.toUpperCase()) {
      case 'H2':
        return 'assets/images/ic_deal_label_h_2.png';
      case 'H1':
        return 'assets/images/ic_deal_label_h_1.png';

      case 'M2':
        return 'assets/images/ic_deal_label_m_2.png';
      case 'M1':
        return 'assets/images/ic_deal_label_m_1.png';

      case 'L1':
        return 'assets/images/ic_deal_label_l_1.png';
      case 'L0':
        return 'assets/images/ic_deal_label_l_0.png';
    }
  }
}
