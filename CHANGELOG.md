# Changelog

## []

## Changed

* Default command triggers can now be customised with the `World.defaultCommandTriggers` list.

## [0.19.0]

### Added

* Added a stats system.
* Added NPC's.
* Added the `AudioBus` class.
* Added the `World.getReverbPresetReference` method.
* Added the `WorldContext.getReverb` method.
* Allow `CustomSound` classes to play through a specific `AudioBus`.
* Added a look around function.

### Changed

* Updated lots of packages.
* Updated analysis options to make code cleaner.

### Removed

* Removed the `LocalTeleport` class.
* Removed the `CustomMessage` class.

## [0.18.0]

### Added

* Commands can now trigger rumble effects.
* Commands can now open URLs.

## [0.17.0]

### Added

* Added conversations.
* Ambiances and music will now fade when the game is paused.
* You can set a minimum gain for music and ambiances, so that they do not fade to silence.
* Added quests.
* Made the `WorldContext` class more configurable.
* Made it possible to add conditions to commands and conversation responses.
* Added scenes.

### Changed

* Renamed `WorldContext.runCallCommand` to `handleCallCommand` to bring the naming scheme in line with the other `handle*` methods.

## [0.16.0]

### Added

* added options for configuring synthizer.
* Added ambiances to zones.
* Start walking as soon as the appropriate trigger is pressed.
* Added a menu cancel sound.
* Optionally include libsndfile library file with the release.

### Changed

* Downgraded path.
* Updated ziggurat and ziggurat_sounds.

## [0.15.0]

### Added

* Added the `LocationMarker` class.
* Separated the `ZoneTeleport` and `LocalTeleport` classes.

### Changed

* Upgraded ziggurat and ziggurat_sounds.

## [0.14.0]

### Added

* Added the ability to set how far the player will turn in a given zone.
* A new heading can now be set with teleport commands.
* Added zone objects with the `ZoneObject` class.
* Replace a bunch of `CustomMessage` properties with `WorldCommand` ones.
* Added a command to be run when walking in a box.

## [0.13.0]

### Added

* Added world commands.
* Added the `WorldContext.errorHandler` callback to handle runtime errors.
* Added the `MainMenuOptions.startGameCommandId` field.

### Removed

* Removed some unused constants.

## [0.12.0]

### Added

* Added an event for hitting the edge of a zone.
* Added the `ZoneLevel.moveTo` method.
* Added the `CustomMessage` and `CustomSound` classes.
* Added the `WorldContext.getCustomMessage` method.
* Added the `WorldContext.getCustomSound` and `WorldContext.getAssetStore` methods.
* Allow previewing of a reverb with any sound in your project.

### Fixed

* Fixed a bug where lower coordinates were not checked when walking, leading to a `RangeError` being thrown.
* Make sure the proper reverb is set when walking.
* Tightened up walking code.

### Changed

* Started using `CustomMessage`s everywhere.
* Made generated code much more concise, with the use of the `WorldContext.loadEncrypted` constructor.

## [0.11.0]

### Changed

* The `ZoneLevel` class now uses box IDs rather than indices to store references to boxes.

## [0.10.0]

### Changed

* Reverted the changes I made in 0.9.0.

## [0.9.0]

### Changed

* Made `Box.start` and `Box.end` non-final.

## [0.8.0]

### Added

* Added a `size` property to the `ZoneLevel` class.

### Fixed

* Destroy reverbs and sound channels when popping `ZoneLevel` instances.

## [0.7.0]

### Added

* Added a "Zone Overview" menu item to `PauseMenu`.

## [0.6.1]

### Added

* Updated readme.

## [0.6.0]

### Changed

* Consolidate the [worldsmith_utils](https://pub.dev/packages/worldsmith_utils) package into this one.

## [0.5.0]

### Changed

* Use the [open_url](https://pub.dev/packages/open_url) package for opening credit URLs.

## [0.4.0]

### Added

* Credit URLs will now open in the user's web browser.

## [0.3.0]

## Added

* Added an ID to the `WorldCredit` class.
* More tests.

### Fixed

* Fixed a bug with the default `getCreditsMenu` function.

## [0.2.1]

### Added

* Updated the docs.

## [0.2.0]

### Added

* Start using a `WorldContext` class for running worlds.
* Make running games more configurable with event.
* Better test coverage.

## [0.1.0]

### Added

* Added a message for when the game is closing.

## [0.0.2]

### Fixed

* Fixed a string conversion bug in `loadEncrypted`.

## [0.0.1]

### Added

* Initial version.
