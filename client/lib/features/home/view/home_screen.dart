import 'package:client/config/style_constants.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: StyleConstants.horizontalPadding,
        child: const Column(),
      ),
    );
  }
}
