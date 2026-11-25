
import 'package:material_ui/material_ui.dart';

import 'config/app_theme.dart';
import 'screens/auth/login_screen.dart';

class CampusEatsApp extends StatelessWidget {
  const CampusEatsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CampusEats',
      theme: AppTheme.lightTheme,
      home: const LoginScreen(),
    );
  }
}
