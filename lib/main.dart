import 'package:flutter/material.dart';
import 'codelab1.dart';
import 'helloFlutter.dart';

void main() => runApp(
  MaterialApp(
    home: HelloFlutterApp()
  )
);

enum RouteType {
  HelloFlutter,
  CodeLab1,
  Network,
  Animation1,
}

class HelloFlutterApp extends StatelessWidget {

  void _handleCardTap(RouteType type, BuildContext context) {
    switch(type) {
      case RouteType.HelloFlutter: {
        Navigator.push(context, MaterialPageRoute(builder: (_) => MyRoute()));
      } break;
      case RouteType.CodeLab1: {
        Navigator.push(context, MaterialPageRoute(builder: (_) => FriendlychatRoute()));
      } break;
      case RouteType.Animation1:
      case RouteType.Network: {
        var snackbar = SnackBar(content: Text("TODO : ${type.toString()}"), duration: Duration(seconds: 2));
        Scaffold.of(context).removeCurrentSnackBar();
        Scaffold.of(context).showSnackBar(snackbar);
      } break;
    }
  }
  
  List<MainGridItem> _buildCard() {
    var items = <MainGridItem>[];
    items.add(MainGridItem("hello flutter", RouteType.HelloFlutter, _handleCardTap));
    items.add(MainGridItem("code lab : chat", RouteType.CodeLab1, _handleCardTap));
    items.add(MainGridItem("network", RouteType.Network, _handleCardTap));
    items.add(MainGridItem("animation1", RouteType.Animation1, _handleCardTap));
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
  MainGridItem(this.text, this.type, this.handleTap);

  final Function handleTap;
  final String text;
  final RouteType type;

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
          onTap: () => handleTap(type, context),
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