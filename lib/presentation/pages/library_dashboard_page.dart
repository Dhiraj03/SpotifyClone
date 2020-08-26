import 'package:SpotifyClone/presentation/pages/album_library_page.dart';
import 'package:SpotifyClone/presentation/pages/library_page.dart';
import 'package:SpotifyClone/presentation/pages/song_settings_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LibraryDashboardPage extends StatefulWidget {
  @override
  _LibraryDashboardPageState createState() => _LibraryDashboardPageState();
}

class _LibraryDashboardPageState extends State<LibraryDashboardPage>
    with SingleTickerProviderStateMixin {
  TabController tabController;
  PageController pageController;
  final Key key = Key("libraryKey");
  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    pageController = PageController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 700,
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 30,
            ),
            TabBar(
                indicatorColor: Colors.teal[600],
                controller: tabController,
                onTap: (index) {
                  pageController.jumpToPage(index);
                },
                tabs: <Widget>[
                  Tab(
                    child: Text(
                      'Songs',
                      style: GoogleFonts.montserrat(
                          color: Colors.white, fontSize: 15),
                    ),
                  ),
                  Tab(
                    child: Text(
                      'Playlists',
                      style: GoogleFonts.montserrat(
                          color: Colors.white, fontSize: 15),
                    ),
                  )
                ]),
            Container(
              height: 570,
              child: PageView(
                key: key,
                pageSnapping: true,
                onPageChanged: (index) {
                  tabController.index = index;
                },
                controller: pageController,
                children: <Widget>[
                  LibraryPage(),
                  AlbumLibraryPage()
                ],
              ),
            )
          ],
        ),
      
    );
  }
}
