import 'dart:io';

import 'package:SpotifyClone/data/models/playlist_model.dart';
import 'package:SpotifyClone/data/models/song_details_model.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';

Audio audioFromSongDetails(SongDetailsModel hiveSong) {
  
  if (hiveSong == null) return null;
  Audio tempSong = Audio.file(hiveSong.path,
      metas: Metas(
          id: hiveSong.songID.toString(),
          title: hiveSong.title,
          artist: hiveSong.artists,
          album: hiveSong.album,
          image: MetasImage.file(hiveSong.imagePath),
          onImageLoadFail: MetasImage.network(
              'https://i2.wp.com/files.123freevectors.com/wp-content/original/155500-abstract-dark-grey-background-design.jpg?w=800&q=95'),
          extra: {'genres': hiveSong.genres, 'liked': hiveSong.isLiked, 'color' : hiveSong.colors}));
  return tempSong;
}

Playlist playlistFromSongDetails(PlaylistModel playlistModel) {
  List<Audio> listOfAudio = [];
  playlistModel.songs.forEach((element) {
    listOfAudio.add(audioFromSongDetails(element));
  });
  Playlist playlist = Playlist(audios: listOfAudio, startIndex: 0);
  return playlist;
}
