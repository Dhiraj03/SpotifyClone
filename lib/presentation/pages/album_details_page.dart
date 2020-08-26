import 'package:flutter/material.dart';

class AlbumDetailsPage extends StatefulWidget {
  final int id;
  AlbumDetailsPage({@required this.id});
  @override
  _AlbumDetailsPageState createState() => _AlbumDetailsPageState();
}

class _AlbumDetailsPageState extends State<AlbumDetailsPage> {
  int get id => widget.id;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
