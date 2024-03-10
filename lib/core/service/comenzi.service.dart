import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:kds_vectron/core/model/comanda.dart';
import 'package:http/http.dart' as http;

class ComenziService {
  Future readJson() async {
    final String response = await rootBundle.loadString('lib/core/data.json');
    final data = await json.decode(response);
    return data;
  }

  Future<void> updateField(String key, dynamic newValue) async {
    // final String response = await rootBundle.loadString('lib/core/data.json');
    // Map<String, dynamic> data = json.decode(response);
    //
    // data[key] = newValue;
    //
    // String updatedJson = json.encode(data);
    //
    // final file = File('lib/core/data.json');
    // await file.writeAsString(updatedJson);
  }

  Future<List<Comanda>> getComenzi() async {
    final http.Response response = await http.get(
      Uri.parse('https://vectron-kds-aad701792bc5.herokuapp.com/rest/comenzi/all')
    );

    String source = Utf8Decoder().convert(response.bodyBytes);

    final json = jsonDecode(source)["comenzi"];

    final List<Comanda> comenzi = [];
    for (var comanda in json) {
      print(comanda);
      comenzi.add(Comanda.fromJson(comanda));
    }
    return comenzi;
  }

  Future finishComanda(String id) async {
    // final String response = await rootBundle.loadString('lib/core/data.json');
    // Map<String, dynamic> data = json.decode(response);
    //
    // for (var comanda in data['data']) {
    //   if (comanda['comanda']['id'] == id) {
    //     comanda['comanda']['status'] = 'finished';
    //   }
    // }
  }
}