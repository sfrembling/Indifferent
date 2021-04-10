import 'package:flutter/material.dart';

class ProductOptions extends StatefulWidget {
  final List productOptions;
  final Function(String) onSelected;
  ProductOptions({this.productOptions, this.onSelected});

  @override
  _ProductOptionsState createState() => _ProductOptionsState();
}

class _ProductOptionsState extends State<ProductOptions> {

  int _selected = 0;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 20.0,
      ),
      child: Row(
        children: [
          for(var i =0; i < widget.productOptions.length; i++)
            //will move the highlight to selected option
            GestureDetector(
              onTap: (){
                widget.onSelected("${widget.productOptions[i]}");
                setState(() {
                  _selected = i;
                });
              },
              //Builds container around each option
              child: Container(
                width: 60.0,
                height: 42.0,
                decoration: BoxDecoration(
                  color: _selected == i ? Color(0xFFFF7109) : Color(0xFFDCDCDC),
                  borderRadius: BorderRadius.circular(8.0)
                ),
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(
                  horizontal: 4.0,
                ),
                child: Text("${widget.productOptions[i]}",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color:  _selected == i ? Colors.white : Colors.black,
                  fontSize: 16.0
                ),),
              ),
            )
        ],
      ),
    );
  }
}
