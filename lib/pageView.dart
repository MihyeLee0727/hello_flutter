import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class PageViewRoute extends StatelessWidget {

  final List<Widget> _items = <Widget>[];
  PageViewRoute() {
    _items.add(Container(margin: EdgeInsets.symmetric(horizontal: 8.0), child: Center(child: Text("111111")), color: Colors.red));
    _items.add(Container(margin: EdgeInsets.symmetric(horizontal: 8.0), child: Center(child: Text("222222")), color: Colors.green));
    _items.add(Container(margin: EdgeInsets.symmetric(horizontal: 8.0), child: Center(child: Text("333333")), color: Colors.indigo));
  }

  void _onPageChanged(int index) {
    Fluttertoast.cancel();
    Fluttertoast.showToast(msg: "$index", backgroundColor: Colors.black38);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: PageView.builder(
          controller: PageController(
            viewportFraction: 0.9,
            initialPage: 1
          ),
          itemBuilder: (_, index) => _items[index],
          itemCount: _items.length,
          onPageChanged: (index) => _onPageChanged(index),
        ),
      ),
    );
  }
}