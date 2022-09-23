import 'package:flutter/material.dart';


class MyProgressIndicator extends StatelessWidget {
  const MyProgressIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      backgroundColor: Colors.yellow,
      color: Colors.green[800],
    );
  }
}

class MyLinearIndicator extends StatelessWidget {
  const MyLinearIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(padding:const EdgeInsets.symmetric(horizontal: 22),
    child: LinearProgressIndicator(
      backgroundColor: Colors.yellow,
      color:  Colors.green[800],
      ),
    );
    
  }
}