import 'package:podcast_finder/features/home/data/models/podcast_detail_model.dart';

sealed class DetailState {}

class DetailInitial extends DetailState {}

class DetailLoading extends DetailState {}

class DetailSuccess extends DetailState {
  final PodcastDetailModel podcastDetail;
  DetailSuccess(this.podcastDetail);
}

class DetailError extends DetailState {
  final String message;
  DetailError(this.message);
}

