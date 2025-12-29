import 'package:podcast_finder/features/home/data/models/podcast_model.dart';

abstract class PodcastRepository {
  Future<List<PodcastModel>> searchPodcastBy({required String query});
}