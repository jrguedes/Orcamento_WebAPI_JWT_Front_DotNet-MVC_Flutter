import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:orcamento_app_flutter/App/models/token_model.dart';
import 'package:orcamento_app_flutter/App/pages/inner_pages/orcamentos_page.dart';
import 'package:orcamento_app_flutter/App/states/generic_states/object_state.dart';

import '../controllers/account/account_controller.dart';
import '../controllers/home/home_controller.dart';
import '../services/service_manager.dart';
import 'inner_pages/home_page.dart';

class MainPage extends StatefulWidget {
  MainPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final PageController _pageController = GetIt.I.get<ServiceManager>().pageController;
  final HomeController _homeController = GetIt.I.get<ServiceManager>().homeController;
  final AccountController _accountController = GetIt.I.get<ServiceManager>().accountController;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
        return PageView(
          pageSnapping: false,
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            HomePage(title: 'Home'),
            const Center(child: Text('Tela 2')),
            //const Center(child: Text('Tela 3')),
            OrcamentosPage(),
            const Center(child: Text('Tela 4')),
          ],
        );
      }),
      bottomNavigationBar: ValueListenableBuilder<int>(
        valueListenable: _homeController.indexPageState,
        builder: (context, index, child) {
          return ValueListenableBuilder(
              valueListenable: _accountController.signInState,
              builder: (context, tokenInfo, child) {
                return _buildConvexAppBar(context, index, tokenInfo);
              });
        },
      ),
    );
  }

  ConvexAppBar _buildConvexAppBar(BuildContext context, int index, ObjectState<TokenModel?> state) {
    if (state is LoadingObjectState) {
      return ConvexAppBar(
        backgroundColor: Theme.of(context).secondaryHeaderColor,
        items: [
          TabItem(icon: Icons.home, title: 'Home'),
          TabItem(icon: Icons.map, title: 'Orçamentos'),
          TabItem(icon: Icons.message, title: 'Lista'),
          TabItem(icon: Icons.add, title: 'Add'),
        ],
        initialActiveIndex: index, //optional, default as 0
        onTap: _homeController.convexAppBarTap,
      );
    }

    return ConvexAppBar(
      backgroundColor: Theme.of(context).secondaryHeaderColor,
      items: [
        TabItem(icon: Icons.home, title: 'Home'),
        TabItem(icon: Icons.map, title: 'Orçamentos'),
        TabItem(icon: Icons.message, title: 'Lista'),
        TabItem(icon: Icons.add, title: 'Add'),
      ],
      initialActiveIndex: index, //optional, default as 0
      onTap: _homeController.convexAppBarTap,
    );
  }
}
