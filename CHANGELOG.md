# Changelog

## [0.12.0]

### Added

* Added an event for hitting the edge of a zone.
* Added the `ZoneLevel.moveTo` method.
* Added the `CustomMessage` and `CustomSound` classes.
* Added the `WorldContext.getCustomMessage` method.
* Added the `WorldContext.getCustomSound` and `WorldContext.getAssetStore` methods.

### Fixed

* Fixed a bug where lower coordinates were not checked when walking, leading to a `RangeError` being thrown.
* Make sure the proper reverb is set when walking.
* Tightened up walking code.

### Changed

* Started using `CustomMessage`s everywhere.

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
