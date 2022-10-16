import 'package:flutter/material.dart';
import 'package:person_app/models/person_model.dart';

class PersonEditView extends StatelessWidget {
  PersonEditView(
      {super.key, required this.onSave, required this.onBack, this.person});

  final PersonModel? person;
  final Function(PersonModel person) onSave;
  final VoidCallback onBack;

  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  final TextEditingController _firstname = TextEditingController();
  final TextEditingController _surname = TextEditingController();
  final TextEditingController _email = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _firstname.text = person?.firstname ?? '';
    _surname.text = person?.surname ?? '';
    _email.text = person?.email ?? '';
    return Form(
      child: Form(
        key: _key,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                person == null ? 'Nova Pessoa' : 'Alterar Pessoa',
                style: const TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 8.0, left: 8.0, right: 8.0, bottom: 8.0),
              child: TextFormField(
                controller: _firstname,
                decoration: const InputDecoration(
                  label: Text('nome'),
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Nome obrigatório' : null,
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
              child: TextFormField(
                controller: _surname,
                decoration: const InputDecoration(
                  label: Text('sobrenome'),
                  border: OutlineInputBorder(),
                ),
                validator: (value) => value == null || value.isEmpty
                    ? 'Sobrenome obrigatório'
                    : null,
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
              child: TextFormField(
                controller: _email,
                decoration: const InputDecoration(
                  label: Text('email'),
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Email obrigatório' : null,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 32.0),
              child: ElevatedButton(
                onPressed: () {
                  if (_key.currentState!.validate()) {
                    onSave(PersonModel(
                      id: person?.id,
                      firstname: _firstname.text,
                      surname: _surname.text,
                      email: _email.text,
                    ));
                  }
                },
                child: const Text('Salvar'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
              child: ElevatedButton(
                onPressed: onBack,
                child: const Text('Voltar'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
