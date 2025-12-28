import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:podcast_finder/core/network/network_exceptions.dart';
import 'package:podcast_finder/features/home/domain/repositories/podcast_repository.dart';
import 'package:podcast_finder/features/home/presentation/screens/detail/detail_state.dart';

class DetailNotifier extends StateNotifier<DetailState> {
  final PodcastRepository _repository;

  DetailNotifier(this._repository) : super(DetailInitial());

  Future<void> getPodcastById(String id) async {
    try {
      state = DetailLoading();

      final podcastDetail = await _repository.getPodcastBy(id: id);

      state = DetailSuccess(podcastDetail);
    } on NetworkException catch (exception) {
      state = DetailError(exception.toString());
    } catch (exception) {
      state = DetailError(exception.toString());
    }
  }
}

