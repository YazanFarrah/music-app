import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AudioWave extends StatefulWidget {
  final String path;
  const AudioWave({
    super.key,
    required this.path,
  });

  @override
  State<AudioWave> createState() => _AudioWaveState();
}

class _AudioWaveState extends State<AudioWave> {
  final _playerController = PlayerController();
  @override
  void initState() {
    initAudioPlayer();
    super.initState();
  }

  void initAudioPlayer() async {
    _playerController.preparePlayer(path: widget.path);
  }

  @override
  void dispose() {
    _playerController.dispose();
    super.dispose();
  }

  Future<void> playAndPause() async {
    if (!_playerController.playerState.isPlaying) {
      await _playerController.startPlayer(finishMode: FinishMode.stop);
    } else if (!_playerController.playerState.isPaused) {
      await _playerController.pausePlayer();
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: playAndPause,
          icon: Icon(
            _playerController.playerState.isPlaying
                ? CupertinoIcons.pause_solid
                : CupertinoIcons.play_arrow_solid,
          ),
        ),
        Expanded(
          child: AudioFileWaveforms(
            playerWaveStyle: PlayerWaveStyle(
              liveWaveColor: Theme.of(context).primaryColor,
              spacing: 7,
              seekLineThickness: 1,
            ),
            size: const Size(double.infinity, 100),
            playerController: _playerController,
          ),
        ),
      ],
    );
  }
}
