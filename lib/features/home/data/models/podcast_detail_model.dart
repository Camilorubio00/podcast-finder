import 'package:json_annotation/json_annotation.dart';
import 'episode_model.dart';

part 'podcast_detail_model.g.dart';

@JsonSerializable()
class PodcastDetailModel {
  final String id;
  final String title;
  final String publisher;
  final String image;
  final String description;
  @JsonKey(name: 'genre_ids')
  final List<int>? genreIds;
  final List<EpisodeModel> episodes;

  const PodcastDetailModel({
    required this.id,
    required this.title,
    required this.publisher,
    required this.image,
    required this.description,
    this.genreIds,
    required this.episodes,
  });

  factory PodcastDetailModel.fromJson(Map<String, dynamic> json) =>
      _$PodcastDetailModelFromJson(json);

  Map<String, dynamic> toJson() => _$PodcastDetailModelToJson(this);

  PodcastDetailModel copyWith({
    String? id,
    String? title,
    String? publisher,
    String? image,
    String? description,
    List<int>? genreIds,
    List<EpisodeModel>? episodes,
  }) {
    return PodcastDetailModel(
      id: id ?? this.id,
      title: title ?? this.title,
      publisher: publisher ?? this.publisher,
      image: image ?? this.image,
      description: description ?? this.description,
      genreIds: genreIds ?? this.genreIds,
      episodes: episodes ?? this.episodes,
    );
  }
}

