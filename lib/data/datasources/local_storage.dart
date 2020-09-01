import 'package:SpotifyClone/data/models/playlist_model.dart';
import 'package:SpotifyClone/data/models/song_details_model.dart';
import 'package:hive/hive.dart';

class LocalStorage {
  Box songsBox, playlistsBox, lastPlayedBox, durationBox;
  LocalStorage() {
    songsBox = Hive.box('songs');
    playlistsBox = Hive.box('playlists');
    lastPlayedBox = Hive.box('last_played');
    durationBox = Hive.box('current_duration');
  }

  Future<void> addSong(SongDetailsModel song) async {
    songsBox.put(song.songID, song);
  }

  Future<void> addPlaylist(PlaylistModel playlist) async {
    playlistsBox.put(playlist.albumID, playlist);
  }

  SongDetailsModel getSong(int songID) {
    return songsBox.getAt(songID);
  }

  Future<void> likeSong(int songID) async {
    SongDetailsModel song = songsBox.getAt(songID);

    if (song.isLiked == null)
      song.isLiked = true;
    else
      song.isLiked = !song.isLiked;

    return await songsBox.putAt(songID, song);
  }

  void deleteSongs() {
    songsBox.deleteFromDisk();
  }

  int getSongsLength() {
    if (songsBox.isEmpty) return 0;
    return songsBox.length;
  }

  SongDetailsModel getLastPlayedSong() {
    return lastPlayedBox.get('first');
  }

  Future<void> storeLastPlayedSong(SongDetailsModel song) async {
    return (await lastPlayedBox.put('first', song));
  }

  Future<void> createPlaylist(PlaylistModel playlist) async {
    playlistsBox.put(playlist.albumID, playlist);
  }

  PlaylistModel getPlaylist(int albumID) {
    return playlistsBox.getAt(albumID) as PlaylistModel;
  }

  List<PlaylistModel> getAllPlaylists() {
    List<PlaylistModel> playlists = [];
    for (int i = 0; i < getPlaylistLength(); i++) {
      playlists.add(getPlaylist(i));
    }
    return playlists;
  }

  List<SongDetailsModel> getAllSongs() {
    List<SongDetailsModel> songs = [];
    for (int i = 0; i < getSongsLength(); i++) {
      songs.add(getSong(i));
    }
    return songs;
  }

  Future<void> addSongToPlayList(SongDetailsModel song, int playlistID) async {
    var playlistFrombox = playlistsBox.get(playlistID) as PlaylistModel;
    playlistFrombox.songs.add(song);
    return playlistsBox.putAt(playlistID, playlistFrombox);
  }

  int getPlaylistLength() {
    return playlistsBox.length;
  }

  List<SongDetailsModel> searchSongs(String searchQuery) {
    if (searchQuery == null || searchQuery.isEmpty) return [];
    List<SongDetailsModel> allSongs = getAllSongs();
    List<SongDetailsModel> filteredSongs = [];
    allSongs.forEach((song) {
      if (song.album.toLowerCase().contains(searchQuery.toLowerCase()) ||
          song.artists.toLowerCase().contains(searchQuery.toLowerCase()) ||
          song.title.toLowerCase().contains(searchQuery.toLowerCase()) ||
          searchQuery.toLowerCase().contains(song.album.toLowerCase()) ||
          searchQuery.toLowerCase().contains(song.artists.toLowerCase()) ||
          searchQuery.toLowerCase().contains(song.title.toLowerCase())) {
        filteredSongs.add(song);
      }
    });
    return filteredSongs;
  }

  List<PlaylistModel> searchPlaylists(String searchQuery) {
    List<PlaylistModel> allPlaylists = getAllPlaylists();
    List<PlaylistModel> filteredPlaylists = [];
    allPlaylists.forEach((album) {
      if (album.name.toLowerCase().contains(searchQuery.toLowerCase()) ||
          searchQuery.toLowerCase().contains(album.name.toLowerCase()))
        filteredPlaylists.add(album);
    });
    return filteredPlaylists;
  }
}
