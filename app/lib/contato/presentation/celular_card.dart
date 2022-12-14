import 'dart:developer' as dev;
import 'package:flutter/material.dart';
import 'package:uniuti_core/uniuti_core.dart';
import 'package:url_launcher/url_launcher.dart';

class CelularCard extends StatelessWidget {
  const CelularCard(this.cel, {Key? key}) : super(key: key);

  final Celular cel;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () async => Navigator.of(context).pop(
          await launchUrl(
            Uri.https('wa.me', '/55${cel.contato}'),
            mode: LaunchMode.externalApplication,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 30),
          child: Row(children: [
            const Icon(
              Icons.contact_phone,
              size: 48,
            ),
            Expanded(
              child: Text(
                cel.toString(),
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
