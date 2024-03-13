import 'dart:async';
import 'dart:convert';

import 'package:kds_vectron/core/model/comanda.dart';
import 'package:http/http.dart' as http;
import 'package:kds_vectron/core/utils/uris.dart';

class ComenziService {
  Future<List<Comanda>> getComenzi() async {
    final http.Response response = await http.get(Uris.comenziUri);
    final String source = const Utf8Decoder().convert(response.bodyBytes);
    final List<dynamic> json = jsonDecode(source)['comenzi'];

    return json.map((comanda) => Comanda.fromJson(comanda)).toList();
  }

  static Future<void> startComanda(String id) async {
    await http.put(Uris.startComandaUri.replace(queryParameters: {'id': id}));
  }

  static Future<void> endComanda(String id) async {
    await http.put(Uris.endComandaUri.replace(queryParameters: {'id': id}));
  }
}
