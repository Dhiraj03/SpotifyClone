import 'package:SpotifyClone/data/datasources/local_storage.dart';
import 'package:SpotifyClone/data/models/song_details_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class LibraryPage extends StatefulWidget {
  @override
  _LibraryPageState createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage> {
  final LocalStorage localStorage = LocalStorage();
  @override
  Widget build(BuildContext context) {
    print(localStorage.getSongsLength());
    return ListView.builder(
      itemCount: localStorage.getSongsLength(),
      itemBuilder: (BuildContext context, int index) {
        print(localStorage.getSong(index).title);
        return Container(
          child: Text(localStorage.getSong(index).title),
        );
      },
    );
  }
}
