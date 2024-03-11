// ignore_for_file: prefer_single_quotes

import 'dart:async';
import 'dart:convert';

import 'package:kds_vectron/core/model/comanda.dart';
import 'package:http/http.dart' as http;

class ComenziService {
  Future<List<Comanda>> getComenzi() async {
    final http.Response response = await http.get(Uri.parse(
        'https://vectron-kds-aad701792bc5.herokuapp.com/rest/comenzi/all'));

    final String source = const Utf8Decoder().convert(response.bodyBytes);

    final json = jsonDecode(source)["comenzi"];

    final List<Comanda> comenzi = [];
    for (var comanda in json) {
      comenzi.add(Comanda.fromJson(comanda));
    }
    return comenzi;
  }

  static Future<void> startComanda(String id) async {
    await http.put(Uri.parse(
        'http://vectron-kds-aad701792bc5.herokuapp.com/rest/comenzi/updateStartTime/$id'));
  }

  static Future<void> endComanda(String id) async {
    await http.put(Uri.parse(
        'http://vectron-kds-aad701792bc5.herokuapp.com/rest/comenzi/updateEndTime/$id'));
  }
}
