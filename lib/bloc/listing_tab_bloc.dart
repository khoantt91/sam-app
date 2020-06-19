import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:samapp/bloc/event/listing_tab_event.dart';
import 'package:samapp/bloc/state/listing_tab_state.dart';
import 'package:samapp/model/constant.dart';
import 'package:samapp/model/listing.dart';
import 'package:samapp/model/pair.dart';
import 'package:samapp/repository/repository.dart';
import 'package:samapp/utils/log/log.dart';

class ListingTabBloc extends Bloc<ListingTabEvent, ListingTabState> {
  //region Variables
  final RepositoryImp _repository;

  ListingTabBloc(this._repository);

  /* Define default filter data */
  final List<ListingScorecardTypes> _scorecardTypes = [
    ListingScorecardTypes.HIGH,
    ListingScorecardTypes.MEDIUM,
    ListingScorecardTypes.LOW,
    ListingScorecardTypes.UNCLASSIFIED,
  ];

  final Pair<DateTime, DateTime> _rangeData = Pair(DateTime.now().subtract(Duration(days: 30)), DateTime.now());
  String _keySearch = '';

  final List<Listing> _listings = [];
  int _totalItems = 0;
  int _currentPage = 0;
  int _totalPage = 0;
  int _totalItemInPage = 20;

  //endregion

  @override
  ListingTabState get initialState => ListingTabInitial();

  @override
  Stream<Transition<ListingTabEvent, ListingTabState>> transformEvents(Stream<ListingTabEvent> events, transitionFn) {
    final nonDebounceStream = events.where((event) => event is! ListingTabGetMoreData);
    final debounceStream = events.where((event) => event is ListingTabGetMoreData).debounceTime(Duration(milliseconds: 500));
    return super.transformEvents(MergeStream([nonDebounceStream, debounceStream]), transitionFn);
  }

  @override
  Stream<ListingTabState> mapEventToState(ListingTabEvent event) async* {
    if (event is ListingTabGetData) yield* _handleGetData(event);
    if (event is ListingTabGetMoreData) yield* _handleGetMoreData(event);
    if (event is ListingTabStartSearching) yield ListingTabSearchingBegin();
    if (event is ListingTabCancelSearching) yield ListingTabSearchingEnd();
  }

  Stream<ListingTabState> _handleGetData(ListingTabGetData event) async* {
    if (event.scorecardTypes != null) _scorecardTypes.replaceAll(event.scorecardTypes);
    if (event.rangeData != null) _rangeData.replaceAll(event.rangeData);
    if (event.keySearch != null) _keySearch = event.keySearch;

    Log.w('Hello');
    print('Hellobuffer(window)');

    _currentPage = 1;
    yield ListingTabGetDataInProgress();

    final result = await _repository.getListings(
      listingScorecardTypes: _scorecardTypes,
      fromDate: _rangeData.first.millisecondsSinceEpoch,
      toDate: _rangeData.last.millisecondsSinceEpoch,
      textSearch: _keySearch,
      page: _currentPage,
      numberItem: _totalItemInPage,
    );

    /* Handle error */
    if (result.error != null) {
      yield ListingTabGetDataFailure(result.error.message);
      return;
    }

    /* Handle success */
    if (result.success != null) {
      _listings.replaceAll(result.success.list);
      _totalItems = result.success.totalItems;
      _totalPage = result.success.totalItems;
      yield ListingTabGetDataSuccess(List.from(_listings), _listings.length >= _totalItems, _totalItems);
    }
  }

  Stream<ListingTabState> _handleGetMoreData(ListingTabGetMoreData event) async* {
    _currentPage++;
    if (_currentPage >= _totalPage) {
      Log.i('LOAD DONE => REACHED MAX LIST');
      return;
    }

    final result = await _repository.getListings(
        listingScorecardTypes: _scorecardTypes,
        fromDate: _rangeData.first.millisecondsSinceEpoch,
        toDate: _rangeData.last.millisecondsSinceEpoch,
        textSearch: _keySearch,
        page: _currentPage,
        numberItem: _totalItemInPage);

    /* Handle error */
    if (result.error != null) {
      yield ListingTabGetDataFailure(result.error.message);
      _currentPage--;
      return;
    }

    /* Handle success */
    if (result.success != null) {
      _totalPage = result.success.totalPages;
      _listings.addAll(result.success.list);
      _totalItems = result.success.totalItems;
      yield ListingTabGetDataSuccess(List.from(_listings), _listings.length >= _totalItems, _totalItems);
    }
  }
}

extension ListExtention<T> on List<T> {
  void replaceAll(List<T> newList) {
    this.clear();
    this.addAll(newList);
  }
}
