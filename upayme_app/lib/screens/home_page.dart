import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:upayme_app/constants.dart';
import 'package:upayme_app/services/firebase_services.dart';
import 'package:upayme_app/tabs/home_tab.dart';
import 'package:upayme_app/tabs/search_tab.dart';
import 'package:upayme_app/tabs/saved_tab.dart';
import 'package:upayme_app/tabs/search_tab.dart';
import 'package:upayme_app/widgets/bottom_tabs.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  //Will control page view
  PageController _tabsPageController;
  int _selectedTab =0;
  @override
  void initState() {
    _tabsPageController=PageController();
    super.initState();
  }

  @override
  void dispose() {
    _tabsPageController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     body: Column(
       //Will put tabs at bottom of screen
       mainAxisAlignment: MainAxisAlignment.spaceBetween,
       children: [
         //Creates Swipeable pages
       Expanded(
         child: PageView(
           //will detect tab changes
           controller: _tabsPageController,
           //will get page number
           onPageChanged: (num){
             //Will Set page to match the selected tab
            setState(() {
              _selectedTab = num;
            });
           },
           children: [
             HomeTab(),
             SearchTab(),
             SavedTab(),
           ],
         ),
       ),
         BottomTabs(
           selectedTab: _selectedTab,
            //will allow screen to change when icon is clicked
            tabFunction: (num) {
              _tabsPageController.animateToPage(
                  num,
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeOutCubic);
            },
         ),
       ],
     ),
    );
  }
}
