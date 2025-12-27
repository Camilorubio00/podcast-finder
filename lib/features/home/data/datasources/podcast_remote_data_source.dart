import 'package:podcast_finder/features/home/data/models/podcast_model.dart';

abstract class PodcastRemoteDataSource {
  Future<List<PodcastModel>> searchPodcastBy({required String query});
}