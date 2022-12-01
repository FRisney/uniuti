import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uniuti_core/uniuti_core.dart';

import '../aluno/presentation/dashboard.dart';
import '../aluno/application/dashboard_store.dart';
import '../auth/presentation/login.dart';
import '../auth/presentation/register.dart';
import '../auth/application/login_store.dart';
import '../auth/application/register_store.dart';
import '../auth/presentation/signin.dart';
import '../auth/presentation/splash.dart';
import '../monitoria/application/monitoria_store.dart';
import '../monitoria/presentation/monitorias.dart';
import '../monitoria/application/monitorias_store.dart';
import '../monitoria/presentation/form_monitoria.dart';
import '../monitoria/application/form_monitoria_store.dart';
import '../monitoria/presentation/monitoria.dart';

class RouteGenerator {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    late WidgetBuilder builder;
    switch (settings.name) {
      case SplashScreen.route:
        builder = ((context) {
          return const SplashScreen();
        });
        break;
      case SigninScreen.route:
        builder = ((context) {
          return const SigninScreen();
        });
        break;
      case RegisterScreen.route:
        builder = (context) => RegisterScreen(
              controller: RegisterStore(context.read()),
              aluno: context.read(),
            );
        break;
      case LoginScreen.route:
        builder = (context) => LoginScreen(
              user: context.read(),
              store: LoginStore(context.read()),
            );
        break;
      case MonitoriasScreen.route:
        builder = (context) =>
            MonitoriasScreen(controller: MonitoriasStore(context.read()));
        break;
      case MonitoriaScreen.route:
        if (settings.arguments.runtimeType != Monitoria) return null;
        builder = (context) => MonitoriaScreen(
              monitoria: settings.arguments! as Monitoria,
              store: MonitoriaStore(context.read()),
            );
        break;
      case DashboardScreen.route:
        builder = (context) => DashboardScreen(
            controller: DashboardStore(), aluno: context.read());
        break;
      case FormMonitoriaScreen.route:
        builder = (context) {
          if (settings.arguments is TipoSolicitacao) {
            return FormMonitoriaScreen(
              controller: FormMonitoriaStore(context.read(), context.read()),
              tipo: settings.arguments as TipoSolicitacao,
            );
          } else {
            return FormMonitoriaScreen(
              controller: FormMonitoriaStore(context.read(), context.read(),
                  settings.arguments as Monitoria),
            );
          }
        };
        break;
      default:
        return null;
    }
    return MaterialPageRoute(builder: builder);
  }

  static Route<dynamic>? unknownRoute(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(title: const Text('Error')),
        body: const Center(
          child: Text('Pagina nao encontrada'),
        ),
      ),
    );
  }
}
