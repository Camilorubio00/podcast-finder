import 'package:podcast_finder/features/home/data/datasources/podcast_remote_data_source.dart';
import 'package:podcast_finder/features/home/data/models/podcast_model.dart';
import 'package:podcast_finder/features/home/domain/repositories/podcast_repository.dart';

class PodcastRepositoryImpl implements PodcastRepository {
  final PodcastRemoteDataSource _remoteDataSource;

  PodcastRepositoryImpl(this._remoteDataSource);

  @override
  Future<List<PodcastModel>> searchPodcastBy({required String query}) async {
    return await _remoteDataSource.searchPodcastBy(query: query);
  }
}
