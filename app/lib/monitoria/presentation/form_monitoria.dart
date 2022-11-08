import 'dart:developer' as dev;
import 'package:flutter/material.dart';

import 'package:uniuti_core/uniuti_core.dart';
import 'package:uniuti_styles/uniuti_styles.dart';
import '../application/form_monitoria_store.dart';

class FormMonitoriaScreen extends StatelessWidget {
  FormMonitoriaScreen({Key? key, required this.controller, required this.tipo})
      : super(key: key);
  final _form = GlobalKey<FormState>();
  final FormMonitoriaStore controller;
  final TipoSolicitacao tipo;
  static const String route = '/formMonitoria';

  @override
  Widget build(BuildContext context) {
    final _th = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Form(
        key: _form,
        child: Container(
          padding: const EdgeInsets.all(35),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              UniUtiTitleInput(
                placeholder: 'Titulo',
                save: (newValue) =>
                    controller.monitoria.titulo = newValue ?? '',
              ),
              UniUtiDescricaoInput(
                placeholder: 'Descricao',
                valid: (value) =>
                    value != null ? null : 'Fornecer uma Descrição!',
                save: (newValue) =>
                    controller.monitoria.descricao = newValue ?? '',
              ),
              dropdownDisciplina(placeholder: 'Disciplina'),
              dropdownInsitituicao(placeholder: 'Instituição'),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: ElevatedButton(
                  onPressed: () {
                    switch (tipo) {
                      case TipoSolicitacao.solicitar:
                        dialogoPublicar(context);
                        break;
                      default:
                        dialogoContatar(context);
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: Text(
                      'Publicar',
                      style: _th.titleLarge!.copyWith(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  dropdownDisciplina({required String placeholder}) {
    return FutureBuilder<List<Disciplina>>(
      future: controller.getDisciplinas(),
      builder: (context, snapshot) {
        var items = 0;
        if (snapshot.hasData) {
          items = snapshot.data!.length;
        }
        return Container(
          margin: const EdgeInsets.only(bottom: 25),
          child: DropdownButtonFormField<Disciplina>(
            decoration: uniUtiInputDecoration(placeholder),
            items: List.generate(
              items,
              (index) {
                return DropdownMenuItem(
                  value: snapshot.data![index],
                  child: Text(snapshot.data![index].nome),
                );
              },
            ),
            validator: (value) =>
                value != null ? null : 'Favor selecionar uma Disciplina!',
            onSaved: (newValue) => controller.monitoria.disciplina = newValue!,
            onChanged: (sel) => dev.log(sel.toString()),
          ),
        );
      },
    );
  }

  dropdownInsitituicao({required String placeholder}) {
    return FutureBuilder(
      future: controller.getInstituicao(),
      builder: (context, snapshot) {
        var items = 0;
        if (snapshot.hasData) {
          items = snapshot.data!.length;
        }
        return Container(
          margin: const EdgeInsets.only(bottom: 25),
          child: DropdownButtonFormField(
            decoration: uniUtiInputDecoration(placeholder),
            items: List.generate(
              items,
              (index) {
                return DropdownMenuItem(
                  value: snapshot.data![index],
                  child: Text(snapshot.data![index].nome),
                );
              },
            ),
            validator: (value) =>
                value != null ? null : 'Favor selecionar uma Disciplina!',
            onSaved: (newValue) => controller.monitoria.instituicao = newValue!,
            onChanged: (sel) => dev.log(sel.toString()),
          ),
        );
      },
    );
  }

  void dialogoPublicar(BuildContext context) {
    if (!_form.currentState!.validate()) {
      return;
    }
    _form.currentState!.save();
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(18),
            topRight: Radius.circular(18),
          ),
          side: BorderSide.none),
      builder: (context) {
        return FutureBuilder(
            future: controller.publicarMonitoria(tipo),
            builder: (_, snap) {
              if (snap.connectionState == ConnectionState.done) {
                if (snap.hasError) {
                  return Container(
                    margin: const EdgeInsets.fromLTRB(20, 35, 20, 15),
                    child: Text('${snap.error}'),
                  );
                }
                if (snap.hasData) {
                  return Container(
                    margin: const EdgeInsets.fromLTRB(20, 35, 20, 15),
                    child: Text(
                      snap.data.runtimeType == FailPublicarState
                          ? (snap.data as FailPublicarState).message
                          : 'Publicado',
                    ),
                  );
                }
              }
              return Container(
                margin: const EdgeInsets.fromLTRB(20, 35, 20, 15),
                child: const Text('Publicando'),
              );
            });
      },
    );
  }

  void dialogoContatar(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(18),
            topRight: Radius.circular(18),
          ),
          side: BorderSide.none),
      builder: (context) {
        return Container(
          margin: const EdgeInsets.fromLTRB(20, 35, 20, 15),
          child: const Text('TESTE'),
        );
      },
    );
  }
}
