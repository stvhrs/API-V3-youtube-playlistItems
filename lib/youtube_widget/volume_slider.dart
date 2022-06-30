// Copyright 2020 Sarbagya Dhaubanjar. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';


class VolumeSlider extends StatelessWidget {
  final _volume = ValueNotifier<int>(100);

  VolumeSlider({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        const Text(
          "Volume",
          style: TextStyle(color: Colors.white,fontWeight: FontWeight.w300),
        ),
        Expanded(
          child: ValueListenableBuilder(
            valueListenable: _volume,
            builder: (context, volume, _) {
              return Container(
                              child: Slider(
                  inactiveColor: Colors.grey,
                  value: double.parse(volume.toString()),
                  activeColor: Colors.green[400],
                  min: 0.0,
                  max: 100.0,
                  divisions: 10,
                  label: '$volume',
                  onChanged: (value) {
                    _volume.value = value.round();
                    context.ytController.setVolume(int.parse(volume.toString()));
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
