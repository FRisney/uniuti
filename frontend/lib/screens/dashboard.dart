import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:uniuti/models/instituicao.dart';
import '../components/components.dart';
import '../components/recents_list_item.dart';
import '../models/aluno.dart';
import '../stores/dashboard_store.dart';
import '../styles.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen(
      {Key? key, required this.controller, required this.aluno})
      : super(key: key);
  final Aluno aluno;

  final DashboardStore controller;

  @override
  Widget build(BuildContext context) {
    final _th = Theme.of(context).textTheme;
    var _menuItems = [
      const SizedBox(width: 30),
      FixedMenuItem(
        text: 'Monitorias',
        icon: Icons.menu_book_sharp,
        onTap: () => Navigator.of(context).pushNamed('/monitorias'),
      ),
      const SizedBox(width: 30),
    ];
    return Scaffold(
      drawer: Drawer(
        child: SingleChildScrollView(
          child: Container(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height,
            ),
            decoration: BoxDecoration(
              gradient: UniUtiBgGradient3(),
            ),
            child: Column(
              children: [
                DrawerHeader(
                  child: SvgPicture.asset('assets/logo.svg'),
                ),
                Expanded(child: Container(child: const Text('LOL'))),
                Container(
                  child: Column(
                    children: const [
                      Text('Sair'),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      body: CustomScrollView(
        primary: true,
        slivers: [
          SliverAppBar(
            backgroundColor: UniUtiColors.purple.shade900,
            expandedHeight: 235,
            floating: true,
            snap: true,
            pinned: true,
            iconTheme: Theme.of(context)
                .appBarTheme
                .iconTheme!
                .copyWith(color: Colors.white),
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.pin,
              title: RichText(
                text: TextSpan(
                  style: _th.bodyLarge!.copyWith(color: Colors.white),
                  children: [
                    const TextSpan(text: 'Bem-vindo, '),
                    TextSpan(
                        text: aluno.nome,
                        style: _th.bodyLarge!.copyWith(
                            color: Colors.white, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              background: Container(
                padding: const EdgeInsets.only(top: 50),
                decoration: BoxDecoration(gradient: UniUtiBgGradient2()),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(43),
                        color: Colors.white,
                      ),
                      height: 85,
                      width: 85,
                      child: const Center(child: Text('FOTO')),
                    ),
                    const SizedBox(height: 8),
                    Text(aluno.nome,
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .copyWith(color: Colors.white)),
                    FutureBuilder<Instituicao?>(
                      future: controller.getInstituicaoDoAluno(aluno),
                      builder: (context, snap) {
                        var nome = 'Sem Instituicao';
                        if (snap.connectionState == ConnectionState.done &&
                            snap.hasData) {
                          nome = snap.data!.nome;
                        }
                        return Text(nome,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(color: Colors.white));
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.only(top: 30, bottom: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.only(left: 40, bottom: 10),
                    child: Text(
                      'Para onde deseja ir?',
                      style: _th.headlineSmall,
                    ),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(children: _menuItems),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.only(top: 30, bottom: 25),
              child: Container(
                padding: const EdgeInsets.only(left: 40, bottom: 10),
                child: Text(
                  'Ultimos itens vistos',
                  style: _th.headlineSmall,
                ),
              ),
            ),
          ),
          FutureBuilder<List<RecentsListItem>>(
            future: controller.getRecentes(),
            builder: (context, snap) {
              if (snap.connectionState == ConnectionState.done) {
                if (snap.hasData && snap.data!.isNotEmpty) {
                  return SliverFixedExtentList(
                    itemExtent: 105,
                    delegate: SliverChildListDelegate(snap.data!),
                  );
                }
                return const SliverToBoxAdapter(
                    child: Center(child: Text('Sem Monitorias')));
              }
              return const SliverToBoxAdapter(
                  child: Center(child: CircularProgressIndicator()));
            },
          ),
        ],
      ),
    );
  }
}
