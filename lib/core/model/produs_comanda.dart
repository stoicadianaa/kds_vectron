class ProdusComanda {
  String id;
  String denumire;
  String? idCategorieProdus;
  String? denumireCategorie;
  String? observatii;
  num cantitate;
  num pretUnitar;
  String idComanda;

  ProdusComanda(this.id, this.denumire, this.idCategorieProdus, this.denumireCategorie, this.observatii,
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

  factory ProdusComanda.fromJson(Map<String, dynamic> json) {
    //todo add checks for null

    if (json['id_produs'] == null) {
      throw Exception('id_produs is null');
    }
    if (json['denumire_produs'] == null) {
      throw Exception('denumire_produs is null');
    }
    if (json['cantitate_produs'] == null) {
      throw Exception('cantitate_produs is null');
    }
    if (json['pret_produs'] == null) {
      throw Exception('pret_produs is null');
    }
    if (json['id_comanda'] == null) {
      throw Exception('id_comanda is null');
    }

    return ProdusComanda(
      json['id_produs'],
      json['denumire_produs'],
      json['id_categorie_produs'],
      json['denumire_categorie_produs'],
      json['observatii_produs'],
      json['cantitate_produs'],
      json['pret_produs'],
      json['id_comanda']
    );
  }
}