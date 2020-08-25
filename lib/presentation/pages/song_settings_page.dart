import 'package:flutter/material.dart';

class SongSettingsPage extends StatefulWidget {
  @override
  _SongSettingsPageState createState() => _SongSettingsPageState();
}

class _SongSettingsPageState extends State<SongSettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}