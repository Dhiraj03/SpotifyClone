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
  final MusicPicker musicPicker = MusicPicker();
  final AddSongBloc addSongBloc = AddSongBloc();
  final TextEditingController nameController = TextEditingController();
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
                    child: ListView(
                      padding: EdgeInsets.only(left: 25, top: 70, right: 25),
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
                                  color: Theme.of(context).textSelectionColor,
                                ),
                                label: Text(
                                  'Choose the file',
                                  style: GoogleFonts.montserrat(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: 0.6),
                                ),
                              ),
                              addSongBloc.song == null
                                  ? Icon(Icons.close, color: Colors.red[400])
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
                            child: TextField(
                              cursorColor: Theme.of(context).accentColor,
                              cursorWidth: 1.4,
                              cursorRadius: Radius.circular(10),
                              decoration: InputDecoration(
                                  icon: Icon(
                                    Icons.music_note,
                                    color: Theme.of(context).accentColor,
                                  ),
                                  contentPadding: EdgeInsets.only(bottom: 0),
                                  hintText: 'Enter the name of the track',
                                  helperStyle:
                                      GoogleFonts.montserrat(fontSize: 15)),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
            }));
  }
}
