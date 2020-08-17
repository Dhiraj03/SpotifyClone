import 'package:SpotifyClone/presentation/bloc/dashboard_bloc/dashboard_bloc.dart';
import 'package:SpotifyClone/presentation/pages/add_song_page.dart';
import 'package:SpotifyClone/presentation/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
                  height: 55,
                  child: TabBar(
                      indicatorColor: Color(0xFFBB86FC),
                      indicatorWeight: 3,
                      onTap: (index) {},
                      indicatorSize: TabBarIndicatorSize.label,
                      indicatorPadding: EdgeInsets.zero,
                      labelPadding: EdgeInsets.zero,
                      controller: tabController,
                      tabs: [
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
            } else if (state is AddSongPageState) {
              return AddSongPage();
            }
            return Container();
          }),
    );
  }
}
