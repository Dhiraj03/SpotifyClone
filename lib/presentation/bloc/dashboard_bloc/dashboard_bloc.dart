import 'dart:async';

import 'package:SpotifyClone/data/models/song_details_model.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardState get initialState => DashboardInitial();

  @override
  Stream<DashboardState> mapEventToState(
    DashboardEvent event,
  ) async* {
    if (event is AddSongToLibrary) {
      yield AddSongPageState();
    } else if (event is MainDashboard) {
      yield DashboardInitial();
    }
  }
}
