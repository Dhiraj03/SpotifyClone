import 'dart:io';

import 'package:SpotifyClone/core/audio_player.dart';
import 'package:SpotifyClone/core/hive_model_converter.dart';
import 'package:SpotifyClone/data/datasources/local_storage.dart';
import 'package:SpotifyClone/presentation/bloc/dashboard_bloc/dashboard_bloc.dart';
import 'package:SpotifyClone/presentation/pages/add_song_page.dart';
import 'package:SpotifyClone/presentation/pages/home_page.dart';
import 'package:SpotifyClone/presentation/pages/library_page.dart';
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
            print(state.toString());
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
                                      stream: Provider.of<AudioPlayer>(context)
                                          .getCurrentlyPlaying(),
                                      builder: (BuildContext context,
                                          AsyncSnapshot snapshot) {
                                        if (!snapshot.hasData ||
                                            snapshot.connectionState ==
                                                ConnectionState.waiting ||
                                            snapshot.hasError ||
                                            snapshot.connectionState ==
                                                ConnectionState.none ||
                                            snapshot.connectionState ==
                                                ConnectionState.active) {
                                          var tempSong =
                                              Provider.of<AudioPlayer>(context)
                                                  .getLastPlayed();
                                          if (tempSong == null) {
                                            return Container(
                                                height: 0, width: 0);
                                          }
                                          return Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: <Widget>[
                                              Container(
                                                height: 50,
                                                width: 50,
                                                decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                        image: FileImage(File(
                                                            tempSong
                                                                .imagePath)),
                                                        fit: BoxFit.fill)),
                                              ),
                                              Container(
                                                width: 150,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    Text(tempSong.title),
                                                    SizedBox(
                                                      height: 6,
                                                    ),
                                                    Text(
                                                      tempSong.artists,
                                                      style: TextStyle(
                                                          color: Colors.grey),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                width: 40,
                                              ),
                                              StreamBuilder(
                                                  stream:
                                                      Provider.of<AudioPlayer>(
                                                              context)
                                                          .isPlaying(),
                                                  // ignore: missing_return
                                                  builder: (BuildContext
                                                          context,
                                                      AsyncSnapshot snapshot1) {
                                                    if (!snapshot1.hasData ||
                                                        snapshot1
                                                                .connectionState ==
                                                            ConnectionState
                                                                .waiting ||
                                                        snapshot1.hasError)
                                                      return Container(
                                                        height: 0,
                                                        width: 0,
                                                      );
                                                    else if (snapshot1
                                                                .connectionState ==
                                                            ConnectionState
                                                                .active ||
                                                        snapshot1
                                                                .connectionState ==
                                                            ConnectionState
                                                                .done)
                                                      return IconButton(
                                                          icon: snapshot1.data
                                                              ? Icon(
                                                                  Icons.pause)
                                                              : Icon(Icons
                                                                  .play_arrow),
                                                          onPressed: () async {
                                                            if ((snapshot1.data ==
                                                                        false ||
                                                                    !snapshot1
                                                                        .hasData) &&
                                                                !snapshot
                                                                    .hasData) {
                                                              Provider.of<AudioPlayer>(
                                                                      context,
                                                                      listen:
                                                                          false)
                                                                  .playRecentSong();
                                                            } else {
                                                              await Provider.of<
                                                                          AudioPlayer>(
                                                                      context,
                                                                      listen:
                                                                          false)
                                                                  .playOrPause();
                                                            }
                                                          });
                                                  }),
                                              IconButton(

                                                icon: tempSong.isLiked== null ? Icon(
                                                    MaterialCommunityIcons
                                                        .heart_outline) : 
                                                        (tempSong.isLiked
                                                    ? Icon(
                                                        MaterialCommunityIcons
                                                            .heart)
                                                    : Icon(
                                                        MaterialCommunityIcons
                                                            .heart_outline)),
                                                onPressed: () async {
                                                  await Provider.of<
                                                          AudioPlayer>(context, listen: false)
                                                      .likeSong(
                                                          tempSong.songID);
                                                },
                                              )
                                            ],
                                          );
                                        }
                                        return Container(height: 0, width: 0);
                                      }),
                                ),
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
                    pageSnapping: true,
                    physics: PageScrollPhysics(),
                    controller: pageController,
                    children: <Widget>[HomePage(), LibraryPage()],
                  ));
            } else if (state is AddSongPageState) {
              return AddSongPage();
            }
            return Container();
          }),
    );
  }
}
