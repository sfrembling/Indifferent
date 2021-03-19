import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BottomTabs extends StatefulWidget {
  final int selectedTab;
  final Function(int) tabFunction;
  BottomTabs({this.selectedTab, this.tabFunction});

  //selected tab value
  @override
  _BottomTabsState createState() => _BottomTabsState();
}

class _BottomTabsState extends State<BottomTabs> {
  int _selectedTab=0;

  @override
  Widget build(BuildContext context) {
    //Gets selected tab from widget
    _selectedTab=widget.selectedTab ?? 0;

    return Container(
      decoration: BoxDecoration(
        color: Colors.blue,
        //Curves bottom button corners
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(9.0),
          topRight: Radius.circular(9.0),
        ),
        boxShadow: [
          BoxShadow(
            //BottomTab shadow
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 1.0,
            blurRadius: 30.0,
          )
        ]
      ),
      child: Row(
        //Puts Space between each bottom row button
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        //Creates four bottom buttons
        children: [
          BottomTabButton(
            //first icon from left of screen
            imagePath: "assets/images/tab_home.png",
            selected: _selectedTab==0?true:false,
            onPressed: (){
             widget.tabFunction(0);
            },
          ),
          BottomTabButton(
            //second icon from left of screen
            imagePath: "assets/images/tab_search.png",
            selected: _selectedTab==1?true:false,
            onPressed: (){
              widget.tabFunction(1);
            },
          ),
          BottomTabButton(
            //third icon from left of screen
            imagePath: "assets/images/tab_saved.png",
            selected: _selectedTab==2?true:false,
            onPressed: (){
              widget.tabFunction(2);
            },
          ),
          BottomTabButton(
            //fourth icon from left of screen
            imagePath: "assets/images/tab_logout.png",
            selected: _selectedTab==3?true:false,
            onPressed: (){
              widget.tabFunction(3);
            },
          ),
        ],
      ),
    );
  }
}

class BottomTabButton extends StatelessWidget {
  final String imagePath; //Image file read in
  final bool selected; //Tab Selection
  final Function onPressed; //
  BottomTabButton({this.imagePath, this.selected, this.onPressed});

  @override
  Widget build(BuildContext context) {
    bool _selected=selected ?? false;
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.symmetric(
          //Sets BottomTabs Border box size
          vertical: 18.0,
            horizontal:15.0,
        ),
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              //Sets selected tab to theme color
              color: _selected ? Theme.of(context).accentColor: Colors.transparent,
              width: 2.0,
            )
          )
        ),
        child: Image(
          image:AssetImage(
          imagePath??"assets/images/tab_home.png"
          ),
          //Sets BottomTabs positioning and size
          width: 30.0,
          height: 30.0,
            //if not selected tab icon is black
            color: _selected ? Theme.of(context).accentColor: Colors.black
        ),
      ),
    );
  }
}
