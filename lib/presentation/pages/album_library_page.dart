import 'dart:io';

import 'package:SpotifyClone/data/datasources/local_storage.dart';
import 'package:SpotifyClone/routes/router.gr.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AlbumLibraryPage extends StatefulWidget {
  @override
  _AlbumLibraryPageState createState() => _AlbumLibraryPageState();
}

class _AlbumLibraryPageState extends State<AlbumLibraryPage> {
  final LocalStorage localStorage = LocalStorage();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
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
          padding: const EdgeInsets.only(left: 8.0, bottom: 30),
          child: Column(
            children: <Widget>[
              Container(
                height: 100,
                child: InkWell(
                  radius: 110,
                  splashFactory: InkRipple.splashFactory,
                  onTap: () {
                    Router.navigator.pushNamed(Router.createPlaylistPage);
                  },
                  child: Center(
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                        Icon(
                          Icons.add,
                          size: 35,
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Text('ADD PLAYLIST',
                            style: GoogleFonts.montserrat(
                                letterSpacing: 2.2,
                                fontSize: 20,
                                fontWeight: FontWeight.w400)),
                      ])),
                ),
              ),
              Expanded(
                  child: ListView.builder(
                      itemCount: localStorage.getPlaylistLength(),
                      itemBuilder: (BuildContext context, int index) {
                        var tempAlbum = localStorage.getPlaylist(index);
                        String genres = "";
                        tempAlbum.genres.forEach((element) {
                          if (genres == "")
                            genres += element;
                          else
                            genres += (', ' + element);
                        });
                        return ListTile(
                          onTap: () {
                            Router.navigator.pushNamed(Router.albumDetailsPage,
                                arguments: tempAlbum.albumID);
                          },
                          leading: Container(
                            height: 100,
                            width: 70,
                            child: tempAlbum.imagePath != null ? Image.file(File(tempAlbum.imagePath)) : Image.asset("assets/music_note.jpg"),
                          ),
                          trailing: IconButton(
                              icon: Icon(Icons.more_vert), onPressed: () {}),
                          title: Text(tempAlbum.name),
                          isThreeLine: true,
                          subtitle: Text(genres),
                        );
                      }))
            ],
          ),
        ));
  }
}
