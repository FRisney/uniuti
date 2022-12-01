part of '../../uniuti_core.dart';

class Contato {
  String contato;
  Contato(this.contato);
}

class Email extends Contato {
  Email(super.contato);
}

class Celular extends Contato {
  Celular(super.contato);

  @override
  String toString() {
    final ddd = contato.substring(0, 2);
    final p1 = contato.substring(2, 7);
    final p2 = contato.substring(7);
    return '($ddd) $p1-$p2';
  }
}

class Telefone extends Contato {
  Telefone(super.contato);
}
