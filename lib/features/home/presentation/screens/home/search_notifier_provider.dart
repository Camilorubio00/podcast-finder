import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:podcast_finder/features/home/data/repositories/podcast_repository_provider.dart';
import 'package:podcast_finder/features/home/presentation/screens/home/search_notifier.dart';
import 'package:podcast_finder/features/home/presentation/screens/home/search_state.dart';

final searchNotifierProvider = StateNotifierProvider<SearchNotifier, SearchState>((ref) {
  final repository = ref.watch(podcastRepositoryProvider);
  return SearchNotifier(repository);
});