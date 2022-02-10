// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reverb_reference.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReverbReference _$ReverbReferenceFromJson(Map<String, dynamic> json) =>
    ReverbReference(
      id: json['id'] as String,
      reverbPreset:
          ReverbPreset.fromJson(json['reverbPreset'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ReverbReferenceToJson(ReverbReference instance) =>
    <String, dynamic>{
      'id': instance.id,
      'reverbPreset': instance.reverbPreset,
    };
