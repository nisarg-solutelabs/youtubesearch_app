import 'package:my_flutter/data/model/search/youtube_search_error.dart';
import 'package:my_flutter/data/repository/youtube_repository.dart';

import 'search.dart';
import 'package:bloc/bloc.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final YoutubeRepository _youtubeRepository;
  SearchBloc(this._youtubeRepository) : super();
  void onSearchInitiated(String query) {
    dispatch(SearchInitiated((b) => b..query = query));
  }

  @override
  SearchState get initialState => SearchState.initial();

  @override
  Stream<SearchState> mapEventToState(
      SearchState currentState, SearchEvent event) async* {
    if (event is SearchInitiated) {
      yield* mapSearchInitiated(event);
    } else if (event is FetchNextResultPage) {
      yield* mapFetchNextResultPage();
    }
  }

  Stream<SearchState> mapSearchInitiated(SearchInitiated event) async* {
    if (event.query.isEmpty) {
      yield SearchState.initial();
    } else {
      yield SearchState.loading();

      try {
        final searchResult = await _youtubeRepository.searchVideos(event.query);
        yield SearchState.success(searchResult);
      } on YoutubeSearchError catch (e) {
        yield SearchState.failture(e.message);
      } on NoSearchResultsException catch (e) {
        yield SearchState.failture(e.message);
      }
    }
  }

  Stream<SearchState> mapFetchNextResultPage() async* {
    try {
      final nextPageResults = await _youtubeRepository.fetchNextResultPage();
      yield SearchState.success(currentState.searchResults + nextPageResults);
    } on NoNextPageTokenException catch (_) {
      yield currentState.rebuild((b) => b..hasReachedEndOfResults = true);
    } on SearchNotInitiatedException catch (e) {
      yield SearchState.failture(e.message);
    } on YoutubeSearchError catch (e) {
      yield SearchState.failture(e.message);
    }
  }
}
