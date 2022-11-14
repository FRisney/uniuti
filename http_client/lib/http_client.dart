library http_client;

import 'dart:convert';
import 'dart:io';
import 'dart:developer' as dev;

import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:http_interceptor/http_interceptor.dart';
import 'package:uniuti_core/uniuti_core.dart';

part 'exceptions.dart';
part 'response.dart';
part 'remote_client.dart';
part 'remote_client_impl.dart';
part 'http_client_impl.dart';
part 'aluno/data/aluno_repository.dart';
part 'auth/data/usuario_repository.dart';
part 'curso/data/curso_repository.dart';
part 'disciplina/data/disciplina_repository.dart';
part 'instituicao/data/instituicao_repository.dart';
part 'monitoria/data/monitoria_repository.dart';
