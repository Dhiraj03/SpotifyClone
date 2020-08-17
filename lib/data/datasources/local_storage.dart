import 'package:SpotifyClone/data/models/playlist_model.dart';
import 'package:SpotifyClone/data/models/song_details_model.dart';
import 'package:hive/hive.dart';

class LocalStorage {
  Box songsBox, playlistsBox;
  LocalStorage() {
    songsBox = Hive.box('songs');
    playlistsBox = Hive.box('playlists');
  }

  Future<void> addSong(SongDetailsModel song) async {
    songsBox.putAt(song.songID, song);
  }

  Future<void> createPlaylist(PlaylistModel playlist) async {
    playlistsBox.put(playlist.albumID, playlist);
  }

  SongDetailsModel getSong(int songID) {
    return songsBox.getAt(songID);
  }

  PlaylistModel getPlaylist(int albumID) {
    return playlistsBox.getAt(albumID);
  }

  Future<void> addSongToPlaylist(SongDetailsModel song, int albumID) async {
    final playlist = playlistsBox.getAt(albumID) as PlaylistModel;
    playlist.songs.add(song);
    await playlistsBox.putAt(albumID, playlist);
  }
}
