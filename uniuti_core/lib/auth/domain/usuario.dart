part of '../../uniuti_core.dart';

class Usuario {
  String id;
  String login;
  String senha;
  String token;
  Usuario({
    required this.id,
    required this.login,
    required this.senha,
    required this.token,
  });

  String? validateSenha(senha) {
    return (senha == null || senha.isEmpty || senha.length < 9)
        ? 'Senha Inválida'
        : null;
  }

  void updateSenha(senha) => this.senha = senha ?? '';

  String? validateLogin(login) =>
      (login == null || login.isEmpty) ? 'Login Inválido' : null;

  void updateLogin(login) => this.login = login ?? '';
}
