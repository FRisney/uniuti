import 'dart:developer' as dev;
import 'package:flutter/material.dart';
import 'package:uniuti_core/uniuti_core.dart';
import 'package:uniuti_styles/uniuti_styles.dart';

class SelectorButton<T> extends StatelessWidget {
  const SelectorButton({
    Key? key,
    required this.futureElements,
    required this.label,
    required this.nullMessage,
    required this.onSaved,
    this.initialValue,
  }) : super(key: key);
  final String label;
  final String nullMessage;
  final Future<List<T>> futureElements;
  final void Function(T?) onSaved;
  final T? initialValue;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<T>>(
      future: futureElements,
      builder: (context, snapshot) {
        var itemCount = 0;
        if (snapshot.hasData) {
          var items = snapshot.data!;
          if (initialValue != null) {
            final removed = items.remove(initialValue);
            dev.log(removed.toString(), name: 'Removido dupicado');
          }
          itemCount = items.length;
          return Container(
            margin: const EdgeInsets.only(bottom: 25),
            child: DropdownButtonFormField<T>(
              decoration: uniUtiInputDecoration(label),
              value: initialValue,
              items: List.generate(
                itemCount,
                (index) => DropdownMenuItem(
                  value: items[index],
                  child: Text(
                    items[index].toString(),
                    overflow: TextOverflow.fade,
                    maxLines: 1,
                  ),
                ),
              ),
              onSaved: onSaved,
              onChanged: (sel) => dev.log(sel.toString()),
              validator: (sel) => sel == null ? nullMessage : null,
            ),
          );
        } else if (snapshot.hasError) {
          return LoadErrorField(snapshot.error as UniUtiException);
        }
        return const LoadingField();
      },
    );
  }
}

class _FakeField extends StatelessWidget {
  const _FakeField({Key? key, required this.child}) : super(key: key);
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      constraints: const BoxConstraints(maxHeight: 60),
      alignment: Alignment.center,
      margin: const EdgeInsets.only(bottom: 25),
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: child,
    );
  }
}

class LoadErrorField extends StatelessWidget {
  const LoadErrorField(this.error, {Key? key}) : super(key: key);
  final UniUtiException error;
  @override
  Widget build(BuildContext context) {
    return _FakeField(child: Text(error.message));
  }
}

class LoadingField extends StatelessWidget {
  const LoadingField({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const _FakeField(child: LinearProgressIndicator(minHeight: 15));
  }
}
