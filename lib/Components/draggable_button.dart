import 'package:flutter/material.dart';

class DraggableCircle extends StatefulWidget {
  @override
  _DraggableCircleState createState() => _DraggableCircleState();
}

class _DraggableCircleState extends State<DraggableCircle>
    with SingleTickerProviderStateMixin {
  AnimationController? _animationController;
  Animation<Offset>? _animation;
  Offset _offset = Offset(0, 0);
  double _circleSize = 100.0;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 180),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _animationController!.dispose();
    super.dispose();
  }

  void _startAnimation() {
    _animationController!.reset();
    _animation = Tween<Offset>(
      begin: _offset,
      end: Offset(0, 0),
    ).animate(
      CurvedAnimation(
        parent: _animationController!,
        curve: Curves.easeInOut,
      ),
    );

    _animationController!.forward();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return AnimatedPositioned(
      duration: const Duration(milliseconds: 180),
      left: _offset.dx,
      top: _offset.dy,
      curve: Curves.easeInOut,
      child: GestureDetector(
        onPanDown: (_) {
          _animationController!.stop();
        },
        onPanUpdate: (details) {
          double newLeft = _offset.dx + details.delta.dx;
          double newTop = _offset.dy + details.delta.dy;

          setState(() {
            _offset = Offset(
              newLeft.clamp(0, screenWidth - _circleSize),
              newTop.clamp(0, screenHeight - _circleSize),
            );
          });
        },
        onPanEnd: (_) {
          _startAnimation();
        },
        onTap: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Hey..!! I'm Swapwing.!",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      "I'm here to help. ask me anything.",
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              );
            },
          );
        },
        child: Container(
          width: _circleSize,
          height: _circleSize,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.transparent,
            image: DecorationImage(
              image: AssetImage("assets/icons/swapwing_mascot.png"),
            ),
          ),
        ),
      ),
    );
  }
}
