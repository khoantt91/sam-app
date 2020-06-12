import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samapp/bloc/event/login_event.dart';
import 'package:samapp/bloc/event/tab_deal_event.dart';
import 'package:samapp/bloc/state/login_state.dart';
import 'package:samapp/bloc/state/tab_deal_state.dart';
import 'package:samapp/model/constant.dart';
import 'package:samapp/model/pair.dart';
import 'package:samapp/repository/repository.dart';
import 'package:samapp/utils/log/log.dart';

import 'state/login_state.dart';

class TabDealBloc extends Bloc<TabDealEvent, TabDealState> {
  //region Variables
  final RepositoryImp _repository;

  TabDealBloc(this._repository);

  /* Define default filter data */
  final List<ListingTypes> _listingTypes = [
    ListingTypes.BUY,
    ListingTypes.RENT,
  ];
  final List<DealScorecardTypes> _scorecardTypes = [
    DealScorecardTypes.HIGH_2,
    DealScorecardTypes.HIGH_1,
    DealScorecardTypes.MEDIUM_2,
    DealScorecardTypes.MEDIUM_1,
    DealScorecardTypes.LOW_1,
    DealScorecardTypes.LOW_0,
  ];

  final List<DealStatus> _dealStatus = [
    DealStatus.CONSULTANT,
    DealStatus.TOURING,
    DealStatus.NEGOTIATE,
    DealStatus.DEPOSIT,
    DealStatus.PENDING,
    DealStatus.CLOSING,
  ];
  final Pair<DateTime, DateTime> _rangeData = Pair(DateTime.now().subtract(Duration(days: 30)), DateTime.now());
  String _keySearch = '';

  int _currentPage = 0;
  int _totalPage = 0;
  int _totalItem = 20;
  bool _isLoading = false;

  //endregion

  @override
  TabDealState get initialState => InitialState();

  @override
  Stream<TabDealState> mapEventToState(TabDealEvent event) async* {
    if (event is GetData) yield* _handleGetData(event);
    if (event is GetMoreData) yield* _handleGetMoreData(event);
  }

  Stream<TabDealState> _handleGetData(GetData event) async* {
    _currentPage = 1;

    if (event.listingTypes != null) _listingTypes.replaceAll(event.listingTypes);
    if (event.scorecardTypes != null) _scorecardTypes.replaceAll(event.scorecardTypes);
    if (event.dealStatus != null) _dealStatus.replaceAll(event.dealStatus);
    if (event.rangeData != null) _rangeData.replaceAll(event.rangeData);
    if (event.keySearch != null) _keySearch = event.keySearch;

    _isLoading = true;

    yield DataLoading();
    final result = await _repository.getDeals(
      listingTypes: _listingTypes,
      dealScorecardTypes: _scorecardTypes,
      dealStatus: _dealStatus,
      fromDate: _rangeData.first.millisecondsSinceEpoch,
      toDate: _rangeData.last.millisecondsSinceEpoch,
      textSearch: _keySearch,
      page: _currentPage,
      numberItem: _totalItem,
    );

    /* Handle error */
    if (result.error != null) {
      yield DataLoadError(result.error.message);
      _isLoading = false;
      return;
    }

    /* Handle success */
    if (result.success != null) {
      _totalPage = result.success.totalPages;
      yield DataTotalItem(result.success.totalItems);
      yield DataLoadDone(result.success.list);
      _isLoading = false;
    }
  }

  Stream<TabDealState> _handleGetMoreData(GetMoreData event) async* {
    if (_isLoading) return;
    _currentPage++;
    if (_currentPage > _totalPage) return;

    _isLoading = true;
    yield DataLoadingMore();
    final result = await _repository.getDeals(
        listingTypes: _listingTypes,
        dealScorecardTypes: _scorecardTypes,
        dealStatus: _dealStatus,
        fromDate: _rangeData.first.millisecondsSinceEpoch,
        toDate: _rangeData.last.millisecondsSinceEpoch,
        textSearch: _keySearch,
        page: _currentPage,
        numberItem: _totalItem);

    /* Handle error */
    if (result.error != null) {
      yield DataLoadError(result.error.message);
      _isLoading = false;
      return;
    }

    /* Handle success */
    if (result.success != null) {
      _totalPage = result.success.totalPages;
      yield DataTotalItem(result.success.totalItems);
      yield DataLoadDone(result.success.list);
      _isLoading = false;
    }
  }
}

extension ListExtention<T> on List<T> {
  void replaceAll(List<T> newList) {
    this.clear();
    this.addAll(newList);
  }
}
