import 'package:SpotifyClone/data/models/song_details_model.dart';
import 'package:assets_audio_player/assets_audio_player.dart';

Audio audioFromSongDetails(SongDetailsModel hiveSong) {
  Audio tempSong = Audio.file(hiveSong.path,
      metas: Metas(
          title: hiveSong.title,
          artist: hiveSong.artists,
          album: hiveSong.album,
          image: MetasImage.file(hiveSong.imagePath),
          onImageLoadFail: MetasImage.network(
              'https://i2.wp.com/files.123freevectors.com/wp-content/original/155500-abstract-dark-grey-background-design.jpg?w=800&q=95'),
          extra: {'genres': hiveSong.genres}));
  return tempSong;
}
