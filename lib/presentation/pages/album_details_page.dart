import 'dart:io';

import 'package:SpotifyClone/core/audio_player.dart';
import 'package:SpotifyClone/data/datasources/local_storage.dart';
import 'package:SpotifyClone/data/models/playlist_model.dart';
import 'package:SpotifyClone/data/models/song_details_model.dart';
import 'package:SpotifyClone/routes/router.gr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AlbumDetailsPage extends StatefulWidget {
  final int id;
  AlbumDetailsPage({@required this.id});
  @override
  _AlbumDetailsPageState createState() => _AlbumDetailsPageState();
}

class _AlbumDetailsPageState extends State<AlbumDetailsPage> {
  int get id => widget.id;
  LocalStorage localStorage = LocalStorage();
  PlaylistModel playlist;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    playlist = localStorage.getPlaylist(id);
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          centerTitle: true,
          title: Text(playlist.name),
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Router.navigator.pop();
              }),
        ),
        body: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              Center(
                child: Container(
                  height: 250,
                  width: 250,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: FileImage(File(playlist.imagePath)),
                          fit: BoxFit.fitHeight)),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: 220,
                height: 50,
                child: RaisedButton(
                    color: Colors.teal[500],
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    child: Text('SHUFFLE  PLAY',
                        style: GoogleFonts.montserrat(
                            color: Colors.white, fontSize: 20)),
                    onPressed: () {
                      Provider.of<AudioPlayer>(context, listen: false)
                          .playlistOnShuffle(playlist);
                    }),
              ),
              SizedBox(height: 20),
              Container(
                width: 120,
                height: 35,
                child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    color: Colors.black,
                    child: Text(
                      'ADD SONGS',
                      style: GoogleFonts.montserrat(
                          color: Colors.white, fontSize: 14),
                    ),
                    onPressed: () {
                      List<SongDetailsModel> songsToBeAdded = [];
                      showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return Container(
                              child: Column(
                                children: <Widget>[
                                  StatefulBuilder(builder:
                                      (BuildContext context,
                                          StateSetter setState) {
                                    return ListView.builder(
                                      physics: ScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount:
                                            localStorage.getSongsLength(),
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          var tempSong =
                                              localStorage.getSong(index);
                                          return ListTile(
                                              onTap: () {
                                                Provider.of<AudioPlayer>(
                                                        context,
                                                        listen: false)
                                                    .playSong(tempSong.songID);
                                              },
                                              leading: Container(
                                                height: 100,
                                                width: 70,
                                                decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                        image: FileImage(File(
                                                            tempSong
                                                                .imagePath)),
                                                        fit: BoxFit.fitWidth)),
                                              ),
                                              trailing: songsToBeAdded
                                                      .contains(tempSong)
                                                  ? IconButton(
                                                      icon: Icon(
                                                        MaterialCommunityIcons
                                                            .check_circle,
                                                        color: Colors.teal[500],
                                                      ),
                                                      onPressed: () {
                                                        songsToBeAdded
                                                            .remove(tempSong);
                                                        setState(() {});
                                                      })
                                                  : IconButton(
                                                      icon: Icon(
                                                          MaterialCommunityIcons
                                                              .circle_outline,
                                                          color: Colors.grey),
                                                      onPressed: () {
                                                        songsToBeAdded
                                                            .add(tempSong);
                                                        setState(() {});
                                                      }),
                                              title: Text(tempSong.title),
                                              isThreeLine: true,
                                              subtitle: Text(tempSong.album +
                                                  '  ~  ' +
                                                  tempSong.artists));
                                        });
                                  }),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Container(
                                    height: 50,
                                    width: 200,
                                    child: RaisedButton(
                                       
                                      elevation: 0,
                                      color: Colors.black,
                                      shape: RoundedRectangleBorder(
                                        
                                        borderRadius: BorderRadius.circular(30)
                                      ),

                                        child: Text('ADD  SONGS',
                                            style: GoogleFonts.montserrat(
                                              fontSize: 15,
                                              color: Colors.white,
                                            )),
                                        onPressed: () {
                                          songsToBeAdded.forEach((song) {
                                            localStorage.addSongToPlayList(
                                                song, id);
                                          });
                                        }),
                                  )
                                ],
                              ),
                            );
                          });
                    }),
              ),
              Expanded(
                  child: ListView.builder(
                  physics: ScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: playlist.songs.length,
                    itemBuilder: (BuildContext context, int index) {
                      var tempSong = playlist.songs[index];
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
                                  isDismissible: true,
                                  isScrollControlled: true,
                                  context: context,
                                  builder: (BuildContext context) {
                                    return SingleChildScrollView(
                                      child: Container(
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
                                                        image: FileImage(File(
                                                            tempSong.imagePath)),
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
                                                        : (tempSong.isLiked ==
                                                                false
                                                            ? Icon(
                                                                MaterialCommunityIcons
                                                                    .heart_outline,
                                                                color:
                                                                    Colors.grey,
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
                                                          .likeSong(
                                                              tempSong.songID);

                                                      _scaffoldKey.currentState
                                                          .showSnackBar(SnackBar(
                                                              duration: Duration(
                                                                  milliseconds:
                                                                      500),
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
                                                    icon: Icon(
                                                      MaterialCommunityIcons
                                                          .music_note_plus,
                                                      color: Colors.grey,
                                                    ),
                                                    onPressed: () {
                                                      Router.navigator
                                                          .pushNamed(
                                                              Router
                                                                  .addSongToPlaylist,
                                                              arguments:
                                                                  tempSong.songID)
                                                          .whenComplete(() {
                                                        Router.navigator.pop();
                                                      });
                                                    }),
                                                SizedBox(
                                                  width: 20,
                                                ),
                                                Text('Add song to Playlist',
                                                    style: GoogleFonts.montserrat(
                                                      fontSize: 20,
                                                    ))
                                              ],
                                            ),
                                            Row(
                                              children: <Widget>[
                                                IconButton(
                                                    icon: Icon(
                                                      MaterialCommunityIcons
                                                          .playlist_plus,
                                                      color: Colors.grey,
                                                    ),
                                                    onPressed: () {}),
                                                SizedBox(
                                                  width: 20,
                                                ),
                                                Text('Add song to Queue',
                                                    style: GoogleFonts.montserrat(
                                                      fontSize: 20,
                                                    ))
                                              ],
                                            ),
                                            Row(
                                              children: <Widget>[
                                                IconButton(
                                                    icon: Icon(
                                                      MaterialCommunityIcons
                                                          .album,
                                                      color: Colors.grey,
                                                    ),
                                                    onPressed: () {
                                                      Router.navigator
                                                          .pushNamed(
                                                              Router
                                                                  .addSongToPlaylist,
                                                              arguments:
                                                                  tempSong.songID)
                                                          .whenComplete(() {
                                                        Router.navigator.pop();
                                                      });
                                                    }),
                                                SizedBox(
                                                  width: 20,
                                                ),
                                                Text('View Album',
                                                    style: GoogleFonts.montserrat(
                                                      fontSize: 20,
                                                    ))
                                              ],
                                            ),
                                            Row(
                                              children: <Widget>[
                                                IconButton(
                                                    icon: Icon(
                                                      MaterialCommunityIcons
                                                          .artist,
                                                      color: Colors.grey,
                                                    ),
                                                    onPressed: () {
                                                      Router.navigator
                                                          .pushNamed(
                                                              Router
                                                                  .addSongToPlaylist,
                                                              arguments:
                                                                  tempSong.songID)
                                                          .whenComplete(() {
                                                        Router.navigator.pop();
                                                      });
                                                    }),
                                                SizedBox(
                                                  width: 20,
                                                ),
                                                Text('View Artists',
                                                    style: GoogleFonts.montserrat(
                                                      fontSize: 20,
                                                    ))
                                              ],
                                            ),
                                            SizedBox(
                                              height: 20,
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  });
                            },
                          ),
                          title: Text(tempSong.title),
                          isThreeLine: true,
                          subtitle:
                              Text(tempSong.album + '  ~  ' + tempSong.artists));
                    }),
              )
            ],
          ),
        ));
  }
}
