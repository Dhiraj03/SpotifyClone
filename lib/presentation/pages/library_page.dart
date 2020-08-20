import 'dart:io';

import 'package:SpotifyClone/core/audio_player.dart';
import 'package:SpotifyClone/data/datasources/local_storage.dart';
import 'package:SpotifyClone/data/models/song_details_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

class LibraryPage extends StatefulWidget {
  @override
  _LibraryPageState createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage> {
  final LocalStorage localStorage = LocalStorage();
  @override
  Widget build(BuildContext context) {
    print(localStorage.getSongsLength());
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: FractionalOffset(0, 0),
              end: FractionalOffset(0.22, 0.32),
              colors: [
            Color(0xE06E548F),
            Color(0xE05B4773),
            Color(0xE0483A58),
            Color(0xE0342E3C),
            Theme.of(context).primaryColor.withAlpha(130)
          ])),
      padding: const EdgeInsets.only(left: 8.0, top: 30),
      child: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: localStorage.getSongsLength(),
              itemBuilder: (BuildContext context, int index) {
                var tempSong = localStorage.getSong(index);
                print(localStorage.getSong(index).title);
                return ListTile(
                  onTap: () {
                    Provider.of<AudioPlayer>(context, listen: false).playSong(tempSong.songID);
                  },
                  leading: Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: FileImage(File(tempSong.imagePath)),
                            fit: BoxFit.cover)),
                  ),
                  title: Text(tempSong.title),
                  subtitle: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(tempSong.album),
                      Text('  .  '),
                      Text(tempSong.artists)
                    ],
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
