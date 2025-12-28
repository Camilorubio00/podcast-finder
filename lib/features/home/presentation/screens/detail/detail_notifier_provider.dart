import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:podcast_finder/features/home/data/repositories/podcast_repository_provider.dart';
import 'package:podcast_finder/features/home/presentation/screens/detail/detail_notifier.dart';
import 'package:podcast_finder/features/home/presentation/screens/detail/detail_state.dart';

final detailNotifierProvider = StateNotifierProvider<DetailNotifier, DetailState>((ref) {
  final repository = ref.watch(podcastRepositoryProvider);
  return DetailNotifier(repository);
});

