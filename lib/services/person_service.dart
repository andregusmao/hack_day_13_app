import 'dart:convert';

import 'package:person_app/models/error_model.dart';
import 'package:person_app/models/person_model.dart';
import 'package:http/http.dart' as http;

class PersonService {
  final String _url = 'http://localhost:4000/api';

  Future<dynamic> getAll() async {
    try {
      final http.Response response = await http.get(Uri.parse('$_url/persons'));

      switch (response.statusCode) {
        case 200:
          return PersonModel.fromJsonList(jsonDecode(response.body)['data']);
      }
    } catch (e) {
      return ErrorModel(message: e.toString());
    }

    return ErrorModel(message: 'Ocorreu um erro');
  }

  Future<dynamic> getOne(String id) async {
    try {
      final http.Response response =
          await http.get(Uri.parse('$_url/persons/$id'));

      switch (response.statusCode) {
        case 200:
          return PersonModel.fromJson(jsonDecode(response.body)['data']);
      }
    } catch (e) {
      return ErrorModel(message: e.toString());
    }

    return ErrorModel(message: 'Ocorreu um erro');
  }

  Future<dynamic> insert(PersonModel person) async {
    try {
      final http.Response response = await http.post(
        Uri.parse('$_url/persons'),
        headers: {
          'Content-type': 'application/json',
        },
        body: jsonEncode(person.toJson()),
      );

      switch (response.statusCode) {
        case 201:
          return PersonModel.fromJson(jsonDecode(response.body)['data']);
        default:
          return ErrorModel(message: 'Ocorreu um erro');
      }
    } catch (e) {
      return ErrorModel(message: e.toString());
    }
  }

  Future<dynamic> update(PersonModel person) async {
    try {
      final http.Response response = await http.put(
        Uri.parse('$_url/persons/${person.id}'),
        body: person.toJson(),
      );

      switch (response.statusCode) {
        case 200:
          return PersonModel.fromJson(jsonDecode(response.body)['data']);
        default:
          return ErrorModel(message: 'Ocorreu um erro');
      }
    } catch (e) {
      return ErrorModel(message: e.toString());
    }
  }

  Future<dynamic> delete(String id) async {
    try {
      final http.Response response = await http.delete(
        Uri.parse('$_url/persons/$id'),
      );

      switch (response.statusCode) {
        case 204:
          return null;
        default:
          return ErrorModel(message: 'Ocorreu um erro');
      }
    } catch (e) {
      return ErrorModel(message: e.toString());
    }
  }
}
