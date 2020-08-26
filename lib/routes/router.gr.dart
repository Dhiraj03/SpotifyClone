// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:auto_route/router_utils.dart';
import 'package:SpotifyClone/presentation/pages/expanded_song_page.dart';
import 'package:SpotifyClone/presentation/pages/add_song_to_playlist_page.dart';

class Router {
  static const songPage = '/song-page';
  static const addSongToPlaylist = '/add-song-to-playlist';
  static GlobalKey<NavigatorState> get navigatorKey =>
      getNavigatorKey<Router>();
  static NavigatorState get navigator => navigatorKey.currentState;

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case Router.songPage:
        return MaterialPageRoute(
          builder: (_) => ExpandedSongPage(),
          settings: settings,
        );
      case Router.addSongToPlaylist:
        if (hasInvalidArgs<int>(args, isRequired: true)) {
          return misTypedArgsRoute<int>(args);
        }
        final typedArgs = args as int;
        return MaterialPageRoute(
          builder: (_) => AddSongToPlaylist(songId: typedArgs),
          settings: settings,
        );
      default:
        return unknownRoutePage(settings.name);
    }
  }
}
