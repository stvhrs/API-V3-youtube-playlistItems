// Copyright 2020 Sarbagya Dhaubanjar. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

///
class PlayerStateSection extends StatelessWidget {
  const PlayerStateSection({super.key});

  @override
  Widget build(BuildContext context) {
    return YoutubeValueBuilder(
      builder: (context, value) {
        return Stack(alignment: Alignment.center,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 800),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: _getStateColor(value.playerState)!,
              ),
              width: 100,
              height: 20,
              padding: const EdgeInsets.all(8.0),
            
            ),Text(
                _getStateString(value.playerState)!,
                style: const TextStyle(
                  fontWeight: FontWeight.w300,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
          ],
        );
      },
    );
  }

  String? _getStateString(PlayerState state) {
    switch (state) {
      case PlayerState.unknown:
        return 'Waiting';
      case PlayerState.unStarted:
        return 'Loading';
      case PlayerState.ended:
        return 'End';
      case PlayerState.playing:
        return 'Playing';
      case PlayerState.paused:
        return 'Paused';
      case PlayerState.buffering:
        return 'Buffering';

      default:
        return 'Loading';
    }
  }

  Color? _getStateColor(PlayerState state) {
    switch (state) {
      case PlayerState.unknown:
        return Colors.black;
      case PlayerState.unStarted:
        return Colors.pink;
      case PlayerState.ended:
        return Colors.red;
      case PlayerState.playing:
        return Colors.green[400];
      case PlayerState.paused:
        return Colors.grey;
      case PlayerState.buffering:
        return Colors.yellow;
      default:
        return Colors.green;
    }
  }
}
