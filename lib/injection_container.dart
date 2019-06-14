import 'package:kiwi/kiwi.dart' as kiwi;
import 'package:http/http.dart' as http;
import 'package:youtube_search_flutter_bloc/data/network/youtube_data_source.dart';
import 'package:youtube_search_flutter_bloc/data/repository/youtube_repository.dart';
import 'package:youtube_search_flutter_bloc/ui/search/search_bloc.dart';

 void initKiwi() {
  kiwi.Container()
    ..registerInstance(http.Client())
    ..registerFactory((c) => YoutubeDataSource(c.resolve()))
    ..registerFactory((c) => YoutubeRepository(c.resolve()))
    ..registerFactory((c) => SearchBloc(c.resolve()));
}