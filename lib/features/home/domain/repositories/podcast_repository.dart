import 'package:podcast_finder/features/home/data/models/podcast_model.dart';
import 'package:podcast_finder/features/home/data/models/podcast_detail_model.dart';

abstract class PodcastRepository {
  Future<List<PodcastModel>> searchPodcastBy({required String query});
  Future<PodcastDetailModel> getPodcastBy({required String id});
}