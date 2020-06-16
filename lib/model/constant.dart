/* ENUM: ListingTypes */
import 'package:flutter/material.dart';

enum ListingTypes { BUY, RENT }

extension ListingTypesExtention on ListingTypes {
  int get id {
    switch (this) {
      case ListingTypes.BUY:
        return 1;
      case ListingTypes.RENT:
        return 2;
      default:
        return -1;
    }
  }

  String get name {
    switch (this) {
      case ListingTypes.BUY:
        return 'Mua';
      case ListingTypes.RENT:
        return 'Thuê';
      default:
        return '';
    }
  }
}

/* ENUM: ListingScorecardType */
enum ListingScorecardTypes { HIGH, MEDIUM, LOW, UNCLASSIFIED }

extension ListingScorecardTypesExtention on ListingScorecardTypes {
  String get key {
    switch (this) {
      case ListingScorecardTypes.HIGH:
        return 'SCORECARD_HIGH';
      case ListingScorecardTypes.MEDIUM:
        return 'SCORECARD_MEDIUM';
      case ListingScorecardTypes.LOW:
        return 'SCORECARD_LOW';
      case ListingScorecardTypes.UNCLASSIFIED:
        return 'SCORECARD_UNCLASSIFIED';
      default:
        return '';
    }
  }

  String get shortName {
    switch (this) {
      case ListingScorecardTypes.HIGH:
        return 'H';
      case ListingScorecardTypes.MEDIUM:
        return 'M';
      case ListingScorecardTypes.LOW:
        return 'L';
      case ListingScorecardTypes.UNCLASSIFIED:
        return 'U';
      default:
        return '';
    }
  }

  int get id {
    switch (this) {
      case ListingScorecardTypes.HIGH:
        return 1637;
      case ListingScorecardTypes.MEDIUM:
        return 1638;
      case ListingScorecardTypes.LOW:
        return 1639;
      case ListingScorecardTypes.UNCLASSIFIED:
        return 1655;
      default:
        return -1;
    }
  }

  Color get colorBg {
    switch (this) {
      case ListingScorecardTypes.HIGH:
        return Color(0xFF3ba500);
      case ListingScorecardTypes.MEDIUM:
        return Color(0xFFff8100);
      case ListingScorecardTypes.LOW:
        return Color(0xFFae0303);
      case ListingScorecardTypes.UNCLASSIFIED:
        return Color(0xFF666666);
      default:
        return Color(0xFF666666);
    }
  }
}

/* ENUM: DealScorecardType */
enum DealScorecardTypes { HIGH_2, HIGH_1, MEDIUM_2, MEDIUM_1, LOW_1, LOW_0 }

extension DealScorecardTypesExtention on DealScorecardTypes {
  String get stringId {
    switch (this) {
      case DealScorecardTypes.HIGH_2:
        return "H2";
      case DealScorecardTypes.HIGH_1:
        return "H1";
      case DealScorecardTypes.MEDIUM_2:
        return "M2";
      case DealScorecardTypes.MEDIUM_1:
        return "M1";
      case DealScorecardTypes.LOW_1:
        return "L1";
      case DealScorecardTypes.LOW_0:
        return "L0";
      default:
        return '';
    }
  }

  String get name {
    switch (this) {
      case DealScorecardTypes.HIGH_2:
        return "High 2";
      case DealScorecardTypes.HIGH_1:
        return "High 1";
      case DealScorecardTypes.MEDIUM_2:
        return "Medium 2";
      case DealScorecardTypes.MEDIUM_1:
        return "Medium 1";
      case DealScorecardTypes.LOW_1:
        return "Low 1";
      case DealScorecardTypes.LOW_0:
        return "Low 0";
      default:
        return '';
    }
  }

  Color get colorBg {
    switch (this) {
      case DealScorecardTypes.HIGH_2:
        return Color(0xFF3ba500);
      case DealScorecardTypes.HIGH_1:
        return Color(0xFF6dc309);
      case DealScorecardTypes.MEDIUM_2:
        return Color(0xFFff8100);
      case DealScorecardTypes.MEDIUM_1:
        return Color(0xFFffa140);
      case DealScorecardTypes.LOW_1:
        return Color(0xFFae0303);
      case DealScorecardTypes.LOW_0:
        return Color(0xFFfc4040);
      default:
        return Color(0xFFfc4040);
    }
  }
}

/* ENUM: DealStatus */
enum DealStatus { CONSULTANT, TOURING, NEGOTIATE, PENDING, CLOSING, DEPOSIT }

extension DealStatusExtention on DealStatus {
  int get id {
    switch (this) {
      case DealStatus.CONSULTANT:
        return 24;
      case DealStatus.TOURING:
        return 25;
      case DealStatus.NEGOTIATE:
        return 26;
      case DealStatus.CLOSING:
        return 27;
      case DealStatus.PENDING:
        return 28;
      case DealStatus.DEPOSIT:
        return 29;
      default:
        return -1;
    }
  }

  String get name {
    switch (this) {
      case DealStatus.CONSULTANT:
        return 'Tư vấn';
      case DealStatus.TOURING:
        return 'Touring';
      case DealStatus.NEGOTIATE:
        return 'Thương lượng';
      case DealStatus.CLOSING:
        return 'Đóng deal';
      case DealStatus.PENDING:
        return 'Pending';
      case DealStatus.DEPOSIT:
        return 'Đặt cọc';
      default:
        return '';
    }
  }
}
