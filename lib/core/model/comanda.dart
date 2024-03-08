import 'package:kds_vectron/core/enums/tip_comanda.dart';
import 'package:kds_vectron/core/model/produs_comanda.dart';

class Comanda {
  String idOspatar;
  String numeOspatar;
  TipComanda tipComanda;
  String nrMasa;
  double valoareComanda;
  String observatiiComanda;
  List<ProdusComanda> produseComanda;
  String nrComanda;
  DateTime dataComanda;

  Comanda(
      this.idOspatar,
      this.numeOspatar,
      this.tipComanda,
      this.nrMasa,
      this.valoareComanda,
      this.observatiiComanda,
      this.produseComanda,
      this.nrComanda,
      this.dataComanda);


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
}