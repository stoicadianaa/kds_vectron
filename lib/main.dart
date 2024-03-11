import 'package:flutter/material.dart';
import 'package:kds_vectron/app/comenzi/comenzi_screen.dart';

import 'package:kds_vectron/core/service/web_socket.service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    WebSocketService.connectToWebSocket();
    print('Connected, listening for messages...');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ComenziScreen(),
    );
  }

  @override
  void dispose() {
    super.dispose();
    WebSocketService.dispose();
  }
}
