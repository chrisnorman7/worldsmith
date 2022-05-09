// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'world_command_trigger.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WorldCommandTrigger _$WorldCommandTriggerFromJson(Map<String, dynamic> json) =>
    WorldCommandTrigger(
      commandTrigger: CommandTrigger.fromJson(
          json['commandTrigger'] as Map<String, dynamic>),
      startCommand: json['startCommand'] == null
          ? null
          : CallCommand.fromJson(json['startCommand'] as Map<String, dynamic>),
      stopCommand: json['stopCommand'] == null
          ? null
          : CallCommand.fromJson(json['stopCommand'] as Map<String, dynamic>),
      interval: json['interval'] as int?,
      zone: json['zone'] as bool? ?? true,
      mainMenu: json['mainMenu'] as bool? ?? false,
      lookAroundMenu: json['lookAroundMenu'] as bool? ?? false,
      pauseMenu: json['pauseMenu'] as bool? ?? false,
      soundOptionsMenu: json['soundOptionsMenu'] as bool? ?? false,
      zoneOverview: json['zoneOverview'] as bool? ?? false,
      scenes: json['scenes'] as bool? ?? false,
    );

Map<String, dynamic> _$WorldCommandTriggerToJson(
        WorldCommandTrigger instance) =>
    <String, dynamic>{
      'commandTrigger': instance.commandTrigger,
      'startCommand': instance.startCommand,
      'stopCommand': instance.stopCommand,
      'interval': instance.interval,
      'zone': instance.zone,
      'mainMenu': instance.mainMenu,
      'pauseMenu': instance.pauseMenu,
      'lookAroundMenu': instance.lookAroundMenu,
      'zoneOverview': instance.zoneOverview,
      'soundOptionsMenu': instance.soundOptionsMenu,
      'scenes': instance.scenes,
    };
