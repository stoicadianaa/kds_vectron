import 'package:kds_vectron/core/enums/tip_comanda.dart';
import 'package:kds_vectron/core/model/produs_comanda.dart';

class Comanda {
  String? idOspatar;
  String? numeOspatar;
  TipComanda tipComanda;
  String? nrMasa;
  String id;
  double? valoareComanda;
  String? observatiiComanda;
  List<ProdusComanda> produseComanda;
  String nrComanda;
  DateTime dataComanda;
  DateTime? oraStart;
  DateTime? oraEnd;

  Comanda(
    this.idOspatar,
    this.numeOspatar,
    this.tipComanda,
    this.nrMasa,
    this.id,
    this.valoareComanda,
    this.observatiiComanda,
    this.produseComanda,
    this.nrComanda,
    this.dataComanda,
    this.oraStart,
    this.oraEnd,
  );

  @override
  String toString() {
    return 'Comanda{idOspatar: $idOspatar, numeOspatar: $numeOspatar, tipComanda: $tipComanda, nrMasa: $nrMasa, valoareComanda: $valoareComanda, observatiiComanda: $observatiiComanda, produseComanda: $produseComanda, nrComanda: $nrComanda, dataComanda: $dataComanda}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Comanda &&
          runtimeType == other.runtimeType &&
          nrComanda == other.nrComanda;

  @override
  int get hashCode => nrComanda.hashCode;

  factory Comanda.fromJson(Map<String, dynamic> json) {
    if (json['id_comanda'] == null) {
      throw Exception('id_comanda is null');
    }

    if (json['numar_comanda'] == null) {
      throw Exception('numar_comanda is null');
    }
    if (json['data_comanda'] == null) {
      throw Exception('data_comanda is null');
    }

    return Comanda(
      json['id_ospatar'],
      json['nume_ospatar'],
      TipComanda.values.firstWhere((e) => e.value == json['tip_comanda'],
          orElse: () => TipComanda.other),
      json['table_no'],
      json['id_comanda'],
      json['valoare_comanda'],
      json['observatii_comanda'],
      (json['produse_comanda'] as List)
          .map((e) => ProdusComanda.fromJson(e))
          .toList(),
      json['numar_comanda'].toString(),
      DateTime.parse(json['data_comanda']),
      DateTime.tryParse(json['start_time'] ?? ''),
      DateTime.tryParse(json['end_time'] ?? ''),
    );
  }
}
