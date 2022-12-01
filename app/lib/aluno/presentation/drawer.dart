import 'package:flutter/material.dart';
import 'package:uniuti/aluno/presentation/dashboard.dart';
import 'package:uniuti_styles/uniuti_styles.dart';

class DashboardDrawer extends StatelessWidget {
  const DashboardDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        iconTheme: const IconThemeData(color: Colors.white),
        textTheme: const TextTheme(
          titleLarge: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      child: Drawer(
        child: SingleChildScrollView(
          child: Container(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height,
            ),
            decoration: BoxDecoration(
              gradient: UniUtiBgGradient3(),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const DrawerHeader(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Colors.white, width: 2),
                    ),
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: UniUtiLogo(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(33, 26, 15, 26),
                  child: Column(
                    children: const [
                      DrawerItem(
                        icon: Icon(Icons.person_outline_rounded),
                        title: 'Meu Perfil',
                        destination: DashboardScreen.route,
                      ),
                      DrawerItem(
                        icon: Icon(Icons.access_time),
                        title: 'Minhas Atividades',
                        destination: DashboardScreen.route,
                      ),
                      DrawerItem(
                        icon: Icon(Icons.add),
                        title: 'Itens Favoritos',
                        destination: DashboardScreen.route,
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.fromLTRB(33, 26, 15, 26),
                  decoration: const BoxDecoration(
                    border: Border(
                      top: BorderSide(color: Colors.white, width: 2),
                    ),
                  ),
                  child: const DrawerItem(
                      icon: Icon(Icons.exit_to_app),
                      title: 'Sair',
                      destination: '/'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DrawerItem extends StatelessWidget {
  const DrawerItem({
    super.key,
    required this.icon,
    required this.title,
    required this.destination,
  });
  final Widget icon;
  final String title;
  final String destination;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context).pushReplacementNamed(destination),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Row(children: [
          icon,
          const SizedBox(width: 20),
          Text(
            title,
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ]),
      ),
    );
  }
}
