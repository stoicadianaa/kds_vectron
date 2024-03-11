// ignore_for_file: unused_import, always_use_package_imports, use_key_in_widget_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:kds_vectron/app/comenzi/comenzi_screen.dart';
import 'package:kds_vectron/core/service/comenzi.service.dart';
import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';
import 'package:web_socket_channel/html.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import 'core/service/web_socket.service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
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
      home: ComenziScreen(),
    );
  }

  @override
  void dispose() {
    super.dispose();
    WebSocketService.dispose();
  }
}
