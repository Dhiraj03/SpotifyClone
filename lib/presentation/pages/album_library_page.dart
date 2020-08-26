import 'dart:io';

import 'package:SpotifyClone/data/datasources/local_storage.dart';
import 'package:flutter/material.dart';

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
                            //TODO - Show respective library page
                          },
                          leading: Container(
                            height: 100,
                            width: 70,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: FileImage(File(tempAlbum.imagePath)),
                                    fit: BoxFit.fitWidth)),
                          ),
                          trailing: IconButton(
                            icon: Icon(Icons.more_vert), 
                            onPressed: (){}),
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
