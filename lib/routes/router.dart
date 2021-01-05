import 'package:SpotifyClone/presentation/pages/add_song_to_playlist_page.dart';
import 'package:SpotifyClone/presentation/pages/album_details_page.dart';
import 'package:SpotifyClone/presentation/pages/expanded_song_page.dart';
import 'package:SpotifyClone/presentation/widgets/create_playlist.dart';
import 'package:auto_route/auto_route_annotations.dart';

@autoRouter
class $Router {
  ExpandedSongPage songPage;
  AddSongToPlaylist addSongToPlaylist;
  AlbumDetailsPage albumDetailsPage;
  CreatePlaylist createPlaylistPage;
}
