import 'dart:io';

import 'package:SpotifyClone/core/audio_player.dart';
import 'package:SpotifyClone/core/hive_model_converter.dart';
import 'package:SpotifyClone/data/datasources/local_storage.dart';
import 'package:SpotifyClone/presentation/bloc/dashboard_bloc/dashboard_bloc.dart';
import 'package:SpotifyClone/presentation/pages/add_song_page.dart';
import 'package:SpotifyClone/presentation/pages/home_page.dart';
import 'package:SpotifyClone/presentation/pages/library_dashboard_page.dart';
import 'package:SpotifyClone/presentation/pages/library_page.dart';
import 'package:SpotifyClone/presentation/pages/search_dashboard_page.dart';
import 'package:SpotifyClone/routes/router.gr.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage>
    with SingleTickerProviderStateMixin {
  PageController pageController;
  TabController tabController;
  DashboardBloc dashboardBloc;
  final Key key = Key("main_dashboard");
  @override
  void initState() {
    dashboardBloc = DashboardBloc();
    pageController = PageController();
    tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DashboardBloc>(
      create: (BuildContext context) => dashboardBloc,
      child: BlocConsumer<DashboardBloc, DashboardState>(
          listener: (BuildContext context, DashboardState state) {},
          builder: (BuildContext context, DashboardState state) {
            if (state is DashboardInitial) {
              return Scaffold(
                  floatingActionButton: FloatingActionButton(
                    onPressed: () {
                      BlocProvider.of<DashboardBloc>(context)
                        ..add(AddSongToLibrary());
                    },
                    child: Icon(Icons.add),
                    backgroundColor: Color(0xFFBB86FC),
                  ),
                  bottomNavigationBar: Container(
                    padding: EdgeInsets.zero,
                    height: 120,
                    child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                              flex: 12,
                              child: GestureDetector(
                                behavior: HitTestBehavior.opaque,
                                onTap: () {
                                  Router.navigator.pushNamed(Router.songPage);
                                },
                                child: Container(
                                    padding: EdgeInsets.zero,
                                    alignment: Alignment.center,
                                    child: StreamBuilder(
                                        stream:
                                            Provider.of<AudioPlayer>(context)
                                                .getCurrentStream(),
                                        builder: (BuildContext context,
                                            AsyncSnapshot snapshot) {
                                          if (snapshot.hasData &&
                                              snapshot.data[0] != null &&
                                              snapshot.data[0].audio != null &&
                                              snapshot.data[0].audio.audio !=
                                                  null) {
                                            bool liked;
                                            if (LocalStorage()
                                                        .getSong(int.parse(
                                                            snapshot
                                                                .data[0]
                                                                .audio
                                                                .audio
                                                                .metas
                                                                .id))
                                                        .isLiked ==
                                                    null ||
                                                LocalStorage()
                                                        .getSong(int.parse(
                                                            snapshot
                                                                .data[0]
                                                                .audio
                                                                .audio
                                                                .metas
                                                                .id))
                                                        .isLiked ==
                                                    false) {
                                              liked = false;
                                            } else {
                                              liked = true;
                                            }
                                            return Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: <Widget>[
                                                  Container(
                                                    height: 50,
                                                    width: 50,
                                                    decoration: BoxDecoration(
                                                        image: DecorationImage(
                                                            image: FileImage(
                                                                File(snapshot
                                                                    .data[0]
                                                                    .audio
                                                                    .audio
                                                                    .metas
                                                                    .image
                                                                    .path)),
                                                            fit: BoxFit.fill)),
                                                  ),
                                                  Container(
                                                    width: 150,
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: <Widget>[
                                                        Text(snapshot
                                                            .data[0]
                                                            .audio
                                                            .audio
                                                            .metas
                                                            .title),
                                                        SizedBox(
                                                          height: 6,
                                                        ),
                                                        Text(
                                                          snapshot
                                                              .data[0]
                                                              .audio
                                                              .audio
                                                              .metas
                                                              .artist,
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.grey),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 40,
                                                  ),
                                                  if (snapshot.data[2])
                                                    IconButton(
                                                        icon: Icon(
                                                            MaterialCommunityIcons
                                                                .pause),
                                                        onPressed: () {
                                                          Provider.of<AudioPlayer>(
                                                                  context,
                                                                  listen: false)
                                                              .playOrPause();
                                                        })
                                                  else
                                                    IconButton(
                                                        icon: Icon(
                                                            MaterialCommunityIcons
                                                                .play),
                                                        onPressed: () {
                                                          Provider.of<AudioPlayer>(
                                                                  context,
                                                                  listen: false)
                                                              .playOrPause();
                                                        }),
                                                  if (liked == false)
                                                    IconButton(
                                                        icon: Icon(
                                                            MaterialCommunityIcons
                                                                .heart_outline),
                                                        onPressed: () {
                                                          Provider.of<AudioPlayer>(
                                                                  context,
                                                                  listen: false)
                                                              .likeSong(
                                                                  int.parse(
                                                                      snapshot
                                                                          .data[
                                                                              0]
                                                                          .audio
                                                                          .audio
                                                                          .metas
                                                                          .id));
                                                          setState(() {});
                                                        })
                                                  else
                                                    IconButton(
                                                        icon: Icon(
                                                            MaterialCommunityIcons
                                                                .heart),
                                                        onPressed: () {
                                                          Provider.of<AudioPlayer>(
                                                                  context,
                                                                  listen: false)
                                                              .likeSong(
                                                                  int.parse(
                                                                      snapshot
                                                                          .data[
                                                                              0]
                                                                          .audio
                                                                          .audio
                                                                          .metas
                                                                          .id));
                                                          setState(() {});
                                                        })
                                                ]);
                                          } else {
                                            var audio = audioFromSongDetails(
                                                Provider.of<AudioPlayer>(
                                                        context)
                                                    .getLastPlayed());
                                            if (audio == null) {
                                              return Container();
                                            }
                                            List<dynamic> snapshot = [
                                              audio,
                                              Duration.zero,
                                              false
                                            ];
                                            if (snapshot != null &&
                                                snapshot[0] != null) {
                                              bool liked;
                                              if (LocalStorage()
                                                          .getSong(int.parse(
                                                              snapshot[0]
                                                                  .metas
                                                                  .id))
                                                          .isLiked ==
                                                      null ||
                                                  LocalStorage()
                                                          .getSong(int.parse(
                                                              snapshot[0]
                                                                  .metas
                                                                  .id))
                                                          .isLiked ==
                                                      false) {
                                                liked = false;
                                              } else {
                                                liked = true;
                                              }
                                              return Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: <Widget>[
                                                    Container(
                                                      height: 50,
                                                      width: 50,
                                                      decoration: BoxDecoration(
                                                          image: DecorationImage(
                                                              image: FileImage(
                                                                  File(snapshot[
                                                                          0]
                                                                      .metas
                                                                      .image
                                                                      .path)),
                                                              fit:
                                                                  BoxFit.fill)),
                                                    ),
                                                    Container(
                                                      width: 150,
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: <Widget>[
                                                          Text(snapshot[0]
                                                              .metas
                                                              .title),
                                                          SizedBox(
                                                            height: 6,
                                                          ),
                                                          Text(
                                                            snapshot[0]
                                                                .metas
                                                                .artist,
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .grey),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 40,
                                                    ),
                                                    if (snapshot[2])
                                                      IconButton(
                                                          icon: Icon(
                                                              MaterialCommunityIcons
                                                                  .pause),
                                                          onPressed: () {
                                                            Provider.of<AudioPlayer>(
                                                                    context,
                                                                    listen:
                                                                        false)
                                                                .playOrPause();
                                                          })
                                                    else
                                                      IconButton(
                                                          icon: Icon(
                                                              MaterialCommunityIcons
                                                                  .play),
                                                          onPressed: () {
                                                            Provider.of<AudioPlayer>(
                                                                    context,
                                                                    listen:
                                                                        false)
                                                                .playOrPause();
                                                          }),
                                                    if (liked == false)
                                                      IconButton(
                                                          icon: Icon(
                                                              MaterialCommunityIcons
                                                                  .heart_outline),
                                                          onPressed: () {
                                                            Provider.of<AudioPlayer>(
                                                                    context,
                                                                    listen:
                                                                        false)
                                                                .likeSong(int.parse(
                                                                    snapshot[0]
                                                                        .metas
                                                                        .id));
                                                            setState(() {});
                                                          })
                                                    else
                                                      IconButton(
                                                          icon: Icon(
                                                              MaterialCommunityIcons
                                                                  .heart),
                                                          onPressed: () {
                                                            Provider.of<AudioPlayer>(
                                                                    context,
                                                                    listen:
                                                                        false)
                                                                .likeSong(int.parse(
                                                                    snapshot[0]
                                                                        .metas
                                                                        .id));
                                                            setState(() {});
                                                          })
                                                  ]);
                                            }
                                          }
                                        })),
                              )),
                          Expanded(
                            flex: 10,
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border(
                                      top: BorderSide(
                                          color: Colors.black, width: 1.5))),
                              child: TabBar(
                                  indicatorColor: Color(0xFFBB86FC),
                                  indicatorWeight: 3,
                                  onTap: (index) {
                                    if (tabController.previousIndex !=
                                        tabController.index) {
                                      pageController
                                          .jumpToPage(tabController.index);
                                    }
                                  },
                                  indicatorSize: TabBarIndicatorSize.label,
                                  indicatorPadding: EdgeInsets.zero,
                                  labelPadding: EdgeInsets.zero,
                                  controller: tabController,
                                  tabs: [
                                    Tab(
                                      text: 'Home',
                                      iconMargin: EdgeInsets.all(1),
                                      icon: Icon(
                                        Icons.home,
                                        size: 26,
                                      ),
                                    ),
                                    Tab(
                                      iconMargin: EdgeInsets.all(1),
                                      icon: Icon(
                                        Icons.search,
                                        size: 26,
                                      ),
                                      child: Text(
                                        'Search',
                                        style: GoogleFonts.montserrat(
                                            fontSize: 12),
                                      ),
                                    ),
                                    Tab(
                                      iconMargin: EdgeInsets.all(1),
                                      icon: Icon(
                                        MaterialIcons.library_music,
                                        size: 26,
                                      ),
                                      child: Text(
                                        'My Music',
                                        style: GoogleFonts.montserrat(
                                            fontSize: 12),
                                      ),
                                    ),
                                  ]),
                            ),
                          ),
                        ]),
                  ),
                  body: PageView(
                    key: key,
                    pageSnapping: true,
                    physics: PageScrollPhysics(),
                    controller: pageController,
                    children: <Widget>[
                      HomePage(),
                      SearchDashboardPage(),
                      Container(child: LibraryDashboardPage())
                    ],
                  ));
            } else if (state is AddSongPageState) {
              return AddSongPage();
            }
            return Container();
          }),
    );
  }
}
