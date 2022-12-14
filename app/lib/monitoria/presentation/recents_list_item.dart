import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uniuti/monitoria/presentation/form_monitoria.dart';
import 'package:uniuti_core/uniuti_core.dart';
import 'package:uniuti_styles/uniuti_styles.dart';

import 'monitoria.dart';

class RecentsListItem extends StatelessWidget {
  const RecentsListItem({Key? key, required this.model}) : super(key: key);
  final Monitoria model;
  @override
  Widget build(BuildContext context) {
    void abrirMonitoria() {
      final aluno = context.read<Aluno>();
      late String route;
      if (model.solicitante == aluno) {
        route = FormMonitoriaScreen.route;
      } else {
        route = MonitoriaScreen.route;
      }
      Navigator.of(context).pushNamed(route, arguments: model);
    }

    final th = Theme.of(context).textTheme;
    return Material(
      child: InkWell(
        onTap: abrirMonitoria,
        child: Container(
          margin: const EdgeInsets.fromLTRB(33, 10, 16, 10),
          child: Row(
            children: [
              Container(
                width: 106,
                decoration: BoxDecoration(
                  color: Colors.grey.shade400,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      model.titulo,
                      maxLines: 1,
                      overflow: TextOverflow.fade,
                      style: th.titleMedium,
                    ),
                    Text(
                      'Anunciado em: ${model.criadoEm}',
                      style: th.titleSmall,
                      maxLines: 1,
                      overflow: TextOverflow.fade,
                    ),
                    Text(
                      model.descricao,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                    Divider(
                      thickness: 2,
                      color: UniUtiColors.green,
                      height: 5,
                      endIndent: 12,
                      indent: 12,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
