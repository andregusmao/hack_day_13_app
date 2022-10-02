import 'dart:convert';
import 'dart:io';

import 'package:person_app/models/person_model.dart';
import 'package:http/http.dart' as http;

class PersonService {
  final String _url = 'http://localhost:4000/api';

  Future<List<PersonModel>?> getAll() async {
    try {
      final http.Response response = await http.get(Uri.parse('$_url/persons'));

      switch (response.statusCode) {
        case 200:
          return PersonModel.fromJsonList(jsonDecode(response.body)['data']);
      }
    } catch (e) {
      print(e);
    }

    return null;
  }

  Future<PersonModel?> getOne(String id) async {
    try {
      final http.Response response =
          await http.get(Uri.parse('$_url/persons/$id'));

      switch (response.statusCode) {
        case 200:
          return PersonModel.fromJson(jsonDecode(response.body)['data']);
      }
    } catch (e) {
      print(e);
    }

    return null;
  }
}
