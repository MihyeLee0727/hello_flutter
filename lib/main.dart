import 'package:flutter/material.dart';
import 'package:hello_flutter/pageView.dart';
import 'package:rxdart/rxdart.dart';
import 'codelab1.dart';
import 'helloFlutter.dart';

void main() => runApp(
  MaterialApp(
    home: HelloFlutterApp()
  )
);

class HelloFlutterApp extends StatelessWidget {

  void _handleTodo(BuildContext context) {
    var snackbar = SnackBar(content: Text("TODO"), duration: Duration(seconds: 2));
    Scaffold.of(context).removeCurrentSnackBar();
    Scaffold.of(context).showSnackBar(snackbar);
  }
  
  List<MainGridItem> _buildCard() {
    var items = <MainGridItem>[];
    items.add(
        MainGridItem("hello flutter",
            (context) => Navigator.push(context, MaterialPageRoute(builder: (_) => MyRoute())))
    );
    items.add(
        MainGridItem("code lab : chat",
            (context) => Navigator.push(context, MaterialPageRoute(builder: (_) => FriendlychatRoute())))
    );
    items.add(MainGridItem("network", _handleTodo));
    items.add(MainGridItem("PageView",
        (context) => Navigator.push(context, MaterialPageRoute(builder: (_) => PageViewRoute()))));
    return items;
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(8.0),
        child: MainGrid(_buildCard())
      ),
    );
  }
}

class MainGrid extends StatelessWidget {
  MainGrid(this.items);

  final List<MainGridItem> items;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
      itemCount: items.length,
      itemBuilder: (_, index) => items[index]
    );
  }
}

class MainGridItem extends StatelessWidget {
  MainGridItem(this.text, this.handleTap);

  final Function handleTap;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(6.0),
      child: Material(
        color: Colors.amber,
        elevation: 4.0,
        borderRadius: BorderRadius.circular(8.0),
        child: InkWell(
          borderRadius: BorderRadius.circular(8.0),
          onTap: () => handleTap(context),
          child: Container(
            padding: EdgeInsets.all(12.0),
            child: Text(
                text
            )
          ),
        ),
      ),
    );
  }
}