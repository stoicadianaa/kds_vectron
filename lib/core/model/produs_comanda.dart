class ProdusComanda {
  String id;
  String denumire;
  String denumireCategorie;
  String observatii;
  num cantitate;
  num pretUnitar;
  int idComanda;

  ProdusComanda(this.id, this.denumire, this.denumireCategorie, this.observatii,
      this.cantitate, this.pretUnitar, this.idComanda);

  @override
  String toString() {
    return 'ProdusComanda{id: $id, denumire: $denumire, denumireCategorie: $denumireCategorie, observatii: $observatii, cantitate: $cantitate, pretUnitar: $pretUnitar, idComanda: $idComanda}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProdusComanda &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          idComanda == other.idComanda;

  @override
  int get hashCode => id.hashCode ^ idComanda.hashCode;
}