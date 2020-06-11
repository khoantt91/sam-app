import 'package:equatable/equatable.dart';
import 'package:samapp/model/constant.dart';
import 'package:samapp/model/deal.dart';
import 'package:samapp/model/pair.dart';

abstract class TabDealEvent extends Equatable {
  const TabDealEvent();

  @override
  List<Object> get props => [];
}

class RefreshData extends TabDealEvent {
  const RefreshData();
}

class GetData extends TabDealEvent {
  final List<ListingTypes> listingTypes;
  final List<DealScorecardTypes> scorecardTypes;
  final List<DealStatus> dealStatus;
  final Pair<DateTime, DateTime> rangeData;
  final String keySearch;

  GetData({this.listingTypes, this.scorecardTypes, this.dealStatus, this.rangeData, this.keySearch});

  @override
  List<Object> get props => [listingTypes, scorecardTypes, dealStatus, rangeData, keySearch];
}

class GetMoreData extends TabDealEvent {
  const GetMoreData();
}

class FilterPress extends TabDealEvent {
  const FilterPress();
}

class DealPress extends TabDealEvent {
  final int dealId;

  const DealPress(this.dealId);

  @override
  List<Object> get props => [dealId];
}

class ListingLabelPress extends TabDealEvent {
  final ListingScorecardTypes listingScorecardTypes;

  const ListingLabelPress(this.listingScorecardTypes);

  @override
  List<Object> get props => [listingScorecardTypes];
}

class TouringPress extends TabDealEvent {
  const TouringPress();
}

class DealSubMenuPress extends TabDealEvent {
  final Deal deal;

  const DealSubMenuPress(this.deal);

  @override
  List<Object> get props => [deal];
}

class DealStartSearch extends TabDealEvent {
  const DealStartSearch();
}

class DealStopSearch extends TabDealEvent {
  const DealStopSearch();
}
