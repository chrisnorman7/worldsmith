// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sound_options.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SoundOptions _$SoundOptionsFromJson(Map<String, dynamic> json) => SoundOptions(
      defaultGain: (json['defaultGain'] as num?)?.toDouble() ?? 0.7,
      menuMoveSound: json['menuMoveSound'] == null
          ? null
          : Sound.fromJson(json['menuMoveSound'] as Map<String, dynamic>),
      menuActivateSound: json['menuActivateSound'] == null
          ? null
          : Sound.fromJson(json['menuActivateSound'] as Map<String, dynamic>),
      synthizerLogLevel:
          $enumDecodeNullable(_$LogLevelEnumMap, json['synthizerLogLevel']),
      synthizerLoggingBackend: $enumDecodeNullable(
          _$LoggingBackendEnumMap, json['synthizerLoggingBackend']),
      libsndfilePathLinux:
          json['libsndfilePathLinux'] as String? ?? './libsndfile.so',
      libsndfilePathWindows:
          json['libsndfilePathWindows'] as String? ?? 'libsndfile-1.dll',
      libsndfilePathMac:
          json['libsndfilePathMac'] as String? ?? 'libsndfile.dylib',
    )..menuCancelSound = json['menuCancelSound'] == null
        ? null
        : Sound.fromJson(json['menuCancelSound'] as Map<String, dynamic>);

Map<String, dynamic> _$SoundOptionsToJson(SoundOptions instance) =>
    <String, dynamic>{
      'defaultGain': instance.defaultGain,
      'menuMoveSound': instance.menuMoveSound,
      'menuActivateSound': instance.menuActivateSound,
      'menuCancelSound': instance.menuCancelSound,
      'synthizerLogLevel': _$LogLevelEnumMap[instance.synthizerLogLevel],
      'synthizerLoggingBackend':
          _$LoggingBackendEnumMap[instance.synthizerLoggingBackend],
      'libsndfilePathWindows': instance.libsndfilePathWindows,
      'libsndfilePathLinux': instance.libsndfilePathLinux,
      'libsndfilePathMac': instance.libsndfilePathMac,
    };

const _$LogLevelEnumMap = {
  LogLevel.error: 'error',
  LogLevel.warn: 'warn',
  LogLevel.info: 'info',
  LogLevel.debug: 'debug',
};

const _$LoggingBackendEnumMap = {
  LoggingBackend.none: 'none',
  LoggingBackend.stderr: 'stderr',
};
