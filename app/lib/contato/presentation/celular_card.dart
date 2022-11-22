import 'dart:developer' as dev;
import 'package:flutter/material.dart';
import 'package:uniuti_core/uniuti_core.dart';

class CelularCard extends StatelessWidget {
  const CelularCard(this.cel, {Key? key}) : super(key: key);

  final Celular cel;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(vertical: 25, horizontal: 30),
        leading: const Icon(
          Icons.contact_phone,
          size: 48,
        ),
        title: Expanded(
          child: Text(
            cel.contato,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ),
        onTap: () => dev.log('LOL'),
      ),
    );
  }
}
