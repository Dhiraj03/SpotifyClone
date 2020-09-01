import 'dart:io';

import 'package:SpotifyClone/core/audio_player.dart';
import 'package:SpotifyClone/core/hive_model_converter.dart';
import 'package:SpotifyClone/data/datasources/local_storage.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:provider/provider.dart';

class ExpandedSongPage extends StatefulWidget {
  @override
  _ExpandedSongPageState createState() => _ExpandedSongPageState();
}

class _ExpandedSongPageState extends State<ExpandedSongPage> {
  LocalStorage localStorage;
  Color color;
  Color textColor;
  @override
  void initState() {
    localStorage = LocalStorage();
    super.initState();
  }

  Color getTextColor(Color color) {
    if (color.computeLuminance() > 0.5)
      return Colors.grey[800];
    else
      return Colors.grey;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: Provider.of<AudioPlayer>(context).getCurrentStream(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data != null && snapshot.data[0] != null) {
              print(snapshot.data[0].audio.audio.metas.extra);
              print(snapshot.toString());
              return Container(
                color: Color(int.parse(snapshot
                        .data[0].audio.audio.metas.extra['color']
                        .substring(6, 16)))
                    .withOpacity(0.5),
                child: Dismissible(
                  direction: DismissDirection.horizontal,
                  key: Key(snapshot.data[1].inSeconds.toString() +
                      snapshot.data[0].index.toString()),
                  dismissThresholds: {
                    DismissDirection.endToStart: 0.01,
                    DismissDirection.startToEnd: 0.01,
                  },
                  confirmDismiss: (direction) async {
                    if (direction == DismissDirection.endToStart) {
                      Provider.of<AudioPlayer>(context, listen: false)
                          .playNext();
                      return true;
                    } else if (direction == DismissDirection.startToEnd) {
                      Provider.of<AudioPlayer>(context, listen: false)
                          .playPrevious();
                      return true;
                    }
                    return true;
                  },
                  child: Padding(
                      padding: EdgeInsets.only(top: 60.0, left: 20, right: 20),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Container(
                                child: Image.file(File(snapshot
                                    .data[0].audio.audio.metas.image.path))),
                            SizedBox(
                              height: 30,
                            ),
                            Text(snapshot.data[0].audio.audio.metas.title,
                                softWrap: true,
                                style: GoogleFonts.montserrat(
                                  color: Colors.white,
                                  fontSize: 27,
                                  fontWeight: FontWeight.w600,
                                )),
                            Text(snapshot.data[0].audio.audio.metas.artist,
                                style: GoogleFonts.montserrat(
                                    color: getTextColor(Color(int.parse(snapshot
                                        .data[0]
                                        .audio
                                        .audio
                                        .metas
                                        .extra['color']
                                        .substring(6, 16)))),
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    height: 1.5)),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(top: 15.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      Provider.of<AudioPlayer>(context,
                                              listen: false)
                                          .shufflePlaylist();
                                    },
                                    child: snapshot.data[4] == false
                                        ? Icon(FlutterIcons.ios_shuffle_ion,
                                            size: 43)
                                        : Icon(
                                            FlutterIcons.ios_shuffle_ion,
                                            size: 43,
                                            color: Colors.teal[600],
                                          ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Provider.of<AudioPlayer>(context,
                                            listen: false)
                                        .playPrevious();
                                  },
                                  child: Icon(
                                    MaterialCommunityIcons.skip_previous,
                                    size: 50,
                                  ),
                                ),
                                GestureDetector(
                                    child: snapshot.data[2]
                                        ? Icon(
                                            MaterialCommunityIcons.pause_circle,
                                            size: 70,
                                          )
                                        : Icon(
                                            MaterialCommunityIcons.play_circle,
                                            size: 70,
                                          ),
                                    onTap: () {
                                      Provider.of<AudioPlayer>(context,
                                              listen: false)
                                          .playOrPause();
                                    }),
                                GestureDetector(
                                  onTap: () {
                                    Provider.of<AudioPlayer>(context,
                                            listen: false)
                                        .playNext();
                                  },
                                  child: Icon(
                                    MaterialCommunityIcons.skip_next,
                                    size: 50,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 15.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      Provider.of<AudioPlayer>(context,
                                              listen: false)
                                          .toggleLoop();
                                    },
                                    child: snapshot.data[3] == LoopMode.none
                                        ? Icon(FlutterIcons.loop_sli, size: 30)
                                        : Icon(
                                            FlutterIcons.loop_sli,
                                            size: 30,
                                            color: Colors.teal[600],
                                          ),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Slider(
                              activeColor: Colors.white,
                              inactiveColor: getTextColor(Color(int.parse(
                                  snapshot
                                      .data[0].audio.audio.metas.extra['color']
                                      .substring(6, 16)))),
                              value: snapshot.data[1].inSeconds.toDouble(),
                              min: 0,
                              max: (snapshot.data[0].audio.duration.inSeconds
                                          .toDouble() +
                                      1)
                                  .toDouble(),
                              onChanged: (value) {
                                Provider.of<AudioPlayer>(context, listen: false)
                                    .seek(value.toInt(), snapshot.data[2],
                                        snapshot.data[0].audio.audio);
                              },
                            )
                          ])),
                ),
              );
            } else {
              print('null song');
              var audio = audioFromSongDetails(
                  Provider.of<AudioPlayer>(context).getLastPlayed());
              List<dynamic> snapshot = [
                audio,
                Duration.zero,
                false,
                false,
                false
              ];
              return Container(
                color: Color(int.parse(
                        snapshot[0].metas.extra['color'].substring(6, 16)))
                    .withOpacity(0.5),
                child: Padding(
                    padding: EdgeInsets.only(top: 60.0, left: 20, right: 20),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                              child: Image.file(
                                  File(snapshot[0].metas.image.path))),
                          SizedBox(
                            height: 30,
                          ),
                          Text(snapshot[0].metas.title,
                              softWrap: true,
                              style: GoogleFonts.montserrat(
                                color: Colors.white,
                                fontSize: 27,
                                fontWeight: FontWeight.w600,
                              )),
                          Text(snapshot[0].metas.artist,
                              style: GoogleFonts.montserrat(
                                  color: getTextColor(Color(int.parse(
                                      snapshot[0]
                                          .metas
                                          .extra['color']
                                          .substring(6, 16)))),
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  height: 1.5)),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(top: 15.0),
                                child: GestureDetector(
                                  onTap: () {
                                    Provider.of<AudioPlayer>(context,
                                            listen: false)
                                        .shufflePlaylist();
                                  },
                                  child: snapshot[4] == false
                                      ? Icon(FlutterIcons.ios_shuffle_ion,
                                          size: 43)
                                      : Icon(
                                          FlutterIcons.ios_shuffle_ion,
                                          size: 43,
                                          color: Colors.teal[600],
                                        ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {},
                                child: Icon(
                                  MaterialCommunityIcons.skip_previous,
                                  size: 50,
                                ),
                              ),
                              GestureDetector(
                                  child: snapshot[2]
                                      ? Icon(
                                          MaterialCommunityIcons.pause_circle,
                                          size: 70,
                                        )
                                      : Icon(
                                          MaterialCommunityIcons.play_circle,
                                          size: 70,
                                        ),
                                  onTap: () {
                                    Provider.of<AudioPlayer>(context,
                                            listen: false)
                                        .playOrPause();
                                  }),
                              GestureDetector(
                                onTap: () {},
                                child: Icon(
                                  MaterialCommunityIcons.skip_next,
                                  size: 50,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 15.0),
                                child: GestureDetector(
                                    onTap: () {
                                      Provider.of<AudioPlayer>(context,
                                              listen: false)
                                          .toggleLoop();
                                    },
                                    child:
                                        Icon(FlutterIcons.loop_sli, size: 30)),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Slider(
                            activeColor: Colors.white,
                            inactiveColor: getTextColor(Color(int.parse(
                                snapshot[0]
                                    .metas
                                    .extra['color']
                                    .substring(6, 16)))),
                            value: 0,
                            min: 0,
                            max: Provider.of<AudioPlayer>(context)
                                    .durationInSeconds
                                    .toDouble() ??
                                0,
                            onChanged: (value) {
                              print('called');
                              Provider.of<AudioPlayer>(context, listen: false)
                                  .seek(value.toInt(), snapshot[2], null);
                            },
                          )
                        ])),
              );
            }
          }),
    );
  }
}
