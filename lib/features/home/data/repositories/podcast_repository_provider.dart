
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:podcast_finder/features/home/data/datasources/podcast_remote_data_source_provider.dart';
import 'package:podcast_finder/features/home/data/repositories/podcast_repository_impl.dart';
import 'package:podcast_finder/features/home/domain/repositories/podcast_repository.dart';

final podcastRepositoryProvider = Provider<PodcastRepository>((ref) {
  final dataSource = ref.watch(podcastRemoteDataSourceProvider);
  return PodcastRepositoryImpl(dataSource);
});