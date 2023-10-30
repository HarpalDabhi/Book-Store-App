import 'package:flutter/material.dart';

class GradientCont extends StatelessWidget {
  const GradientCont({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
        Colors.blue.shade200,
        Colors.blue.shade200,
        Colors.green.shade400
      ])),
    );
    
  }
}
