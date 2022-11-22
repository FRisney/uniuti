import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http_client/http_client.dart';
import 'package:uniuti_core/uniuti_core.dart';
import 'package:uniuti_styles/uniuti_styles.dart';

import 'routing/route_generator.dart';
import 'shared/presentation/transicao.dart';

Future<void> main() async {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final RemoteClientImpl client;
  late final Aluno aluno;

  @override
  void initState() {
    super.initState();
    client = RemoteClientImpl(host: 'uniuti.azurewebsites.net/api');
    aluno = Aluno.empty();
  }

  @override
  void dispose() {
    client.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<Aluno>(create: (_) => aluno),
        Provider<Usuario>(create: (_) => aluno.usuario!),
        Provider<RemoteClient>(create: (_) => client),
        Provider<UsuarioRepository>(
          create: (_) {
            final repo = UsuarioRemoteRepository(client);
            client.addInteceptor(
                AuthInterceptor(getToken: () async => aluno.usuario!.token));
            client.setRetryPolicy(
                RetryPolicyImpl(() async => repo.performLogin(aluno)));
            return repo;
          },
        )
      ],
      child: MaterialApp(
        title: 'UniUti',
        theme: uniUtiThemeData.copyWith(
          pageTransitionsTheme: PageTransitionsTheme(
            builders: Map<TargetPlatform, PageTransitionsBuilder>.fromIterable(
              TargetPlatform.values,
              value: (dynamic _) => UniUtiSlideTransition(),
            ),
          ),
        ),
        scrollBehavior: const CupertinoScrollBehavior(),
        onGenerateRoute: RouteGenerator.generateRoute,
        onUnknownRoute: RouteGenerator.unknownRoute,
      ),
    );
  }
}
