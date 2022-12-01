import 'dart:developer' as dev;
import 'package:flutter/material.dart';
import 'package:uniuti/monitoria/presentation/monitorias.dart';
import '../../contato/presentation/celular_card.dart';
import '../../shared/presentation/selector_field.dart';

import 'package:uniuti_core/uniuti_core.dart';
import 'package:uniuti_styles/uniuti_styles.dart';
import '../application/form_monitoria_store.dart';

class FormMonitoriaScreen extends StatefulWidget {
  const FormMonitoriaScreen({Key? key, required this.controller, this.tipo})
      : super(key: key);
  final FormMonitoriaStore controller;
  final TipoSolicitacao? tipo;
  static const String route = '/formMonitoria';

  @override
  State<FormMonitoriaScreen> createState() => _FormMonitoriaScreenState();
}

class _FormMonitoriaScreenState extends State<FormMonitoriaScreen> {
  final _form = GlobalKey<FormState>();

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
                initialValue: widget.controller.monitoria.id.isEmpty
                    ? null
                    : widget.controller.monitoria.titulo,
                save: widget.controller.monitoria.updateTitulo,
              ),
              UniUtiDescricaoInput(
                placeholder: 'Descricao',
                initialValue: widget.controller.monitoria.id.isEmpty
                    ? null
                    : widget.controller.monitoria.descricao,
                valid: widget.controller.monitoria.validaDescricao,
                save: widget.controller.monitoria.updateDescricao,
              ),
              SelectorButton(
                key: const ValueKey('MonitDiscip'),
                futureElements: widget.controller.getDisciplinas(),
                label: 'Disciplina',
                nullMessage: 'Favor selecionar uma Disciplina!',
                onSaved: widget.controller.monitoria.updateDisciplina,
                initialValue: widget.controller.monitoria.id.isEmpty
                    ? null
                    : widget.controller.monitoria.disciplina,
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: ElevatedButton(
                  onPressed: () {
                    switch (widget.tipo) {
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

  Future<void> dialogoPublicar(BuildContext context) async {
    final th = Theme.of(context).textTheme;
    if (!_form.currentState!.validate()) {
      return;
    }
    _form.currentState!.save();
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(20, 35, 20, 15),
          child: Text('Publicando ...', style: th.headlineMedium),
        );
      },
    );
    final state = await widget.controller.publicarMonitoria(widget.tipo);
    if (mounted) Navigator.of(context).pop();
    await showModalBottomSheet(
      context: context,
      builder: (context) {
        late final String child;
        child = (state is FailPublicarState) ? state.message : 'Publicado';
        return Padding(
          padding: const EdgeInsets.fromLTRB(20, 35, 20, 15),
          child: Text(child, style: th.headlineMedium),
        );
      },
    );
    if (!mounted) return;
    Navigator.of(context).pop();
    Navigator.of(context).pushReplacementNamed(MonitoriasScreen.route);
  }

  void dialogoContatar(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          margin: const EdgeInsets.fromLTRB(20, 35, 20, 15),
          child: CelularCard(widget.controller.monitoria.solicitante!.celular!),
        );
      },
    );
  }
}
