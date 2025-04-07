import 'package:flutter/material.dart';

class MyCreatedCapsulesView extends StatefulWidget {
  const MyCreatedCapsulesView({super.key});

  @override
  State<MyCreatedCapsulesView> createState() => _MyCreatedCapsulesViewState();
}

class _MyCreatedCapsulesViewState extends State<MyCreatedCapsulesView> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('My Created Capsules'),
      ),
    );
  }
}
