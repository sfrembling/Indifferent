import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Function onPressed;
  final bool outlinebutton;
  final bool isLoading;
  CustomButton({this.text, this.onPressed, this.outlinebutton, this. isLoading});
  @override
  Widget build(BuildContext context) {
    //Getting variable returned truth value
    bool _outlinebutton=outlinebutton ?? false;
    bool _isLoading = isLoading ?? false;
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 65.0,
        decoration: BoxDecoration(
          color: _outlinebutton ? Colors.transparent : Colors.black,
          border: Border.all(
            color: Colors.black,
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(
            12.0,
          ),
        ),
        margin:EdgeInsets.symmetric(
          horizontal: 24.0,
          vertical: 12.0,
        ),
        child: Stack(
          children: [
            //Hides text when loading
            Visibility(
              visible: _isLoading ? false : true,
              child: Center(
                child: Text(
                   text ??  "Text",
                style: TextStyle(
                  fontSize: 16.0,
                  color: _outlinebutton ? Colors.black : Colors.white,
                  fontWeight: FontWeight.w600,
                ),
                ),
              ),
            ),
            Visibility(
            visible: _isLoading,
              child: Center(
                child: SizedBox(
                  height: 30.0,
                    width:30.0,
                    child: CircularProgressIndicator()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
