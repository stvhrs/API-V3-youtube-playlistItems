import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pertemuan15/models/video_model.dart';

import 'package:http/http.dart' as http;
import 'package:pertemuan15/youtube_widget/youtubeItem.dart';

const String _baseUrl = 'www.googleapis.com';

const Map<String, String> headers = {
  HttpHeaders.contentTypeHeader: 'application/json',
};

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  String? _nextPageToken;
  late int total;
  List<Video> listVideos = [];
  bool _loading = true;

  Future<void> fetchVideosFromPlaylist({
    required String playlistId,
  }) async {
    log('fetch');
    Map<String, String?> parameters = {
      'part': 'snippet',
      'playlistId': playlistId,
      'pageToken': _nextPageToken ?? "",
      'maxResults': '8',
      'key': 'AIzaSyBRnn7ViKwsP_IDRsvqAz_qxVQnZfuLl84',
    };

    Uri uri = Uri.https(
      _baseUrl,
      '/youtube/v3/playlistItems',
      parameters,
    );

    var response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      _nextPageToken = data['nextPageToken'];
      List<dynamic> videosJson = data['items'];

      total = data['pageInfo']['totalResults'];
      if (listVideos.length == total) {
        return;
      }
      for (var json in videosJson) {
        listVideos.add(
          Video.fromMap(
            json['snippet'],
          ),
        );
      }
      setState(() {});
      return;
    } else {
      throw json.decode(response.body);
    }
  }

  @override
  void initState() {
    _load();
    super.initState();
  }

  Future _load() async {
    _loading = true;
    if (mounted) {
      fetchVideosFromPlaylist(playlistId: 'PLy_6D98if3ULEtXtNSY_2qN21VCKgoQAE')
          .then((value) {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
      });
    }
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    log(listVideos.length.toString());

    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.grey.shade900,
      body: _loading
          ? const Center(
              child: CircularProgressIndicator(
                color: Colors.green,
              ),
            )
          : NotificationListener<ScrollNotification>(
              onNotification: (ScrollNotification scrollDetails) {
                if (!_loading &&
                    listVideos.length < total &&
                    scrollDetails.metrics.pixels ==
                        scrollDetails.metrics.maxScrollExtent) {
                  _load();
                  return true;
                }
                return false;
              },
              child: Column(
                children: [
                  const Text(
                    'Pertemuan 15',
                    style: TextStyle(
                        color: Colors.green,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.only(top: 5),
                      itemCount: listVideos.length,
                      itemBuilder: (BuildContext context, int index) {
                        Video video = listVideos[index];
                        return YoutubeItem(
                          index + 1,
                          video,
                        );
                      },
                    ),
                  ),
                ],
              )),
    ));
  }
}
