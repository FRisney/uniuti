import 'package:flutter/material.dart';
import 'package:uniuti_core/uniuti_core.dart';
import 'package:uniuti_styles/uniuti_styles.dart';

import '../../contato/presentation/celular_card.dart';
import '../application/monitoria_store.dart';

class MonitoriaScreen extends StatelessWidget {
  const MonitoriaScreen(
      {Key? key, required this.monitoria, required this.store})
      : super(key: key);
  static const String route = '/monitoria';
  final Monitoria monitoria;
  final MonitoriaStore store;
  @override
  Widget build(BuildContext context) {
    final th = Theme.of(context).textTheme;
    String nome = '';
    if (monitoria.solicitante != null) {
      nome = monitoria.solicitante!.nome;
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(35),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  monitoria.titulo,
                  style: th.headlineLarge,
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  'Anunciado em: ${monitoria.criadoEm}',
                  style: th.titleSmall,
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                margin: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: UniUtiColors.purple.withOpacity(0.22),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  monitoria.descricao,
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  monitoria.disciplina?.nome ?? 'Sem Disciplina',
                  style: th.titleMedium,
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 30,
                      height: 30,
                      margin: const EdgeInsets.only(right: 15),
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    Text(nome),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: ElevatedButton(
                  onPressed: () => dialogoContatar(context),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: Text(
                      'Contatar',
                      style: th.titleLarge!.copyWith(color: Colors.white),
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

  Future<void> dialogoContatar(BuildContext context) async {
    if (monitoria.solicitante == null) return;
    if (monitoria.solicitante!.celular == null) return;
    final contacted = await showModalBottomSheet<bool?>(
      context: context,
      builder: (context) {
        return Container(
          margin: const EdgeInsets.fromLTRB(20, 35, 20, 15),
          child: CelularCard(monitoria.solicitante!.celular!),
        );
      },
    );
    if (contacted != null && contacted) {
      store.performUpdate(monitoria);
    }
  }
}
