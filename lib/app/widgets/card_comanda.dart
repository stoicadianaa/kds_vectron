import 'package:flutter/material.dart';
import 'package:kds_vectron/app/widgets/counter.dart';
import 'package:kds_vectron/core/enums/tip_comanda.dart';
import 'package:kds_vectron/core/extensions/date_time_extension.dart';
import 'package:kds_vectron/core/model/comanda.dart';
import 'package:kds_vectron/core/service/comenzi.service.dart';

class CardComanda extends StatelessWidget {
  CardComanda({
    super.key,
    required this.comanda,
  }) {
    started = ValueNotifier(comanda.oraStart != null);
  }

  final Comanda comanda;
  final ScrollController _scrollController = ScrollController();

  late final ValueNotifier<bool> started;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(),
        color: Colors.white,
      ),
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildInfoComanda(),
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              produs.cantitate.toString(),
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
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
                        if (produs.observatii.isNotEmpty)
                          Row(
                            children: [
                              const Icon(
                                Icons.info_outline,
                                size: 16,
                                color: Colors.grey,
                              ),
                              const SizedBox(width: 4),
                              Text(produs.observatii),
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
                  onPressed: () async {
                    await ComenziService.endComanda(comanda.id);
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Colors.deepOrange),
                    fixedSize: MaterialStateProperty.all(
                        const Size(double.maxFinite, 50)),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'ORDER STARTED',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(width: 8),
                      Counter(
                        startTime: comanda.oraStart!,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                );
              }
              return TextButton(
                onPressed: () async {
                  await ComenziService.startComanda(comanda.id);
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
            },
          ),
        ],
      ),
    );
  }

  Flex buildInfoComanda() {
    return Flex(
      direction: Axis.horizontal,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(comanda.tipComanda.icon, size: 16),
                  const SizedBox(width: 8),
                  Text(
                    comanda.tipComanda.name,
                    softWrap: true,
                  ),
                  if (comanda.tipComanda == TipComanda.dinein)
                    Text(' - Masa ${comanda.nrMasa}', softWrap: true),
                ],
              ),
              Text('Ospatar: ${comanda.numeOspatar}', softWrap: true),
            ],
          ),
        ),
        Text(comanda.dataComanda.formattedTime, softWrap: true),
      ],
    );
  }
}
