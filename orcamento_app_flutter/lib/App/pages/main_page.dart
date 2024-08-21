import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:orcamento_app_flutter/App/controllers/bottom_bar/bottom_bar_controller.dart';
import 'package:orcamento_app_flutter/App/models/token_model.dart';
import 'package:orcamento_app_flutter/App/pages/inner_pages/cadastro_orcamento.dart';
import 'package:orcamento_app_flutter/App/pages/inner_pages/orcamentos_page.dart';
import 'package:orcamento_app_flutter/App/states/generic_states/object_state.dart';
import 'package:orcamento_app_flutter/App/stores/signin_store.dart';
import 'package:provider/provider.dart';

import '../controllers/orcamento/orcamento_controller.dart';
import 'inner_pages/home_page.dart';

class MainPage extends StatefulWidget {
  MainPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late final PageController _pageController;
  late final SignInStore _signInStore;
  late final BottomBarController _bottomBar;

  //REFATORAR
  late final OrcamentoController _orcamentoController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _pageController = context.read<PageController>();
    _signInStore = context.read();
    _bottomBar = context.read();
    _orcamentoController = context.read();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
        return ValueListenableBuilder(
            valueListenable: _signInStore,
            builder: (context, tokenInfoState, child) {
              return _buildPageView(tokenInfoState);
            });
      }),
      bottomNavigationBar: ValueListenableBuilder<int>(
        valueListenable: _bottomBar.indexPageState,
        builder: (context, index, child) {
          return ValueListenableBuilder(
              valueListenable: _signInStore,
              builder: (context, tokenInfoState, child) {
                return _buildConvexAppBar(context, index, tokenInfoState);
              });
        },
      ),
    );
  }

  PageView _buildPageView(ObjectState<TokenModel?> state) {
    if (state is SuccessObjectState<TokenModel?> && state.value != null) {
      var jwtTokenInfo = state.value;

      return PageView(
        pageSnapping: false,
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          HomePage(title: 'OrçApp', userLogged: true, jwtTokenInfo: jwtTokenInfo),
          _buildTela2(),
          const OrcamentosPage(),
          const CadastroOrcamento(),
        ],
      );
    }

    if (state is ErrorObjectState) {
      return PageView(
        pageSnapping: false,
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          HomePage(title: 'OrçApp', userLogged: false, erroMessage: (state as ErrorObjectState).message),
        ],
      );
    }

    return PageView(
      pageSnapping: false,
      controller: _pageController,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        HomePage(title: 'OrçApp', userLogged: false),
      ],
    );
  }

  Widget _buildTela2() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const FaIcon(
          FontAwesomeIcons.circleDollarToSlot,
          color: Colors.amber,
          size: 350,
        ),
        Title(
          color: Colors.amber,
          title: widget.title,
          child: Text(
            widget.title,
            style: const TextStyle(
              color: Colors.amber,
              fontSize: 80,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }

  ConvexAppBar _buildConvexAppBar(BuildContext context, int index, state) {
    if (state is LoadingObjectState) {
      return ConvexAppBar(
        style: TabStyle.fixedCircle,
        backgroundColor: Theme.of(context).secondaryHeaderColor,
        items: const [
          TabItem(icon: Icons.home, title: 'Home'),
        ],
        initialActiveIndex: 0,
        onTap: _bottomBar.convexAppBarTap,
      );
    }
    if (state is SuccessObjectState<TokenModel?> && state.value != null) {
      return ConvexAppBar(
        backgroundColor: Theme.of(context).secondaryHeaderColor,
        items: const [
          TabItem(icon: Icons.home, title: 'Home'),
          TabItem(icon: Icons.map, title: 'Orçamentos'),
          TabItem(icon: Icons.message, title: 'Lista'),
          TabItem(icon: Icons.add, title: 'Add'),
        ],
        initialActiveIndex: index,
        onTap: _bottomBar.convexAppBarTap,
      );
    }

    return ConvexAppBar(
      style: TabStyle.fixedCircle,
      backgroundColor: Theme.of(context).secondaryHeaderColor,
      items: const [
        TabItem(icon: Icons.home, title: 'Home'),
      ],
      initialActiveIndex: 0,
      onTap: _bottomBar.convexAppBarTap,
    );
  }
}
