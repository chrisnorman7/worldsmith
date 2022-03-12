/// Provides the [ConversationLevel] class.
import 'package:ziggurat/levels.dart';
import 'package:ziggurat/menus.dart';
import 'package:ziggurat/sound.dart';
import 'package:ziggurat/ziggurat.dart';

import '../../util.dart';
import '../../world_context.dart';
import '../json/conversation/conversation.dart';
import '../json/conversation/conversation_branch.dart';
import '../json/sound.dart';
import '../json/world.dart';

/// A level for rendering its [conversation].
class ConversationLevel extends Level {
  /// Create an instance.
  ConversationLevel({required this.worldContext, required this.conversation})
      : super(
          game: worldContext.game,
          music: getMusic(
            assets: worldContext.world.musicAssets,
            sound: conversation.music,
          ),
        );

  /// The world context to use.
  final WorldContext worldContext;

  /// The conversation to render.
  final Conversation conversation;

  /// The current branch.
  ConversationBranch? branch;

  /// The sound channel to use.
  SoundChannel? soundChannel;

  /// The reverb to use.
  CreateReverb? reverb;

  /// The last sound to play.
  PlaySound? lastPlayedSound;

  /// Play a sound.
  void playSound({
    required Sound sound,
    required AssetList assets,
  }) {
    final world = worldContext.world;
    final reverbId = conversation.reverbId;
    if (reverb == null && reverbId != null) {
      final preset = world.getReverb(reverbId);
      reverb = game.createReverb(preset);
    }
    var channel = soundChannel;
    if (channel == null) {
      channel = game.createSoundChannel(
        gain: worldContext.playerPreferences.interfaceSoundsGain,
        reverb: reverb,
      );
      soundChannel = channel;
    }
    lastPlayedSound?.destroy();
    lastPlayedSound = channel.playSound(
      getAssetReferenceReference(assets: assets, id: sound.id).reference,
      gain: sound.gain,
    );
  }

  /// The level has been pushed.
  @override
  void onPush() {
    super.onPush();
    showBranch(branch ?? conversation.initialBranch);
  }

  /// Show the given [branch].
  void showBranch(ConversationBranch branch) {
    this.branch = branch;
    final world = worldContext.world;
    final sound = branch.sound;
    final menu = Menu(
      game: game,
      title: Message(
        gain: sound?.gain ?? world.soundOptions.defaultGain,
        keepAlive: true,
        sound: sound == null
            ? null
            : getAssetReferenceReference(
                    assets: world.conversationAssets, id: sound.id)
                .reference,
        text: branch.text,
      ),
      soundChannel: soundChannel,
      items: branch.responseIds.map<MenuItem>(
        (id) {
          final response = conversation.getResponse(id);
          final sound = response.sound;
          final assetReference = sound == null
              ? null
              : getAssetReferenceReference(
                      assets: world.conversationAssets, id: sound.id)
                  .reference;
          final message = Message(
            gain: sound?.gain ?? world.soundOptions.defaultGain,
            keepAlive: true,
            sound: assetReference,
            text: response.text,
          );
          return MenuItem(
            message,
            Button(
              () {
                game.popLevel();
                final callCommand = response.command;
                if (callCommand != null) {
                  worldContext.runCallCommand(callCommand: callCommand);
                }
                final nextBranch = response.nextBranch;
                if (nextBranch != null) {
                  game.callAfter(
                    func: () =>
                        showBranch(conversation.getBranch(nextBranch.branchId)),
                    runAfter: (nextBranch.fadeTime * 1000).floor(),
                  );
                }
                if (callCommand == null && nextBranch == null) {
                  // The conversation is over.
                  game.popLevel();
                }
              },
            ),
          );
        },
      ).toList(),
    );
    game.pushLevel(menu);
  }
}
