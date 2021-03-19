import 'package:flutter/material.dart';
import 'package:upayme_app/widgets/custom_actionbar.dart';

class SavedTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Center(
              child: Text(" Saved Tab")
          ),
          CustomActionBar(
            title: "Saved",
            hasBackArrow: true,
          ),
        ],
      ),
    );
  }
}
