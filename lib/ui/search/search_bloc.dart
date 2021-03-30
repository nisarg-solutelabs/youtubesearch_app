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
  // TODO: implement initialState
  SearchState get initialState => SearchState.initial();

  @override
  Stream<SearchState> mapEventToState(
      SearchState currentState, SearchEvent event) async* {
    if (event is SearchInitiated) {
      if (event.query.isEmpty) {
        yield SearchState.initial();
      } else {
        yield SearchState.loading();

        try {
          final searchResult =
              await _youtubeRepository.searchVideos(event.query);
          yield SearchState.success(searchResult);
        } on YoutubeSearchError catch (e) {
          yield SearchState.failture(e.message);
        } on NoSearchResultsException catch (e) {
          yield SearchState.failture(e.message);
        }
      }
    }
  }
}
