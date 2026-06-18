import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'theme/gmail_theme.dart';
import 'viewmodels/auth_viewmodel.dart';
import 'viewmodels/correo_viewmodel.dart';
import 'views/gmail_view.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthViewModel()),
        ChangeNotifierProvider(create: (_) => CorreoViewModel()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: GmailTheme.lightTheme,
        home: const GmailView(),
      ),
    ),
  );
}
