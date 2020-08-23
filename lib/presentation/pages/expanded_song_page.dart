import 'dart:io';

import 'package:SpotifyClone/core/audio_player.dart';
import 'package:SpotifyClone/core/hive_model_converter.dart';
import 'package:SpotifyClone/data/datasources/local_storage.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ExpandedSongPage extends StatefulWidget {
  @override
  _ExpandedSongPageState createState() => _ExpandedSongPageState();
}

class _ExpandedSongPageState extends State<ExpandedSongPage> {
  LocalStorage localStorage;
  @override
  void initState() {
    localStorage = LocalStorage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: FractionalOffset(0, 0),
                end: FractionalOffset(1, 1),
                colors: [
              Color(0x4ECC0066),
              Color(0x4EAA0055),
              Color(0x4E880044),
              Color(0x4E660033),
              Color(0x4E440022),
              Color(0x4E220011),
              Theme.of(context).primaryColor.withAlpha(130)
            ])),
        child: StreamBuilder(
            stream: Provider.of<AudioPlayer>(context).getCurrentlyPlaying(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              print(snapshot.data);
              if ((snapshot.hasData &&
                  snapshot.connectionState == ConnectionState.active)) {
                int currentSongDuration = Provider.of<AudioPlayer>(context)
                    .getDurationOfCurrentSong();
                return Padding(
                    padding: EdgeInsets.only(top: 60.0, left: 45, right: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                            child: Image.file(File(snapshot.data.imagePath))),
                        SizedBox(
                          height: 30,
                        ),
                        Text(snapshot.data.title,
                            softWrap: true,
                            style: GoogleFonts.montserrat(
                              color: Colors.white,
                              fontSize: 27,
                              fontWeight: FontWeight.w600,
                            )),
                        Text(snapshot.data.artists,
                            style: GoogleFonts.montserrat(
                                color: Colors.grey,
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                height: 1.5)),
                        SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(top: 20, right: 15),
                              child: IconButton(
                                  icon: Icon(
                                    MaterialCommunityIcons.skip_previous,
                                    size: 40,
                                  ),
                                  onPressed: () {}),
                            ),
                            Expanded(
                              child: StreamBuilder<Object>(
                                  stream: Provider.of<AudioPlayer>(context)
                                      .isPlaying(),
                                  builder: (context, isPlaySnap) {
                                    if (isPlaySnap.hasData &&
                                        isPlaySnap.connectionState ==
                                            ConnectionState.active) {
                                      return IconButton(
                                          icon: isPlaySnap.data
                                              ? Icon(
                                                  MaterialCommunityIcons
                                                      .pause_circle,
                                                  size: 70)
                                              : Icon(
                                                  MaterialCommunityIcons
                                                      .play_circle,
                                                  size: 70),
                                          onPressed: () {
                                            Provider.of<AudioPlayer>(context,
                                                    listen: false)
                                                .playOrPause();
                                          });
                                    } else {
                                      return Container(
                                        height: 0,
                                        width: 0,
                                      );
                                    }
                                  }),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 20, right: 5),
                              child: IconButton(
                                  icon: Icon(MaterialCommunityIcons.skip_next,
                                      size: 40),
                                  onPressed: () {}),
                            ),
                            SizedBox(
                              width: 5,
                            )
                          ],
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        StreamBuilder<Object>(
                            stream: Provider.of<AudioPlayer>(context)
                                .getCurrentPosition(),
                            builder: (context1, AsyncSnapshot snap) {
                              if (snap.hasData) {
                                print(snap.data);
                                print(currentSongDuration);
                                return Slider(
                                  activeColor: Colors.white,
                                  inactiveColor: Colors.grey,
                                  value: snap.data.toDouble(),
                                  min: 0,
                                  max: (currentSongDuration + 1).toDouble(),
                                  onChanged: (value) {
                                    Provider.of<AudioPlayer>(context,
                                            listen: false)
                                        .seek(value.toInt());
                                  },
                                );
                              }
                            })
                      ],
                    ));
              } else {
                print('inside');
                var tempSong = localStorage.getLastPlayedSong();

                return Padding(
                  padding: EdgeInsets.only(top: 60.0, left: 45, right: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(child: Image.file(File(tempSong.imagePath))),
                      SizedBox(
                        height: 30,
                      ),
                      Text(tempSong.title,
                          softWrap: true,
                          style: GoogleFonts.montserrat(
                            color: Colors.white,
                            fontSize: 27,
                            fontWeight: FontWeight.w600,
                          )),
                      Text(tempSong.artists,
                          style: GoogleFonts.montserrat(
                              color: Colors.grey,
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              height: 1.5)),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(top: 20, right: 15),
                            child: IconButton(
                                icon: Icon(
                                  MaterialCommunityIcons.skip_previous,
                                  size: 40,
                                ),
                                onPressed: () {}),
                          ),
                          Expanded(
                            child: StreamBuilder<Object>(
                                stream: Provider.of<AudioPlayer>(context)
                                    .isPlaying(),
                                builder: (context, isPlaySnap) {
                                  if (isPlaySnap.hasData &&
                                      isPlaySnap.connectionState ==
                                          ConnectionState.active) {
                                    return IconButton(
                                        icon: isPlaySnap.data
                                            ? Icon(
                                                MaterialCommunityIcons
                                                    .pause_circle,
                                                size: 70)
                                            : Icon(
                                                MaterialCommunityIcons
                                                    .play_circle,
                                                size: 70),
                                        onPressed: () {
                                          Provider.of<AudioPlayer>(context,
                                                  listen: false)
                                              .playOrPause();
                                        });
                                  } else {
                                    return Container(
                                      height: 0,
                                      width: 0,
                                    );
                                  }
                                }),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 20, right: 5),
                            child: IconButton(
                                icon: Icon(MaterialCommunityIcons.skip_next,
                                    size: 40),
                                onPressed: () {}),
                          ),
                          SizedBox(
                            width: 5,
                          )
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      StreamBuilder<Object>(
                          stream: Provider.of<AudioPlayer>(context)
                              .getCurrentPosition(),
                          builder: (context, AsyncSnapshot snap) {
                            int currentSongDuration =
                                Provider.of<AudioPlayer>(context)
                                    .getDurationOfCurrentSong();
                            if (snap.hasData) {
                              print(snap.data);
                              print(currentSongDuration);
                              return Slider(
                                inactiveColor: Colors.grey,
                                activeColor: Colors.white,
                                value: snap.data.toDouble(),
                                min: 0,
                                max: currentSongDuration.toDouble(),
                                onChanged: (value) {
                                  Provider.of<AudioPlayer>(context,
                                          listen: false)
                                      .seek(value.toInt());
                                },
                              );
                            } else {
                              print('whatt');
                              return Slider(
                                inactiveColor: Colors.grey,
                                activeColor: Colors.white,
                                value: 0,
                                min: 0,
                                max: currentSongDuration.toDouble(),
                                onChanged: (value) {
                                  print('damn');
                                  Provider.of<AudioPlayer>(context,
                                          listen: false)
                                      .seek(value.toInt());
                                },
                              );
                            }
                          })
                    ],
                  ),
                );
              }
            }),
      ),
    );
  }
}
