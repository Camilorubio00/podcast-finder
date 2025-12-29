import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:podcast_finder/core/network/dio_client.dart';
import 'package:podcast_finder/features/home/data/datasources/podcast_remote_data_source.dart';
import 'package:podcast_finder/features/home/data/datasources/podcast_remote_data_source_impl.dart';

final podcastRemoteDataSourceProvider = Provider<PodcastRemoteDataSource>((ref) {
  final dio = ref.watch(dioProvider);
  return PodcastRemoteDataSourceImpl(dio);
});