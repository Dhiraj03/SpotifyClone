import 'package:SpotifyClone/core/audio_player.dart';
import 'package:SpotifyClone/data/models/album_art_model.dart';
import 'package:SpotifyClone/data/models/playlist_model.dart';
import 'package:SpotifyClone/data/models/song_details_model.dart';
import 'package:SpotifyClone/presentation/pages/dashboard_page.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDir = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);
  Hive.registerAdapter(AlbumArtModelAdapter());
  Hive.registerAdapter(SongDetailsModelAdapter());
  Hive.registerAdapter(PlaylistModelAdapter());
  await Hive.openBox('songs');
  await Hive.openBox('playlists');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark(),
        title: 'SpotifyClone',
        home: ChangeNotifierProvider<AudioPlayer>(
            create: (_) => AudioPlayer(), child: DashboardPage()));
  }
}
