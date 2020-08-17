import 'package:SpotifyClone/presentation/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:google_fonts/google_fonts.dart';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage>
    with SingleTickerProviderStateMixin {
  PageController pageController;
  TabController tabController;
  @override
  void initState() {
    pageController = PageController();
    tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: (){},
      child: Icon(Icons.add),backgroundColor: Color(0xFFBB86FC),),
      bottomNavigationBar: Container(
        height: 55,
        child: TabBar(
          indicatorPadding: EdgeInsets.zero,
          labelPadding: EdgeInsets.zero,
          controller: tabController, tabs: [
          Tab(
            
            iconMargin: EdgeInsets.all(1),
            icon: Icon(
              Icons.home,
              size: 26,
            ),
            child: Text(
              'Home',
            style: GoogleFonts.montserrat(fontSize: 12),
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
            style: GoogleFonts.montserrat(fontSize: 12),
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
              style: GoogleFonts.montserrat(fontSize: 12),
            ),
          ),
        ]),
      ),
      
      body: PageView(
        controller: pageController,
        children: <Widget>[HomePage()],
      ),
    );
  }
}
