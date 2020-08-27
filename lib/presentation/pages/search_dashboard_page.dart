import 'dart:io';

import 'package:SpotifyClone/core/audio_player.dart';
import 'package:SpotifyClone/presentation/bloc/search_bloc/search_bloc.dart';
import 'package:SpotifyClone/routes/router.gr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SearchDashboardPage extends StatefulWidget {
  @override
  _SearchDashboardPageState createState() => _SearchDashboardPageState();
}

class _SearchDashboardPageState extends State<SearchDashboardPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  TextEditingController searchController;
  SearchBloc searchBloc;
  @override
  void initState() {
    searchBloc = SearchBloc();
    searchController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      key: _scaffoldKey,
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
        child: BlocProvider<SearchBloc>(
          create: (_) => searchBloc,
          child: BlocBuilder<SearchBloc, SearchState>(
              bloc: searchBloc,
              builder: (BuildContext context, SearchState state) {
                if (state is SearchInitial) {
                  return ListView(children: <Widget>[
                    SizedBox(
                      height: 100,
                    ),
                    Text('SEARCH',
                        style: GoogleFonts.montserrat(
                            color: Colors.white, fontSize: 35)),
                    SizedBox(
                      height: 20,
                    ),
                    TextField(
                      controller: searchController,
                      onChanged: (_) {
                        print(searchController.text);
                        searchBloc.add(SearchQueryChanged(
                            searchQuery: searchController.text));
                      },
                    )
                  ]);
                } else if (state is SearchResult) {
                  print('new result');
                  return ListView(
                    children: <Widget>[
                      SizedBox(
                        height: 100,
                      ),
                      Text('SEARCH',
                          style: GoogleFonts.montserrat(
                              color: Colors.white, fontSize: 35)),
                      SizedBox(
                        height: 20,
                      ),
                      TextField(
                        controller: searchController,
                        onChanged: (_) {
                          print(searchController.text);
                          searchBloc.add(SearchQueryChanged(
                              searchQuery: searchController.text));
                        },
                      ),
                      ListView(
                        shrinkWrap: true,
                        children: <Widget>[
                          Text(
                            'Songs',
                            style: GoogleFonts.montserrat(
                              fontSize: 15,
                            ),
                          ),
                          Divider(
                            color: Colors.white,
                            endIndent: 10,
                            indent: 10,
                            thickness: 2,
                          ),
                          ListView.builder(
                              shrinkWrap: true,
                              itemCount: state.songs.length,
                              itemBuilder: (BuildContext context, int index) {
                                print('length' + state.songs.length.toString());
                                var tempSong = state.songs[index];
                                return ListTile(
                                    onTap: () {
                                      Provider.of<AudioPlayer>(context,
                                              listen: false)
                                          .playSong(tempSong.songID);
                                    },
                                    leading: Container(
                                      height: 100,
                                      width: 70,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: FileImage(
                                                  File(tempSong.imagePath)),
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
                                                        CrossAxisAlignment
                                                            .start,
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
                                                                      File(tempSong
                                                                          .imagePath)),
                                                                  fit: BoxFit
                                                                      .fitHeight)),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 20,
                                                      ),
                                                      Center(
                                                        child: Text(
                                                            tempSong.title,
                                                            style: GoogleFonts
                                                                .montserrat(
                                                              fontSize: 25,
                                                              color:
                                                                  Colors.white,
                                                            )),
                                                      ),
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      Center(
                                                        child: Text(
                                                            tempSong.artists,
                                                            style: GoogleFonts
                                                                .montserrat(
                                                              fontSize: 15,
                                                              color:
                                                                  Colors.grey,
                                                            )),
                                                      ),
                                                      SizedBox(
                                                        height: 20,
                                                      ),
                                                      Row(
                                                        children: <Widget>[
                                                          IconButton(
                                                              icon: tempSong
                                                                          .isLiked ==
                                                                      null
                                                                  ? Icon(
                                                                      MaterialCommunityIcons
                                                                          .heart_outline,
                                                                      color: Colors
                                                                          .grey)
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
                                                                          color:
                                                                              Colors.teal[600])),
                                                              onPressed: () {
                                                                Provider.of<AudioPlayer>(
                                                                        context,
                                                                        listen:
                                                                            false)
                                                                    .likeSong(
                                                                        tempSong
                                                                            .songID);

                                                                _scaffoldKey.currentState.showSnackBar(SnackBar(
                                                                    duration: Duration(
                                                                        milliseconds:
                                                                            500),
                                                                    content: tempSong
                                                                            .isLiked
                                                                        ? Text(
                                                                            'Added to Liked Songs')
                                                                        : Text(
                                                                            'Removed from Liked Songs')));
                                                                Navigator.pop(
                                                                    context);
                                                              }),
                                                          SizedBox(
                                                            width: 20,
                                                          ),
                                                          Text('Like',
                                                              style: GoogleFonts
                                                                  .montserrat(
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
                                                                color:
                                                                    Colors.grey,
                                                              ),
                                                              onPressed: () {
                                                                Router.navigator
                                                                    .pushNamed(
                                                                        Router
                                                                            .addSongToPlaylist,
                                                                        arguments:
                                                                            tempSong
                                                                                .songID)
                                                                    .whenComplete(
                                                                        () {
                                                                  Router
                                                                      .navigator
                                                                      .pop();
                                                                });
                                                              }),
                                                          SizedBox(
                                                            width: 20,
                                                          ),
                                                          Text(
                                                              'Add song to Playlist',
                                                              style: GoogleFonts
                                                                  .montserrat(
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
                                                                color:
                                                                    Colors.grey,
                                                              ),
                                                              onPressed: () {}),
                                                          SizedBox(
                                                            width: 20,
                                                          ),
                                                          Text(
                                                              'Add song to Queue',
                                                              style: GoogleFonts
                                                                  .montserrat(
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
                                                                color:
                                                                    Colors.grey,
                                                              ),
                                                              onPressed: () {
                                                                Router.navigator
                                                                    .pushNamed(
                                                                        Router
                                                                            .addSongToPlaylist,
                                                                        arguments:
                                                                            tempSong
                                                                                .songID)
                                                                    .whenComplete(
                                                                        () {
                                                                  Router
                                                                      .navigator
                                                                      .pop();
                                                                });
                                                              }),
                                                          SizedBox(
                                                            width: 20,
                                                          ),
                                                          Text('View Album',
                                                              style: GoogleFonts
                                                                  .montserrat(
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
                                                                color:
                                                                    Colors.grey,
                                                              ),
                                                              onPressed: () {
                                                                Router.navigator
                                                                    .pushNamed(
                                                                        Router
                                                                            .addSongToPlaylist,
                                                                        arguments:
                                                                            tempSong
                                                                                .songID)
                                                                    .whenComplete(
                                                                        () {
                                                                  Router
                                                                      .navigator
                                                                      .pop();
                                                                });
                                                              }),
                                                          SizedBox(
                                                            width: 20,
                                                          ),
                                                          Text('View Artists',
                                                              style: GoogleFonts
                                                                  .montserrat(
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
                                    subtitle: Text(tempSong.album +
                                        '  ~  ' +
                                        tempSong.artists));
                              })
                        ],
                      ),
                    ],
                  );
                } else
                  return CircularProgressIndicator();
              }),
        ),
      ),
    );
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}
