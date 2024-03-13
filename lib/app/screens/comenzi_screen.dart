import 'package:flutter/material.dart';
import 'package:kds_vectron/app/widgets/card_comanda.dart';
import 'package:kds_vectron/app/widgets/exact_time.dart';
import 'package:kds_vectron/core/extensions/date_time_extension.dart';
import 'package:kds_vectron/core/model/comanda.dart';
import 'package:kds_vectron/core/service/comenzi.service.dart';
import 'package:kds_vectron/core/service/web_socket.service.dart';

class ComenziScreen extends StatelessWidget {
  ComenziScreen({super.key});

  final ComenziService comenziService = ComenziService();
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade50,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        title: ExactTime(),
        centerTitle: true,
        actions: [
          Text(
            DateTime.now().formattedDate,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: StreamBuilder(
        stream: WebSocketService.comandaUpdateController.stream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final List<Comanda> comenzi = snapshot.data?.values.toList() ?? [];
            comenzi.removeWhere((element) => element.oraEnd != null);

            return Scrollbar(
              interactive: true,
              thumbVisibility: true,
              thickness: 10.0,
              controller: _scrollController,
              child: GridView.extent(
                controller: _scrollController,
                maxCrossAxisExtent: 400 + 16,
                padding: const EdgeInsets.all(16),
                children: [
                  for (var data in comenzi) CardComanda(comanda: data),
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
