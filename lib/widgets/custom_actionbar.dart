import 'package:flutter/material.dart';
import 'package:upayme_app/constants.dart';

class CustomActionBar extends StatelessWidget {
  //Page title
  final String title;
  //Option to display title on page or not
  final bool hasTitle;
  //Page back arrow
  final bool hasBackArrow;
  CustomActionBar({this.title, this.hasBackArrow, this.hasTitle});
  @override
  Widget build(BuildContext context) {
    bool _hasBackArrow = hasBackArrow ?? false;
    bool _hasTitle = hasTitle ?? true;
    return Container(
      padding: EdgeInsets.only(
        top: 50.0,
        left: 24.0,
        right: 24.0,
        bottom: 24.0,
      ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if(_hasBackArrow)
              Container(
                width: 30.0,
                height: 35.0,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                //Positioning boc text to center
                alignment: Alignment.center,
                child: Image(
                  image: AssetImage(
                    "assets/images/back_arrow.png"
                  ),
                  color: Colors.white,
                  width: 20.0,
                  height: 20.0,
                ),
              ),
            //If page has title then text will be displayed
            if(_hasTitle)
            Text(
              title ?? "Title ",
              style: Constants.boldheading,
            ),
            Container(
              width: 30.0,
              height: 35.0,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(8.0),
              ),
              //Positioning boc text to center
              alignment: Alignment.center,
              child: Text(
                "0",
                  style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w600,
                    color: Colors.white
              )
              ),
            )
          ],
        ),
    );
  }
}
