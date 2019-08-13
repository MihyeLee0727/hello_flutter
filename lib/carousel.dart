import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

typedef TabHandler = void Function(BuildContext context, String text);

class CarouselRoute extends StatelessWidget {
  final List<Widget> _items = <Widget>[];

  CarouselRoute() {
    _items.add(CarouselItemWidget("111111", Colors.red, _handleTap));
    _items.add(CarouselItemWidget("222222", Colors.green, _handleTap));
    _items.add(CarouselItemWidget("333333", Colors.indigo, _handleTap));
    _items.add(CarouselItemWidget("444444", Colors.orange, _handleTap));
  }

  void _handleTap(BuildContext context, String text) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadiusDirectional.all(Radius.circular(8.0))),
          title: const Text("click alert"),
          content: Text(text),
          actions: <Widget>[
            FlatButton(
              child: Text('OK'),
              onPressed: () => Navigator.of(context).pop()
            ),
          ]
        );
      });
  }

  void _onPageChanged(int index) {
    Fluttertoast.cancel();
    Fluttertoast.showToast(msg: "$index", backgroundColor: Colors.black38);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: 200.0,
          child: PageView.builder(
            controller: PageController(viewportFraction: 0.9, initialPage: 1),
            itemBuilder: (_, index) => _items[index % _items.length],
            onPageChanged: (index) => _onPageChanged(index),
          ),
        ),
      ),
    );
  }
}

class CarouselItemWidget extends StatelessWidget {
  final String contents;
  final MaterialColor color;
  final TabHandler tap;

  CarouselItemWidget(this.contents, this.color, this.tap);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => tap(context, contents),
      child: Container(
          margin: EdgeInsets.symmetric(horizontal: 8.0),
          child: Center(child: Text(contents)),
          color: color),
    );
  }
}
