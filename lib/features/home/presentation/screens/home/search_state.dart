import 'package:podcast_finder/features/home/data/models/podcast_model.dart';

sealed class SearchState {}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchSuccess extends SearchState {
  final List<PodcastModel> podcastModelList;
  SearchSuccess(this.podcastModelList);
}

class SearchError extends SearchState {
  final String message;
  SearchError(this.message);
}

class SearchEmpty extends SearchState {}
