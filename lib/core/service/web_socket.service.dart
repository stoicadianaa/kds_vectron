import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:kds_vectron/core/service/comenzi.service.dart';
import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_frame.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:kds_vectron/core/model/comanda.dart';

class WebSocketService {
  static final comandaUpdateController =
      StreamController<Map<String, Comanda>>.broadcast();

  static Stream<Map<String, Comanda>> get comandaUpdates =>
      comandaUpdateController.stream;

  static final Map<String, Comanda> _comenzi = {};

  static void connectToWebSocket() {
    log('Connecting to WebSocket...');
    late StompClient stompClient;
    stompClient = StompClient(
      config: StompConfig(
        url: 'wss://vectron-kds-aad701792bc5.herokuapp.com/ws',
        onConnect: (StompFrame frame) async {
          await ComenziService().getComenzi().then((value) {
            final comenzi = <String, Comanda>{};
            for (var comanda in value) {
              comenzi[comanda.id] = comanda;
            }
            _comenzi.addAll(comenzi);
            comandaUpdateController.add(comenzi);
          });

          stompClient.subscribe(
            destination: '/topic/comandaUpdate',
            callback: (frame) async {
              if (frame.body == null || frame.body!.isEmpty) {
                return;
              }
              final Comanda comanda =
                  Comanda.fromJson(jsonDecode(frame.body!)['comanda']);
              _comenzi.addAll({comanda.id: comanda});
              comandaUpdateController.add(_comenzi);
            },
          );
        },
        onWebSocketError: (dynamic error) => log('WebSocket error: $error'),
        onStompError: (StompFrame frame) => log('STOMP error: ${frame.body}'),
      ),
    );

    log('Activating StompClient...');

    stompClient.activate();
  }

  static void dispose() {
    comandaUpdateController.close();
  }
}
