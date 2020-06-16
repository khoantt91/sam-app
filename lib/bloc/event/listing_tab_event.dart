import 'package:equatable/equatable.dart';
import 'package:samapp/model/constant.dart';
import 'package:samapp/model/pair.dart';

abstract class ListingTabEvent extends Equatable {
  const ListingTabEvent();

  @override
  List<Object> get props => [];
}

class ListingTabGetData extends ListingTabEvent {
  final List<ListingScorecardTypes> scorecardTypes;
  final Pair<DateTime, DateTime> rangeData;
  final String keySearch;

  ListingTabGetData({this.scorecardTypes, this.rangeData, this.keySearch});
}

class ListingTabGetMoreData extends ListingTabEvent {}

class ListingTabStartSearching extends ListingTabEvent {}

class ListingTabCancelSearching extends ListingTabEvent {}
