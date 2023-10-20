import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:musicplayer_project/model/song_model/mysongmodel.dart';
import 'package:musicplayer_project/utils/images/images_constants.dart';
import 'package:musicplayer_project/view/bottom_navigation/bottom_navigation.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    checkPermission();

    Future.delayed(Duration(seconds: 2)).then((value) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => BottomNavigationScreen()));
    });
    return Scaffold(
        body: Center(
      child: CircleAvatar(
        radius: 60,
        backgroundImage: AssetImage(ImagesConstants.logo),
      ),
    ));
  }

  checkPermission() async {
    final status = await Permission.storage.status;

    if (status.isDenied) {
      await Permission.storage.request();
      checkPermission();
    } else if (status.isGranted) {}
    final List<SongModel> externalSongs = await audioQuery.querySongs(
        sortType: SongSortType.DATE_ADDED,
        orderType: OrderType.ASC_OR_SMALLER,
        uriType: UriType.EXTERNAL,
        ignoreCase: true);

    final songs = externalSongs.map((e) => MySongModel(
        id: e.id,
        title: e.title,
        displayName: e.displayName,
        artist: e.artist!,
        duration: e.duration,
        url: e.uri));

    allSongsList.addAll(songs);
  }
}

final OnAudioQuery audioQuery = OnAudioQuery();
List<MySongModel> allSongsList = [];
final player = AudioPlayer();
