import 'package:equatable/equatable.dart';
import 'package:samapp/model/deal.dart';
import 'package:samapp/model/listing.dart';
import 'package:samapp/model/user.dart';

import '../../model/user.dart';

/**
 * State: Initial, InProgress, Success, Failure, Begin, End
 */
abstract class ListingTabState extends Equatable {
  const ListingTabState();

  @override
  List<Object> get props => [];
}

class ListingTabInitial extends ListingTabState {}

class ListingTabGetDataInProgress extends ListingTabState {}

class ListingTabGetDataSuccess extends ListingTabState {
  final List<Listing> listings;
  final bool hasReachedMax;
  final int totalItems;

  const ListingTabGetDataSuccess(this.listings, this.hasReachedMax, this.totalItems);

  @override
  List<Object> get props => [this.listings, this.hasReachedMax, this.totalItems];
}

class ListingTabGetDataFailure extends ListingTabState {
  final String error;

  const ListingTabGetDataFailure(this.error);

  @override
  List<Object> get props => [error];
}

class ListingTabSearchingBegin extends ListingTabState {}

class ListingTabSearchingEnd extends ListingTabState {}
