import 'package:flutter/material.dart';

class WorkOutInfo extends StatelessWidget {
  final int id;
  const WorkOutInfo({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Text(id.toString()),
    );
  }
}
