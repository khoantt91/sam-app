import 'package:equatable/equatable.dart';
import 'package:samapp/model/deal.dart';
import 'package:samapp/model/user.dart';

import '../../model/user.dart';

abstract class TabDealState extends Equatable {
  const TabDealState();

  @override
  List<Object> get props => [];
}

class InitialState extends TabDealState {}

class DataLoading extends TabDealState {}

class DataLoadingMore extends TabDealState {}

class DataLoadDone extends TabDealState {
  final List<Deal> deals;
  final bool hasReachedMax;

  const DataLoadDone(this.deals, this.hasReachedMax);
}

class DataLoadError extends TabDealState {
  final String error;

  const DataLoadError(this.error);

  @override
  List<Object> get props => [error];
}

class DataTotalItem extends TabDealState {
  final int total;

  const DataTotalItem(this.total);
}

class DataFilter extends TabDealState {
  final bool hasFilter;

  const DataFilter(this.hasFilter);
}
