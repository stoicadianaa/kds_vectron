import 'dart:async';

import 'package:kds_vectron/core/service/comenzi.service.dart';
import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_frame.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:kds_vectron/core/model/comanda.dart';

class WebSocketService {
  static final comandaUpdateController = StreamController<List<Comanda>>.broadcast();

  static Stream<List<Comanda>> get comandaUpdates => comandaUpdateController.stream;

  static void connectToWebSocket() {
    print('Connecting to WebSocket...');
    late StompClient stompClient;
    stompClient = StompClient(
      config: StompConfig(
        url: 'wss://vectron-kds-aad701792bc5.herokuapp.com/ws',
        onConnect: (StompFrame frame) async {
          final List<Comanda> comenzi = await ComenziService().getComenzi();
          comandaUpdateController.add(comenzi);

          stompClient.subscribe(
            destination: '/topic/comandaUpdate',
            callback: (frame) async {
              final List<Comanda> comenzi = await ComenziService().getComenzi();
              comandaUpdateController.add(comenzi);
              },
          );
        },
        onWebSocketError: (dynamic error) => print('WebSocket error: $error'),
        onStompError: (StompFrame frame) => print('STOMP error: ${frame.body}'),
      ),
    );

    print('Activating StompClient...');

    stompClient.activate();
  }

  static void dispose() {
    comandaUpdateController.close();
  }
}
