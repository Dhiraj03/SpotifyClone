import 'package:SpotifyClone/data/models/album_art_model.dart';
import 'package:SpotifyClone/data/models/album_model.dart';
import 'package:SpotifyClone/data/models/song_details_model.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

void main() async {
  final appDocumentDir = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);
  Hive.registerAdapter(AlbumArtModelAdapter());
  Hive.registerAdapter(SongDetailsModelAdapter());
  Hive.registerAdapter(AlbumModelAdapter());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void pickMusic() async {
    final file = await FilePicker.getFile();
    print('File path' + file.path);
    final assetsAudioPlayer = AssetsAudioPlayer();
    await assetsAudioPlayer.open(Audio.file(file.path), showNotification: true);
    await assetsAudioPlayer.play();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Choose on the FAB to choose your song from local memory',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: pickMusic,
        tooltip: 'Increment',
        child: Icon(Icons.file_upload),
      ),
    );
  }
}
