import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:podcast_finder/core/network/network_exceptions.dart';
import 'package:podcast_finder/core/utils/debouncer.dart';
import 'package:podcast_finder/features/home/domain/repositories/podcast_repository.dart';
import 'package:podcast_finder/features/home/presentation/screens/home/search_state.dart';

class SearchNotifier extends StateNotifier<SearchState> {
  final PodcastRepository _repository;
  final _debouncer = Debouncer(duration: const Duration(milliseconds: 500));

  SearchNotifier(this._repository) : super(SearchInitial());

  Future<void> search(String query) async {
    if (query.trim().isEmpty) {
      _debouncer.call(() => state = SearchInitial());
      return;
    }

    _debouncer.call(() async {
      try {
        state = SearchLoading();

        final results = await _repository.searchPodcastBy(query: query);

        if (results.isEmpty) {
          state = SearchEmpty();
        } else {
          state = SearchSuccess(results.take(10).toList());
        }
      } on NetworkException catch (exception) {
        state = SearchError(exception.toString());
      } catch (exception) {
        state = SearchError(exception.toString());
      }
    });
  }

  @override
  void dispose() {
    _debouncer.dispose();
    super.dispose();
  }
}
