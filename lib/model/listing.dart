import 'package:json_annotation/json_annotation.dart';

part 'listing.g.dart';

@JsonSerializable()
class Listing {
  int rlistingId;

  int scorecardType;

  String formatPrice;
  String formatFloorSize;
  String formatLotSize;

  String address;

  int classify;
  String classifyName;

  int numberOfListingView;
  String ownerName;

  double lastCall;
  int tour;

  int listingTypeId;
  String listingTypeName;

  int propertyTypeId;
  String propertyTypeName;

  Map<String, int> dealClassify;

  Listing(
      this.rlistingId,
      this.scorecardType,
      this.formatPrice,
      this.formatFloorSize,
      this.formatLotSize,
      this.address,
      this.classify,
      this.classifyName,
      this.numberOfListingView,
      this.ownerName,
      this.lastCall,
      this.tour,
      this.listingTypeId,
      this.listingTypeName,
      this.propertyTypeId,
      this.propertyTypeName,
      this.dealClassify);

  factory Listing.fromJson(Map<String, dynamic> json) => _$ListingFromJson(json);

  Map<String, dynamic> toJson() => _$ListingToJson(this);

  String getListingLabelImage() {
    if (this.scorecardType == null) return 'assets/images/ic_label_undefine.png';
    switch (this.scorecardType) {
      case 1637:
        return 'assets/images/ic_label_high.png';
      case 1638:
        return 'assets/images/ic_label_medium.png';

      case 1639:
        return 'assets/images/ic_label_low.png';
      case 1655:
        return 'assets/images/ic_label_undefine.png';
    }
  }
}
