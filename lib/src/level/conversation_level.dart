/// Provides the [ConversationLevel] class.
import 'package:ziggurat/levels.dart';
import 'package:ziggurat/menus.dart';
import 'package:ziggurat/sound.dart';
import 'package:ziggurat/ziggurat.dart';

import '../../util.dart';
import '../../world_context.dart';
import '../json/conversations/conversation.dart';
import '../json/conversations/conversation_branch.dart';
import '../json/conversations/start_conversation.dart';

/// A level for rendering its [conversation].
class ConversationLevel extends Level {
  /// Create an instance.
  ConversationLevel({
    required this.worldContext,
    required this.conversation,
    required this.pushInitialBranchAfter,
    required this.fadeTime,
  }) : super(
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

  /// How long to wait before pushing the initial branch.
  int pushInitialBranchAfter;

  /// The fade time to use.
  ///
  /// This value will be taken from a [StartConversation] instance.
  final int? fadeTime;

  /// The current branch.
  ConversationBranch? branch;

  /// The sound channel to use.
  SoundChannel? soundChannel;

  /// The reverb to use.
  CreateReverb? reverb;

  /// The level has been pushed.
  @override
  void onPush() {
    super.onPush();
    final reverbId = conversation.reverbId;
    if (reverbId != null && reverb == null) {
      final reverbPreset = worldContext.world.getReverb(reverbId);
      reverb = game.createReverb(reverbPreset);
    }
    soundChannel ??= game.createSoundChannel(
      reverb: reverb,
      gain: worldContext.playerPreferences.interfaceSoundsGain,
    );
    game.callAfter(
      func: () => showBranch(branch ?? conversation.initialBranch),
      runAfter: 5,
    );
  }

  /// Show the given [branch].
  void showBranch(final ConversationBranch branch) {
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
                assets: world.conversationAssets,
                id: sound.id,
              ).reference,
        text: branch.text,
      ),
      soundChannel: soundChannel,
      items: branch.responseIds.where((final element) {
        final response = conversation.getResponse(element);
        return worldContext.handleConditionals(response.conditions);
      }).map<MenuItem>(
        (final id) {
          final response = conversation.getResponse(id);
          final sound = response.sound;
          final assetReference = sound == null
              ? null
              : getAssetReferenceReference(
                  assets: world.conversationAssets,
                  id: sound.id,
                ).reference;
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
                  worldContext.handleCallCommand(callCommand: callCommand);
                }
                final nextBranch = response.nextBranch;
                if (nextBranch != null) {
                  game.callAfter(
                    func: () =>
                        showBranch(conversation.getBranch(nextBranch.branchId)),
                    runAfter: (nextBranch.fadeTime * 1000).floor(),
                  );
                } else {
                  final ambianceFadeTime = fadeTime;
                  // The conversation is over.
                  game.popLevel(
                    ambianceFadeTime: ambianceFadeTime == null
                        ? null
                        : (ambianceFadeTime / 1000),
                  );
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
