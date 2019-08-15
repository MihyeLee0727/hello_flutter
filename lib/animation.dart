import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class AnimationRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AnimationState();
  }
}

class _AnimationState extends State<AnimationRoute> {
  final _AnimationModel model = _AnimationModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              _AnimatedRectangleWidget(model.getBehaviorStream()),
              _AnimationButtonRowWidget(model)
            ],
          )
      ),
    );
  }

  @override
  void dispose() {
    model.dispose();
    super.dispose();
  }
}

class _AnimatedRectangleWidget extends StatefulWidget {
  final Stream<_Behavior> behaviorStream;
  _AnimatedRectangleWidget(this.behaviorStream);

  @override
  State<StatefulWidget> createState() {
    return _AnimatedRectangleState(behaviorStream);
  }
}

class _AnimatedRectangleState extends State<_AnimatedRectangleWidget> with TickerProviderStateMixin {

  final Stream<_Behavior> behaviorStream;
  AnimationController _animationController;
  Animation<double> _animation;
  Animation<AlignmentGeometry> _animationMove;

  _AnimatedRectangleState(this.behaviorStream) {
    _animationController = AnimationController(
        vsync: this, duration: Duration(seconds: 2)
    );
    _animation = Tween(begin: 0.0, end: 1.0).animate(_animationController);
    _animationMove = AlignmentTween(begin: Alignment.centerLeft, end: Alignment.centerRight).animate(_animationController);
    _animationController.forward();
    _animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _animationController.repeat();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Center(
        child: StreamBuilder(
            stream: behaviorStream,
            initialData: _Behavior.Rotate,
            builder: (_, AsyncSnapshot<_Behavior> snapshot) {
              switch(snapshot.data) {
                case _Behavior.Rotate:
                  return RotationTransition(
                    turns: _animation,
                    child: Container(
                      color: Colors.blue,
                      width: 100,
                      height: 100
                    ),
                  );

                case _Behavior.Scale:
                  return ScaleTransition(
                    scale: _animation,
                    child: Container(
                        color: Colors.amber,
                        width: 100,
                        height: 100
                    ),
                  );

                case _Behavior.Move:
                  return AlignTransition(
                    alignment: _animationMove,
                    child: Container(
                        color: Colors.green,
                        width: 100,
                        height: 100
                    ),
                  );
              }
              return AnimatedContainer(
                  duration: Duration(seconds: 3),
                  width: 100,
                  height: 100
              );
            }
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}

enum _Behavior {
  Rotate,
  Scale,
  Move,
}

class _AnimationModel {
  final PublishSubject<_Behavior> _behavior = PublishSubject();

  Stream<_Behavior> getBehaviorStream() => _behavior.stream;

  void rotate() {
    _behavior.sink.add(_Behavior.Rotate);
  }

  void scale() {
    _behavior.sink.add(_Behavior.Scale);
  }

  void move() {
    _behavior.sink.add(_Behavior.Move);
  }

  void dispose() {
    _behavior.close();
  }
}

class _AnimationButtonRowWidget extends StatelessWidget {

  final _AnimationModel _animationModel;

  _AnimationButtonRowWidget(this._animationModel);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        MaterialButton(
          color: Colors.amberAccent,
          onPressed: _animationModel.rotate,
          child: Text("rotate"),
        ),
        RaisedButton(
          onPressed: _animationModel.scale,
          child: Text("scale"),
        ),
        OutlineButton(
          color: Colors.cyan,
          onPressed: _animationModel.move,
          child: Text("move"),
        )
      ],
    );
  }
}