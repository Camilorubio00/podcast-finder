
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:podcast_finder/features/home/domain/repositories/podcast_repository.dart';
import 'package:podcast_finder/features/home/presentation/screens/home/search_state.dart';

class SearchNotifier extends StateNotifier<SearchState> {
  final PodcastRepository _repository;

  SearchNotifier(this._repository) : super(SearchInitial());

  Future<void> search(String query) async {
    try {
      state = SearchLoading();
      final results = await _repository.searchPodcastBy(query: query);
      if (results.isEmpty) {
        state = SearchEmpty();
      } else {
        state = SearchSuccess(results);
      }
    } catch (exception) {
      state = SearchError(exception.toString());
    }
  }
}