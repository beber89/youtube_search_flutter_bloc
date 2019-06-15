import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:youtube_search_flutter_bloc/data/repository/youtube_repository.dart';
import 'package:youtube_search_flutter_bloc/ui/detail/detail_event.dart';
import 'package:youtube_search_flutter_bloc/ui/detail/detail_state.dart';
import 'package:youtube_search_flutter_bloc/data/model/detail/model_detail.dart';

 class DetailBloc extends Bloc<DetailEvent, DetailState> {
  YoutubeRepository repository;

   DetailBloc(this.repository);

   void onShowDetail({@required String id}) {
    dispatch(ShowDetail((b) => b..id = id));
  }

   @override
  DetailState get initialState => DetailState.initial();

   @override
  Stream<DetailState> mapEventToState(
    DetailState currentState,
    DetailEvent event,
  ) async* {
    if (event is ShowDetail) {
      yield DetailState.loading();

       try {
        final videoItem = await repository.fetchVideoInfo(id: event.id);
        yield DetailState.success(videoItem);
      } on YoutubeVideoError catch (e) {
        yield DetailState.failure(e.message);
      } on NoSuchVideoException catch (e) {
        yield DetailState.failure(e.message);
      }
    }
  }
}