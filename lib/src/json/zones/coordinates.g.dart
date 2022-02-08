// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coordinates.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CoordinateClamp _$CoordinateClampFromJson(Map<String, dynamic> json) =>
    CoordinateClamp(
      boxId: json['boxId'] as String,
      corner: $enumDecode(_$BoxCornerEnumMap, json['corner']),
    );

Map<String, dynamic> _$CoordinateClampToJson(CoordinateClamp instance) =>
    <String, dynamic>{
      'boxId': instance.boxId,
      'corner': _$BoxCornerEnumMap[instance.corner],
    };

const _$BoxCornerEnumMap = {
  BoxCorner.southwest: 'southwest',
  BoxCorner.southeast: 'southeast',
  BoxCorner.northeast: 'northeast',
  BoxCorner.northwest: 'northwest',
};

Coordinates _$CoordinatesFromJson(Map<String, dynamic> json) => Coordinates(
      json['x'] as int,
      json['y'] as int,
      clamp: json['clamp'] == null
          ? null
          : CoordinateClamp.fromJson(json['clamp'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CoordinatesToJson(Coordinates instance) =>
    <String, dynamic>{
      'x': instance.x,
      'y': instance.y,
      'clamp': instance.clamp,
    };
