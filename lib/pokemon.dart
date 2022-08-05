import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';

class Pokemon extends StatefulWidget {
  const Pokemon({Key? key}) : super(key: key);

  @override
  State<Pokemon> createState() => _PokemonState();
}

class _PokemonState extends State<Pokemon> with TickerProviderStateMixin {
  late AnimationController controller;
  late AnimationController controller2;
  late Animation<Offset> offset;
  late CurvedAnimation pokemonController;
  late Animation<Offset> offset2;

  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 1));

    controller2 =
        AnimationController(vsync: this, duration: Duration(seconds: 5));

    offset = Tween<Offset>(begin: Offset(0.0, 1.0), end: Offset.zero)
        .animate(controller);

    offset2 = Tween<Offset>(begin: Offset(-1, 0), end: Offset(1, 0))
        .animate(controller2);

    pokemonController =
        CurvedAnimation(parent: controller, curve: Curves.bounceInOut);

    controller2.repeat(reverse: true);

    controller.addListener(() => setState(() {}));
    controller.addStatusListener(
      (AnimationStatus status) {
        if (status == AnimationStatus.completed) {
          controller.reverse();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Positioned(
            right: 150,
            top: 500,
            child: RaisedButton(
              child: Text('Jump'),
              onPressed: () {
                if (!controller.isAnimating) {
                  controller.forward();
                }
              },
            ),
          ),
          Positioned(
            top: 120,
            right: 130,
            child: Align(
              alignment: Alignment.topCenter,
              child: SlideTransition(
                position: offset,
                child: Padding(
                  padding: EdgeInsets.all(50.0),
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
          ),
          Positioned(
            right: 170,
            top: 300,
            child: SlideTransition(
              position: offset2,
              child: Container(
                height: 50,
                width: 50,
                color: Colors.amber,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
