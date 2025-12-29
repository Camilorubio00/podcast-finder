// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'podcast_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PodcastDetailModel _$PodcastDetailModelFromJson(Map<String, dynamic> json) =>
    PodcastDetailModel(
      id: json['id'] as String,
      title: json['title'] as String,
      publisher: json['publisher'] as String,
      image: json['image'] as String,
      description: json['description'] as String,
      genreIds: (json['genre_ids'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList(),
      episodes: (json['episodes'] as List<dynamic>)
          .map((e) => EpisodeModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PodcastDetailModelToJson(PodcastDetailModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'publisher': instance.publisher,
      'image': instance.image,
      'description': instance.description,
      'genre_ids': instance.genreIds,
      'episodes': instance.episodes,
    };
