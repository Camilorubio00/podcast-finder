import 'package:json_annotation/json_annotation.dart';

part 'episode_model.g.dart';

@JsonSerializable()
class EpisodeModel {
  final String id;
  final String title;
  final String? description;
  @JsonKey(name: 'pub_date_ms')
  final int publishDateMs;
  @JsonKey(name: 'audio_length_sec')
  final int audioLengthSec;

  const EpisodeModel({
    required this.id,
    required this.title,
    this.description,
    required this.publishDateMs,
    required this.audioLengthSec,
  });

  factory EpisodeModel.fromJson(Map<String, dynamic> json) =>
      _$EpisodeModelFromJson(json);

  Map<String, dynamic> toJson() => _$EpisodeModelToJson(this);

  EpisodeModel copyWith({
    String? id,
    String? title,
    String? description,
    int? publishDateMs,
    int? audioLengthSec,
  }) {
    return EpisodeModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      publishDateMs: publishDateMs ?? this.publishDateMs,
      audioLengthSec: audioLengthSec ?? this.audioLengthSec,
    );
  }
}

