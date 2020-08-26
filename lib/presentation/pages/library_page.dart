import 'dart:io';
import 'package:SpotifyClone/core/audio_player.dart';
import 'package:SpotifyClone/data/datasources/local_storage.dart';
import 'package:SpotifyClone/routes/router.gr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class LibraryPage extends StatefulWidget {
  @override
  _LibraryPageState createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage> {
  final LocalStorage localStorage = LocalStorage();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    // localStorage.deleteSongs();
    print(localStorage.getSongsLength());
    return Scaffold(
      key: _scaffoldKey,
      body: Container(
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
                        Provider.of<AudioPlayer>(context, listen: false)
                            .playSong(tempSong.songID);
                      },
                      leading: Container(
                        height: 100,
                        width: 70,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: FileImage(File(tempSong.imagePath)),
                                fit: BoxFit.fitWidth)),
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.more_vert),
                        color: Colors.grey,
                        onPressed: () {
                          print(tempSong.isLiked);
                          showModalBottomSheet(
                              context: context,
                              builder: (BuildContext context) {
                                print(MediaQuery.of(context)
                                    .size
                                    .height
                                    .toString());
                                return Container(
                                  height: MediaQuery.of(context).size.height,
                                  width: MediaQuery.of(context).size.width,
                                  color: Colors.black,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Center(
                                        child: Container(
                                          height: 150,
                                          width: 150,
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  image: FileImage(
                                                      File(tempSong.imagePath)),
                                                  fit: BoxFit.fitHeight)),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Center(
                                        child: Text(tempSong.title,
                                            style: GoogleFonts.montserrat(
                                              fontSize: 25,
                                              color: Colors.white,
                                            )),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Center(
                                        child: Text(tempSong.artists,
                                            style: GoogleFonts.montserrat(
                                              fontSize: 15,
                                              color: Colors.grey,
                                            )),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Row(
                                        children: <Widget>[
                                          IconButton(
                                              icon: tempSong.isLiked == null
                                                  ? Icon(
                                                      MaterialCommunityIcons
                                                          .heart_outline,
                                                      color: Colors.grey)
                                                  : (tempSong.isLiked == false
                                                      ? Icon(
                                                          MaterialCommunityIcons
                                                              .heart_outline,
                                                          color: Colors.grey,
                                                        )
                                                      : Icon(
                                                          MaterialCommunityIcons
                                                              .heart,
                                                          color: Colors
                                                              .teal[600])),
                                              onPressed: () {
                                                Provider.of<AudioPlayer>(
                                                        context,
                                                        listen: false)
                                                    .likeSong(tempSong.songID);

                                                _scaffoldKey.currentState
                                                    .showSnackBar(SnackBar(
                                                        duration: Duration(
                                                            milliseconds: 500),
                                                        content: tempSong
                                                                .isLiked
                                                            ? Text(
                                                                'Added to Liked Songs')
                                                            : Text(
                                                                'Removed from Liked Songs')));
                                                Navigator.pop(context);
                                              }),
                                          SizedBox(
                                            width: 20,
                                          ),
                                          Text('Like',
                                              style: GoogleFonts.montserrat(
                                                fontSize: 20,
                                              ))
                                        ],
                                      ),
                                      Row(
                                        children: <Widget>[
                                          IconButton(
                                              icon: Icon(MaterialCommunityIcons
                                                  .playlist_plus),
                                              onPressed: () {
                                                Router.navigator
                                                    .pushNamed(
                                                        Router
                                                            .addSongToPlaylist,
                                                        arguments:
                                                            AddSongToPlaylistArguments(
                                                                songId: tempSong
                                                                    .songID))
                                                    .whenComplete(() {
                                                  Router.navigator.pop();
                                                });
                                              }),
                                          SizedBox(
                                            width: 20,
                                          ),
                                          Text('Like',
                                              style: GoogleFonts.montserrat(
                                                fontSize: 20,
                                              ))
                                        ],
                                      )
                                    ],
                                  ),
                                );
                              });
                        },
                      ),
                      title: Text(tempSong.title),
                      isThreeLine: true,
                      subtitle:
                          Text(tempSong.album + '  ~  ' + tempSong.artists));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
