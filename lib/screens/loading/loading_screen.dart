import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

String animationName = 'Loading';

class LoadingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 300,
          height: 300,
          alignment: Alignment.center,
          child: const FlareActor(
            'android/assets/flare/loading_adj.flr',
            animation: 'Loading',
          ),
        ),
      ),
    );
  }
}
