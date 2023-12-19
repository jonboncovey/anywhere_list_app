import 'package:flutter/material.dart';

class SimpsonsLoadingWidget extends StatelessWidget {
  const SimpsonsLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: CircularProgressIndicator(color: Colors.lightBlue[300]));
  }

}