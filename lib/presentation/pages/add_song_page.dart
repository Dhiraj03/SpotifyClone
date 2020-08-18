import 'dart:io';
import 'package:SpotifyClone/core/file_picker.dart';
import 'package:SpotifyClone/presentation/bloc/add_song_bloc/add_song_bloc.dart';
import 'package:SpotifyClone/presentation/bloc/dashboard_bloc/dashboard_bloc.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:google_fonts/google_fonts.dart';

class AddSongPage extends StatefulWidget {
  @override
  _AddSongPageState createState() => _AddSongPageState();
}

class _AddSongPageState extends State<AddSongPage> {
  final Picker musicPicker = Picker();
  final AddSongBloc addSongBloc = AddSongBloc();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController artistController = TextEditingController();
  final TextEditingController albumNameController = TextEditingController();
  PageController pageController;
  @override
  void initState() {
    pageController = PageController();
    super.initState();
  }

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
    return BlocProvider<AddSongBloc>(
        create: (BuildContext context) => addSongBloc,
        child: BlocBuilder<AddSongBloc, AddSongState>(
            bloc: addSongBloc,
            builder: (BuildContext context, AddSongState state) {
              if (state is AddSongInitial)
                return Scaffold(
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
                      child: PageView(controller: pageController, children: <
                          Widget>[
                        ListView(
                          shrinkWrap: true,
                          padding:
                              EdgeInsets.only(left: 25, top: 70, right: 25),
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  'Add A Song',
                                  style: GoogleFonts.montserrat(
                                      fontSize: 25,
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: 0.6),
                                ),
                                IconButton(
                                    icon: Icon(
                                      Icons.close,
                                      size: 30,
                                    ),
                                    onPressed: () {
                                      BlocProvider.of<DashboardBloc>(context)
                                        ..add(MainDashboard());
                                    }),
                              ],
                            ),
                            SizedBox(
                              height: 70,
                            ),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  FlatButton.icon(
                                    onPressed: () async {
                                      addSongBloc..add(PickMusicEvent());
                                    },
                                    icon: Icon(
                                      FontAwesome.music,
                                      color:
                                          Theme.of(context).textSelectionColor,
                                    ),
                                    label: Text(
                                      'Choose the file',
                                      style: GoogleFonts.montserrat(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                          letterSpacing: 0.6),
                                    ),
                                  ),
                                 addSongBloc.songDetails.path == null
                                      ? Icon(Icons.close,
                                          color: Colors.red[400])
                                      : Icon(
                                          Icons.check,
                                          color: Theme.of(context).accentColor,
                                        )
                                ]),
                            SizedBox(
                              height: 10,
                            ),
                            Center(
                              child: Container(
                                width: 350,
                                child: TextFormField(
                                  controller: nameController,
                                  autovalidate: true,
                                  validator: (value) {
                                    if (nameController.text.isEmpty)
                                      return "Track title must not be empty";
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
                                      contentPadding:
                                          EdgeInsets.only(bottom: 0),
                                      hintText: 'Track title',
                                      helperStyle:
                                          GoogleFonts.montserrat(fontSize: 15)),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Center(
                              child: Container(
                                width: 350,
                                child: TextFormField(
                                  controller: artistController,
                                  autovalidate: true,
                                  validator: (value) {
                                    if (artistController.text.isEmpty)
                                      return "Artists must not be empty";
                                    return null;
                                  },
                                  cursorColor: Theme.of(context).accentColor,
                                  cursorWidth: 1.4,
                                  cursorRadius: Radius.circular(10),
                                  decoration: InputDecoration(
                                      errorStyle: GoogleFonts.montserrat(
                                          color: Colors.red[400]),
                                      icon: Icon(
                                        MaterialCommunityIcons.artist,
                                        color: Theme.of(context).accentColor,
                                      ),
                                      contentPadding:
                                          EdgeInsets.only(bottom: 0),
                                      hintText: 'Artists',
                                      helperStyle:
                                          GoogleFonts.montserrat(fontSize: 15)),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Center(
                              child: Container(
                                width: 350,
                                child: TextFormField(
                                  controller: albumNameController,
                                  autovalidate: true,
                                  validator: (value) {
                                    if (albumNameController.text.isEmpty)
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
                                        Icons.album,
                                        color: Theme.of(context).accentColor,
                                      ),
                                      contentPadding:
                                          EdgeInsets.only(bottom: 0),
                                      hintText: 'Album title',
                                      helperStyle:
                                          GoogleFonts.montserrat(fontSize: 15)),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                IconButton(
                                    icon: Icon(
                                      MaterialCommunityIcons.arrow_left,
                                      color: Colors.grey,
                                    ),
                                    onPressed: () {}),
                                IconButton(
                                    icon: Icon(
                                      MaterialCommunityIcons.arrow_right,
                                      color: Theme.of(context).accentColor,
                                    ),
                                    onPressed: () {
                                      pageController.jumpToPage(1);
                                    }),
                              ],
                            )
                          ],
                        ),
                        ListView(
                          padding:
                              EdgeInsets.only(left: 25, top: 70, right: 25),
                          shrinkWrap: true,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  'Choose Genres',
                                  style: GoogleFonts.montserrat(
                                      fontSize: 25,
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: 0.6),
                                ),
                                IconButton(
                                    icon: Icon(
                                      Icons.close,
                                      size: 30,
                                    ),
                                    onPressed: () {
                                      BlocProvider.of<DashboardBloc>(context)
                                        ..add(MainDashboard());
                                    }),
                              ],
                            ),
                            Container(
                              height: 500,
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
                                          side: BorderSide(
                                              color: Color(0xFFBB86FC)),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Text(key),
                                      onPressed: () {
                                        setState(() {
                                          isSelected[key] = !isSelected[key];
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                IconButton(
                                    icon: Icon(
                                      MaterialCommunityIcons.arrow_left,
                                      color: Theme.of(context).accentColor,
                                    ),
                                    onPressed: () {
                                      pageController.jumpToPage(0);
                                    }),
                                IconButton(
                                    icon: Icon(
                                      MaterialCommunityIcons.arrow_right,
                                      color: Theme.of(context).accentColor,
                                    ),
                                    onPressed: () {
                                      pageController.jumpToPage(2);
                                    }),
                              ],
                            )
                          ],
                        ),
                        ListView(
                          padding:
                              EdgeInsets.only(left: 25, top: 70, right: 25),
                          shrinkWrap: true,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  'Choose Art',
                                  style: GoogleFonts.montserrat(
                                      fontSize: 25,
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: 0.6),
                                ),
                                IconButton(
                                    icon: Icon(
                                      Icons.close,
                                      size: 30,
                                    ),
                                    onPressed: () {
                                      BlocProvider.of<DashboardBloc>(context)
                                        ..add(MainDashboard());
                                    }),
                              ],
                            ),
                            SizedBox(
                              height: 70,
                            ),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  FlatButton.icon(
                                    onPressed: () async {
                                      addSongBloc..add(PickMusicArt());
                                    },
                                    icon: Icon(
                                      FontAwesome.picture_o,
                                      color:
                                          Theme.of(context).textSelectionColor,
                                    ),
                                    label: Text(
                                      'Choose the album art',
                                      style: GoogleFonts.montserrat(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                          letterSpacing: 0.6),
                                    ),
                                  ),
                                  (addSongBloc.songDetails == null ||
                                      addSongBloc.songDetails.imagePath == null)
                                      ? Icon(Icons.close,
                                          color: Colors.red[400])
                                      : Icon(
                                          Icons.check,
                                          color: Theme.of(context).accentColor,
                                        )
                                ]),
                            Container(
                              height: 200,
                              width: 200,
                              decoration: BoxDecoration(
                                  image: (addSongBloc.songDetails == null ||
                                      addSongBloc.songDetails.imagePath == null)
                                      ? DecorationImage(
                                          image: NetworkImage(
                                              'https://cdn0.iconfinder.com/data/icons/internet-2020/1080/Applemusicandroid-512.png'))
                                      : DecorationImage(
                                          image: FileImage(File(
                                              addSongBloc.songDetails.imagePath)))),
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
                                      albumNameController.text.isEmpty ||
                                      artistController.text.isEmpty ||
                                      genre == 0) {
                                    showDialog(
                                        context: context,
                                        child: AlertDialog(
                                          backgroundColor: Colors.red,
                                          content: Text('Error'),
                                        ));
                                  } else {
                                    BlocProvider.of<AddSongBloc>(context)
                                      ..add(AddMusicToLibrary(
                                          track: nameController.text,
                                          album: albumNameController.text,
                                          artist: artistController.text,
                                          genres: genres));
                                  }
                                },
                                shape: RoundedRectangleBorder(
                                    side: BorderSide(color: Color(0xFFBB86FC)),
                                    borderRadius: BorderRadius.circular(10)),
                                color: Colors.transparent,
                                child: Text(
                                  'Add the song to your library',
                                  style: GoogleFonts.montserrat(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w300,
                                      letterSpacing: 0.6),
                                )),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                IconButton(
                                    icon: Icon(
                                      MaterialCommunityIcons.arrow_left,
                                      color: Theme.of(context).accentColor,
                                    ),
                                    onPressed: () {
                                      pageController.jumpToPage(1);
                                    }),
                                IconButton(
                                    icon: Icon(
                                      MaterialCommunityIcons.arrow_right,
                                      color: Colors.grey,
                                    ),
                                    onPressed: () {}),
                              ],
                            )
                          ],
                        )
                      ])),
                );
              else if (state is GoBackToDashboard) {
                
                BlocProvider.of<DashboardBloc>(context)..add(MainDashboard());
                return CircularProgressIndicator();
              }
            }));
  }
}
