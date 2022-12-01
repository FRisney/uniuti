import 'package:flutter/material.dart';
import 'package:uniuti_core/uniuti_core.dart';

import 'package:uniuti_styles/uniuti_styles.dart';
import '../../shared/presentation/selector_field.dart';
import '../application/register_store.dart';

class RegisterScreen extends StatefulWidget {
  static const String route = '/register';

  const RegisterScreen(
      {Key? key, required this.controller, required this.aluno})
      : super(key: key);
  final RegisterStore controller;
  final Aluno aluno;
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  var _autoValidMode = AutovalidateMode.disabled;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(gradient: UniUtiBgGradient()),
        child: Form(
          autovalidateMode: _autoValidMode,
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(35, 125, 35, 80),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const UniUtiLogo(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  margin: const EdgeInsets.only(bottom: 40),
                  child: Text(
                    'Bora fazer teu registro? Preencha os dados abaixo e faça parte da comunidade.',
                    style: uniUtiSloganTextStyle,
                  ),
                ),
                SelectorButton(
                  nullMessage: 'Favor selecionar um Curso',
                  label: 'Curso',
                  onSaved: widget.aluno.updateCurso,
                  futureElements: widget.controller.getAllCursos(),
                  key: ValueKey(widget.aluno.curso?.nome ?? 'Curso'),
                ),
                SelectorButton(
                  nullMessage: 'Favor selecionar uma Instituicao',
                  label: 'Instituicao',
                  onSaved: widget.aluno.updateInstituicao,
                  futureElements: widget.controller.getAllInstituicoes(),
                  key:
                      ValueKey(widget.aluno.instituicao?.nome ?? 'Instituicao'),
                ),
                UniUtiInput(
                  placeholder: 'Nome',
                  save: (str) => widget.aluno.nome = str ?? '',
                  valid: (text) => (text == null ||
                          text.isEmpty ||
                          (text.split(' ').length < 2))
                      ? 'Nome inválido'
                      : null,
                ),
                UniUtiInput(
                  placeholder: 'Telefone',
                  type: TextInputType.phone,
                  save: (str) => widget.aluno.celular!.contato = str ?? '',
                  valid: (text) {
                    var rgx = RegExp(r'.*\D+.*');
                    return (text == null ||
                            rgx.hasMatch(text) ||
                            text.length < 11)
                        ? 'Telefone inválido'
                        : null;
                  },
                ),
                UniUtiInput(
                  placeholder: 'Email',
                  type: TextInputType.emailAddress,
                  onChanged: widget.aluno.usuario!.updateLogin,
                  save: widget.aluno.usuario!.updateLogin,
                  valid: widget.aluno.usuario!.validateLogin,
                ),
                UniUtiInput(
                  placeholder: 'Confirme seu email',
                  type: TextInputType.emailAddress,
                  save: widget.aluno.usuario!.updateLogin,
                  valid: widget.aluno.usuario!.validateLoginConfirmation,
                ),
                UniUtiInput(
                  placeholder: 'Senha',
                  password: true,
                  onChanged: widget.aluno.usuario!.updateSenha,
                  save: widget.aluno.usuario!.updateSenha,
                  valid: widget.aluno.usuario!.validateSenha,
                ),
                UniUtiInput(
                  placeholder: 'Confirme sua Senha',
                  password: true,
                  last: true,
                  save: widget.aluno.usuario!.updateSenha,
                  valid: widget.aluno.usuario!.validateSenhaConfirmation,
                ),
                Container(
                  margin: const EdgeInsets.only(top: 15),
                  child: UniUtiPrimaryButton(
                    title: 'Entrar',
                    onTap: _validateForm,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _validateForm() async {
    if (!_formKey.currentState!.validate()) {
      setState(() {
        _autoValidMode = AutovalidateMode.onUserInteraction;
      });
      return;
    }
    _formKey.currentState!.save();
    showModalBottomSheet(
      context: context,
      builder: (context) => const Loader(),
    );
    final state = await widget.controller.register(widget.aluno);
    if (mounted) Navigator.of(context).pop();
    showModalBottomSheet(
      context: context,
      builder: (context) {
        switch (state.runtimeType) {
          case RegisterFail:
            return Fail(state as RegisterFail);
          default:
            return Success(state as RegisterSuccess);
        }
      },
    );
  }
}

class Success extends StatelessWidget {
  const Success(this.state, {Key? key}) : super(key: key);
  final RegisterSuccess state;

  @override
  Widget build(BuildContext context) {
    Future.delayed(
        const Duration(microseconds: 1500),
        () => Navigator.of(context)
            .pushNamedAndRemoveUntil('/login', (route) => false));
    return Center(
        child: Text(
      'Sucesso',
      style: Theme.of(context).textTheme.headlineSmall,
    ));
  }
}

class Fail extends StatelessWidget {
  const Fail(this.state, {Key? key}) : super(key: key);
  final RegisterFail state;

  @override
  Widget build(BuildContext context) => Center(child: Text(state.message));
}

class Loader extends StatelessWidget {
  const Loader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) =>
      const Center(child: CircularProgressIndicator());
}
