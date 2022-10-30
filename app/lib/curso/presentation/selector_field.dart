import 'dart:developer' as dev;
import 'package:flutter/material.dart';
import 'package:http_client/http_client.dart';
import 'package:provider/provider.dart';
import 'package:uniuti_core/uniuti_core.dart';
import 'package:uniuti_styles/uniuti_styles.dart';

class CursoSelectorButton extends StatefulWidget {
  const CursoSelectorButton({Key? key, required this.aluno}) : super(key: key);
  final Aluno aluno;
  @override
  _CursoSelectorButtonState createState() => _CursoSelectorButtonState();
}

class _CursoSelectorButtonState extends State<CursoSelectorButton> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Curso>>(
      future: CursoRemoteRepository(context.read()).getAll(),
      builder: (context, snapshot) {
        var items = 0;
        if (snapshot.hasData) {
          items = snapshot.data!.length;
          return Container(
            margin: const EdgeInsets.only(bottom: 25),
            child: DropdownButtonFormField<Curso>(
              decoration: uniUtiInputDecoration('Cursos'),
              items: List.generate(
                items,
                (index) => DropdownMenuItem(
                  value: snapshot.data![index],
                  child: Text(snapshot.data![index].nome),
                ),
              ),
              onSaved: (newValue) => widget.aluno.curso = newValue!,
              onChanged: (sel) => dev.log(sel.toString()),
            ),
          );
        } else if (snapshot.hasError) {
          return CursosLoadError(snapshot.error as CursoException);
        }
        return const LoadingCursos();
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

class CursosLoadError extends StatelessWidget {
  const CursosLoadError(this.error, {Key? key}) : super(key: key);
  final CursoException error;
  @override
  Widget build(BuildContext context) {
    return _FakeField(child: Text(error.message));
  }
}

class LoadingCursos extends StatelessWidget {
  const LoadingCursos({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return _FakeField(child: const LinearProgressIndicator(minHeight: 15));
  }
}
