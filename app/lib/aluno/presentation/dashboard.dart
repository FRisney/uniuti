import 'package:flutter/material.dart';
import 'package:uniuti_core/uniuti_core.dart';
import 'package:uniuti_styles/uniuti_styles.dart';
import '../../monitoria/presentation/recents_list_item.dart';
import '../application/dashboard_store.dart';
import 'drawer.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen(
      {Key? key, required this.controller, required this.aluno})
      : super(key: key);
  final Aluno aluno;

  final DashboardStore controller;

  static const String route = '/dashboard';

  @override
  Widget build(BuildContext context) {
    final th = Theme.of(context).textTheme;
    var menuItems = [
      const SizedBox(width: 30),
      FixedMenuItem(
        text: 'Monitorias',
        icon: Icons.menu_book_sharp,
        onTap: () => Navigator.of(context).pushNamed('/monitorias'),
      ),
      const SizedBox(width: 30),
    ];
    return WillPopScope(
      onWillPop: () async =>
          (await showModalBottomSheet<bool>(
            context: context,
            builder: (context) => Padding(
              // constraints: const BoxConstraints(maxHeight: 300),
              padding: const EdgeInsets.fromLTRB(20, 35, 20, 15),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Realmente deseja sair?',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 18),
                  Row(
                    // mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: UniUtiSecondaryButton(
                          onTap: () => Navigator.of(context).pop(true),
                          title: 'Sair',
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: UniUtiPrimaryButton(
                          onTap: () => Navigator.of(context).pop(false),
                          title: 'Ficar',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )) ??
          false,
      child: Scaffold(
        drawer: const DashboardDrawer(),
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
                    style: th.bodyLarge!.copyWith(color: Colors.white),
                    children: [
                      const TextSpan(text: 'Bem-vindo, '),
                      TextSpan(
                          text: aluno.nome,
                          style: th.bodyLarge!.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
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
                      Text(aluno.instituicao?.nome ?? 'Sem Instituição',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(color: Colors.white)),
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
                        style: th.headlineSmall,
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(children: menuItems),
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
                    style: th.headlineSmall,
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
      ),
    );
  }
}
