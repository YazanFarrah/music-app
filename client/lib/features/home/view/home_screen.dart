import 'package:client/config/style_constants.dart';
import 'package:client/core/providers/current_user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = context.watch<CurrentUserProvider>();
    return Scaffold(
      body: SingleChildScrollView(
        padding: StyleConstants.horizontalPadding,
        child: Column(
          children: [
            Text(userProvider.user.name),
          ],
        ),
      ),
    );
  }
}
