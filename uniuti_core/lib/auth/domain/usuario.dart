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

  String? validateLogin(String? login) {
    var rgx = RegExp(r'[a-zA-Z0-9.]+@[a-z]+\.[a-z.]');
    if (login == null || login.isEmpty || !(rgx.hasMatch(login))) {
      return 'Email inválido';
    }
    return null;
  }

  String? validateLoginConfirmation(String? confirm) {
    var ret = validateLogin(confirm);
    if (ret == null && confirm!.trim() != login) {
      ret = 'Email não corresponde';
    }
    return ret;
  }

  void updateLogin(login) => this.login = login ?? '';
}
