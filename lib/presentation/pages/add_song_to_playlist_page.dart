import 'package:flutter/material.dart';

class AddSongToPlaylist extends StatefulWidget {
  final int songId;
  AddSongToPlaylist({@required this.songId});
  @override
  _AddSongToPlaylistState createState() => _AddSongToPlaylistState();
}

class _AddSongToPlaylistState extends State<AddSongToPlaylist> {
  int get id => widget.songId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
