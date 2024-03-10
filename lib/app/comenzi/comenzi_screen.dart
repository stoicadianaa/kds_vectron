import 'dart:async';

import 'package:flutter/material.dart';
import 'package:kds_vectron/core/enums/tip_comanda.dart';
import 'package:kds_vectron/core/extensions/date_time_extension.dart';
import 'package:kds_vectron/core/model/comanda.dart';
import 'package:kds_vectron/core/service/comenzi.service.dart';

class ComenziScreen extends StatelessWidget {
  ComenziScreen({super.key});

  final ComenziService comenziService = ComenziService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade50,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        title: ExactTime(),
      ),
      body: FutureBuilder(
        future: ComenziService().getComenzi(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final List<Comanda> comenzi = snapshot.data ?? [];

            return GridView.extent(maxCrossAxisExtent: 400 + 16,
                padding: const EdgeInsets.all(16),
                children: [
              for (var comanda in comenzi) CardComanda(comanda: comanda)
            ]);
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }
          return const CircularProgressIndicator();
        },
      ),
    );
  }
}

class CardComanda extends StatelessWidget {
  CardComanda({
    super.key,
    required this.comanda,
  });

  final Comanda comanda;
  final ScrollController _scrollController = ScrollController();

  //todo change
  ValueNotifier<bool> started = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(),
        color: Colors.white,
      ),
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(8),
      width: 300,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(comanda.tipComanda.icon, size: 16),
                    const SizedBox(width: 8),
                    Text(comanda.tipComanda.name),
                    if (comanda.tipComanda == TipComanda.dinein)
                      Text(' - Masa ${comanda.nrMasa}'),
                  ],
                ),
                Text('Ospatar: ${comanda.numeOspatar}'),
              ],
            ),
            const Spacer(),
            Text(comanda.dataComanda.formattedTime),
          ],
        ),
        const Divider(color: Colors.black),
        Expanded(
          child: Scrollbar(
            thickness: 10.0,
            radius: const Radius.circular(10.0),
            interactive: true,
            thumbVisibility: true,
            controller: _scrollController,
            child: ListView(
              controller: _scrollController,
              children: [
                for (var produs in comanda.produseComanda)
                  Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            produs.cantitate.toString(),
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              produs.denumire,
                              softWrap: true,
                            ),
                          ),
                        ],
                      ),
                      const Divider(color: Colors.black12),
                    ],
                  ),
              ],
            ),
          ),
        ),
        if (comanda.observatiiComanda.isNotEmpty)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Divider(color: Colors.black),
              Text('Observatii: ${comanda.observatiiComanda}'),
              const SizedBox(height: 8),
            ],
          ),
        ValueListenableBuilder(
            valueListenable: started,
            builder: (context, orderStarted, _) {
              if (orderStarted) {
                return TextButton(
                    onPressed: () {},
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.black),
                      fixedSize: MaterialStateProperty.all(
                          const Size(double.maxFinite, 50)),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                    child: const Row(
                      children: [
                        Text(
                          'ORDER STARTED',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                );
              }

              return TextButton(
                onPressed: () {
                  started.value = true;
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.black),
                  fixedSize: MaterialStateProperty.all(
                      const Size(double.maxFinite, 50)),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
                child: const Text(
                  'START COOKING',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w600),
                ),
              );
            }),
      ]),
    );
  }
}

class ExactTime extends StatelessWidget {
  ExactTime({super.key, this.style}) {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      time.value = DateTime.now();
    });
  }

  final ValueNotifier<DateTime> time = ValueNotifier(DateTime.now());
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: time,
      builder: (context, DateTime value, child) {
        return Text(value.formattedTime);
      },
    );
  }
}


