import 'dart:io';

import 'package:SpotifyClone/data/datasources/local_storage.dart';
import 'package:SpotifyClone/presentation/bloc/add_playlist_bloc/add_playlist_bloc.dart';
import 'package:SpotifyClone/presentation/bloc/dashboard_bloc/dashboard_bloc.dart';
import 'package:SpotifyClone/routes/router.gr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:google_fonts/google_fonts.dart';

class CreatePlaylist extends StatefulWidget {
  @override
  _CreatePlaylistState createState() => _CreatePlaylistState();
}

class _CreatePlaylistState extends State<CreatePlaylist> {
  final AddPlaylistBloc addPlaylistBloc = AddPlaylistBloc();
  final LocalStorage localStorage = LocalStorage();
  final TextEditingController nameController = TextEditingController();
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<AddPlaylistBloc>(
        create: (_) => addPlaylistBloc,
        child: BlocConsumer<AddPlaylistBloc, AddPlaylistState>(
            bloc: addPlaylistBloc,
            listener: (BuildContext context, AddPlaylistState state) {
              if (state is PopModalSheet) {
                Router.navigator.pop();
              }
            },
            builder: (BuildContext context, AddPlaylistState state) {
              print(state);
              if (state is AddPlaylistInitial)
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
                  child: ListView(
                    physics: ScrollPhysics(),
                    shrinkWrap: true,
                    padding: EdgeInsets.only(left: 25, top: 70, right: 25),
                    children: <Widget>[
                      Text(
                        'Add A Playlist',
                        style: GoogleFonts.montserrat(
                            fontSize: 25,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.6),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            FlatButton.icon(
                              onPressed: () async {
                                addPlaylistBloc..add(PickAlbumArt());
                              },
                              icon: Icon(
                                FontAwesome.picture_o,
                                color: Theme.of(context).textSelectionColor,
                              ),
                              label: Text(
                                'Choose the album art',
                                style: GoogleFonts.montserrat(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 0.6),
                              ),
                            ),
                            (addPlaylistBloc.playlist == null ||
                                    addPlaylistBloc.playlist.imagePath == null)
                                ? Icon(Icons.close, color: Colors.red[400])
                                : Icon(
                                    Icons.check,
                                    color: Theme.of(context).accentColor,
                                  )
                          ]),
                      Container(
                        height: 200,
                        width: 200,
                        decoration: BoxDecoration(
                            image: (addPlaylistBloc.playlist == null ||
                                    addPlaylistBloc.playlist.imagePath == null)
                                ? DecorationImage(
                                    image: AssetImage('assets/music_note.jpg'))
                                : DecorationImage(
                                    image: FileImage(File(
                                        addPlaylistBloc.playlist.imagePath)))),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Center(
                        child: Container(
                          width: 350,
                          child: TextFormField(
                            controller: nameController,
                            autovalidate: true,
                            validator: (value) {
                              if (nameController.text.isEmpty)
                                return "Album title must not be empty";
                              return null;
                            },
                            cursorColor: Theme.of(context).accentColor,
                            cursorWidth: 1.4,
                            cursorRadius: Radius.circular(10),
                            decoration: InputDecoration(
                                errorStyle: GoogleFonts.montserrat(
                                    color: Colors.red[400]),
                                icon: Icon(
                                  Icons.music_note,
                                  color: Theme.of(context).accentColor,
                                ),
                                contentPadding: EdgeInsets.only(bottom: 0),
                                hintText: 'Album title',
                                helperStyle:
                                    GoogleFonts.montserrat(fontSize: 15)),
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.topCenter,
                        height: 450,
                        width: 500,
                        child: StatefulBuilder(builder:
                            (BuildContext context, StateSetter setState) {
                          List<Widget> gridList = [];
                          isSelected.forEach((key, value) {
                            gridList.add(RaisedButton(
                                color: isSelected[key]
                                    ? Color(0xFFBB86FC)
                                    : Colors.transparent,
                                shape: RoundedRectangleBorder(
                                    side: BorderSide(color: Color(0xFFBB86FC)),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Text(key),
                                onPressed: () {
                                  setState(() {
                                    isSelected[key] = !isSelected[key];
                                  });
                                }));
                          });

                          return GridView.count(
                              physics: NeverScrollableScrollPhysics(),
                              mainAxisSpacing: 5,
                              crossAxisSpacing: 5,
                              childAspectRatio: 2,
                              shrinkWrap: true,
                              crossAxisCount: 3,
                              children: gridList);
                        }),
                      ),
                      SizedBox(
                        height: 20,
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
                            if (nameController.text.isEmpty || genre == 0) {
                              showDialog(
                                  context: context,
                                  child: AlertDialog(
                                    backgroundColor: Colors.red,
                                    content: Text('Error'),
                                  ));
                            } else {
                              BlocProvider.of<AddPlaylistBloc>(context)
                                ..add(CreatePlaylistEvent(
                                    name: nameController.text, genres: genres));
                            }
                          },
                          shape: RoundedRectangleBorder(
                              side: BorderSide(color: Color(0xFFBB86FC)),
                              borderRadius: BorderRadius.circular(10)),
                          color: Colors.transparent,
                          child: Text(
                            'Create Playlist',
                            style: GoogleFonts.montserrat(
                                fontSize: 18,
                                fontWeight: FontWeight.w300,
                                letterSpacing: 0.6),
                          )),
                    ],
                  ),
                );
              else {
                Router.navigator.pop();
                return CircularProgressIndicator();
              }
            }),
      ),
    );
  }
}
