import 'dart:io';

import 'package:SpotifyClone/data/datasources/local_storage.dart';
import 'package:SpotifyClone/data/models/playlist_model.dart';
import 'package:SpotifyClone/presentation/bloc/add_playlist_bloc/add_playlist_bloc.dart';
import 'package:SpotifyClone/routes/router.gr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:google_fonts/google_fonts.dart';

class AddSongToPlaylist extends StatefulWidget {
  final int songId;
  AddSongToPlaylist({@required this.songId});
  @override
  _AddSongToPlaylistState createState() => _AddSongToPlaylistState();
}

class _AddSongToPlaylistState extends State<AddSongToPlaylist> {
  int get id => widget.songId;
  TextEditingController nameController = TextEditingController();
  Image albumImage;
  final LocalStorage localStorage = LocalStorage();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Router.navigator.pop();
              }),
          backgroundColor: Colors.black,
          centerTitle: true,
          title: Text(
            'Add to Playlist',
            style: GoogleFonts.montserrat(color: Colors.white),
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            Container(
              width: 220,
              child: RaisedButton(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  color: Colors.teal[600],
                  child: Text('NEW  PLAYLIST',
                      style: GoogleFonts.montserrat(
                          color: Colors.white, fontSize: 17)),
                  onPressed: () {
                    showModalBottomSheet(
                        isDismissible: true,
                        isScrollControlled: true,
                        context: context,
                        builder: (BuildContext context) {
                          return BlocProvider<AddPlaylistBloc>(
                            create: (_) => AddPlaylistBloc(),
                            child: SingleChildScrollView(
                              child: BlocConsumer<AddPlaylistBloc,
                                      AddPlaylistState>(
                                  listener: (BuildContext context,
                                      AddPlaylistState state) {
                                if (state is PopModalSheet) {
                                  Router.navigator.pop();
                                }
                              }, builder: (BuildContext context,
                                      AddPlaylistState state) {
                                if (state is AddPlaylistInitial) {
                                  Map<String, bool> isSelected = {
                                    'Rock': false,
                                    'Pop': false,
                                    'Hip-Hop': false,
                                    'Jazz': false,
                                    'Folk': false,
                                    'Heavy Metal': false,
                                    'Country': false,
                                    'EDM': false,
                                    'Rhythm and Blues': false,
                                    'Rap': false,
                                    'Psychedelic': false,
                                    'Techno': false,
                                    'Alt Rock': false,
                                    'Soft Rock': false,
                                    'Chill': false,
                                    'Gaming': false,
                                    'Party': false,
                                    'Romance': false,
                                    'Indie': false,
                                    'Mood': false,
                                    'Workout': false,
                                  };
                                  return Container(
                                    color: Colors.black,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                        Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              FlatButton.icon(
                                                onPressed: () async {
                                                  BlocProvider.of<
                                                      AddPlaylistBloc>(context)
                                                    ..add(PickAlbumArt());
                                                },
                                                icon: Icon(
                                                  MaterialCommunityIcons.album,
                                                  color: Theme.of(context)
                                                      .textSelectionColor,
                                                ),
                                                label: Text(
                                                  'Choose the album art',
                                                  style: GoogleFonts.montserrat(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      letterSpacing: 0.6),
                                                ),
                                              ),
                                              BlocProvider.of<AddPlaylistBloc>(
                                                              context)
                                                          .playlist
                                                          .imagePath ==
                                                      null
                                                  ? Icon(Icons.close,
                                                      color: Colors.red[400])
                                                  : Icon(
                                                      Icons.check,
                                                      color: Theme.of(context)
                                                          .accentColor,
                                                    )
                                            ]),
                                        Center(
                                          child: Container(
                                            width: 350,
                                            child: TextFormField(
                                              controller: nameController,
                                              autovalidate: true,
                                              validator: (value) {
                                                if (nameController.text.isEmpty)
                                                  return "Playlist title must not be empty";
                                                return null;
                                              },
                                              cursorColor:
                                                  Theme.of(context).accentColor,
                                              cursorWidth: 1.4,
                                              cursorRadius: Radius.circular(10),
                                              decoration: InputDecoration(
                                                  errorStyle:
                                                      GoogleFonts.montserrat(
                                                          color:
                                                              Colors.red[400]),
                                                  icon: Icon(
                                                    Icons.music_note,
                                                    color: Theme.of(context)
                                                        .accentColor,
                                                  ),
                                                  contentPadding:
                                                      EdgeInsets.only(
                                                          bottom: 0),
                                                  hintText: 'Playlist title',
                                                  helperStyle:
                                                      GoogleFonts.montserrat(
                                                          fontSize: 15)),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Container(
                                          height: 500,
                                          width: 500,
                                          child: StatefulBuilder(builder:
                                              (BuildContext context,
                                                  StateSetter setState) {
                                            List<Widget> gridList = [];
                                            isSelected.forEach((key, value) {
                                              gridList.add(RaisedButton(
                                                  color: isSelected[key]
                                                      ? Colors.teal[600]
                                                      : Colors.transparent,
                                                  shape: RoundedRectangleBorder(
                                                      side: BorderSide(
                                                          color:
                                                              Colors.teal[600]),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                  child: Text(key),
                                                  onPressed: () {
                                                    setState(() {
                                                      isSelected[key] =
                                                          !isSelected[key];
                                                    });
                                                  }));
                                            });

                                            return GridView.count(
                                                mainAxisSpacing: 5,
                                                crossAxisSpacing: 5,
                                                childAspectRatio: 2,
                                                shrinkWrap: true,
                                                crossAxisCount: 3,
                                                children: gridList);
                                          }),
                                        ),
                                        RaisedButton(
                                            onPressed: () {
                                              int genre = 0;
                                              List<String> genres = [];
                                              isSelected.forEach((key, value) {
                                                if (value) {
                                                  genres.add(key);
                                                  genre++;
                                                }
                                              });
                                              if (nameController.text.isEmpty ||
                                                  genre == 0) {
                                                showDialog(
                                                    context: context,
                                                    child: AlertDialog(
                                                      backgroundColor:
                                                          Colors.red,
                                                      content: Text('Error'),
                                                    ));
                                              } else {
                                                final song =
                                                    localStorage.getSong(id);
                                                BlocProvider.of<
                                                    AddPlaylistBloc>(context)
                                                  ..add(AddPlaylistToLibrary(
                                                      name: nameController.text,
                                                      song: song,
                                                      genres: genres));
                                              }
                                            },
                                            shape: RoundedRectangleBorder(
                                                side: BorderSide(
                                                    color: Colors.teal[600]),
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            color: Colors.transparent,
                                            child: Text(
                                              'Add the playlist to your library',
                                              style: GoogleFonts.montserrat(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w300,
                                                  letterSpacing: 0.6),
                                            )),
                                      ],
                                    ),
                                  );
                                }
                              }),
                            ),
                          );
                        });
                  }),
            ),
            ListView.builder(
                shrinkWrap: true,
                itemCount: localStorage.getAllPlaylists().length,
                itemBuilder: (BuildContext context, int index) {
                  final List<PlaylistModel> playlists =
                      localStorage.getAllPlaylists();
                  String genres = "";
                  playlists[index].genres.forEach((element) {
                    if (genres == "")
                      genres += element;
                    else
                      genres += (', ' + element);
                  });
                  print(playlists[index].songs[0].title);
                  return ListTile(
                    leading: Container(
                      height: 100,
                      width: 70,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image:
                                  FileImage(File(playlists[index].imagePath)),
                              fit: BoxFit.fitWidth)),
                    ),
                    title: Text(playlists[index].name),
                    subtitle: Text(genres),
                  );
                })
          ],
        ));
  }

  void dispose() {
    nameController.dispose();
    super.dispose();
  }
}
