import 'package:flutter/material.dart';
import 'package:uniuti_core/uniuti_core.dart';
import 'package:uniuti_styles/uniuti_styles.dart';
import '../application/login_store.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key, required this.user, required this.store})
      : super(key: key);
  final Aluno user;
  final LoginStore store;
  static const String route = '/login';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _senhaController = TextEditingController();
  var _autoValidateMode = AutovalidateMode.disabled;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        autovalidateMode: _autoValidateMode,
        child: Container(
          decoration: BoxDecoration(gradient: UniUtiBgGradient()),
          padding: const EdgeInsets.fromLTRB(35, 0, 35, 0),
          child: SingleChildScrollView(
            child: Container(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const UniUtiLogo(),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    child: Text(
                      'Sua vida acadêmica pode ser mais fácil.',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 148),
                  UniUtiInput(
                    placeholder: 'Login',
                    save: widget.user.usuario!.updateLogin,
                    valid: widget.user.usuario!.validateLogin,
                  ),
                  UniUtiInput(
                    placeholder: 'Senha',
                    password: true,
                    save: widget.user.usuario!.updateSenha,
                    valid: widget.user.usuario!.validateSenha,
                    last: true,
                  ),
                  UniUtiPrimaryButton(
                    title: 'Entrar',
                    onTap: _validateInputs,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _validateInputs() async {
    if (!_formKey.currentState!.validate()) {
      _senhaController.clear();
      setState(() {
        _autoValidateMode = AutovalidateMode.onUserInteraction;
      });
      return;
    }
    _formKey.currentState!.save();
    showModalBottomSheet(
      context: context,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );
    final state = await widget.store.login(widget.user);
    if (mounted) Navigator.of(context).pop();
    showModalBottomSheet(
      context: context,
      builder: (context) {
        switch (state.runtimeType) {
          case FailLoginState:
            return Center(child: Text((state as FailLoginState).data));
          default:
            Future.delayed(const Duration(milliseconds: 1500), () {
              Navigator.of(context).pushNamedAndRemoveUntil(
                '/dashboard',
                (route) => false,
              );
            });
            return const Center(child: Text('Sucesso!'));
        }
      },
    );
  }
}
