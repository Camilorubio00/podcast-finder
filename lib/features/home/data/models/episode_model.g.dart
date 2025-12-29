// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'episode_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EpisodeModel _$EpisodeModelFromJson(Map<String, dynamic> json) => EpisodeModel(
  id: json['id'] as String,
  title: json['title'] as String,
  description: json['description'] as String?,
  publishDateMs: (json['pub_date_ms'] as num).toInt(),
  audioLengthSec: (json['audio_length_sec'] as num).toInt(),
);

Map<String, dynamic> _$EpisodeModelToJson(EpisodeModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'pub_date_ms': instance.publishDateMs,
      'audio_length_sec': instance.audioLengthSec,
    };
