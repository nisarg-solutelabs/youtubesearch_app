import 'package:kiwi/kiwi.dart' as kiwi;
import 'package:http/http.dart' as http;
import 'package:my_flutter/data/network/youtube_data_source.dart';
import 'package:my_flutter/data/repository/youtube_repository.dart';
import 'package:my_flutter/ui/search/search.dart';

void initKiwi() {
  kiwi.Container()
    ..registerInstance(http.Client())
    ..registerFactory((c) => YoutubeDataSource(c.resolve()))
    ..registerFactory((c) => YoutubeRepository(c.resolve()))
    ..registerFactory((c) => SearchBloc(c.resolve()));
}
