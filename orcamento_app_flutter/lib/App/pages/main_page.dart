import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:orcamento_app_flutter/App/controllers/bottom_bar/bottom_bar_controller.dart';
import 'package:orcamento_app_flutter/App/data/constants/pages.dart';
import 'package:orcamento_app_flutter/App/models/token_model.dart';
import 'package:orcamento_app_flutter/App/pages/inner_pages/cadastro_orcamento.dart';
import 'package:orcamento_app_flutter/App/pages/inner_pages/expired_login_page.dart';
import 'package:orcamento_app_flutter/App/pages/inner_pages/orcamentos_page.dart';
import 'package:orcamento_app_flutter/App/states/generic_states/object_state.dart';
import 'package:orcamento_app_flutter/App/stores/signin_store.dart';
import 'package:provider/provider.dart';

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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _pageController = context.read<PageController>();
    _signInStore = context.read();
    _bottomBar = context.read();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
          return ValueListenableBuilder(
              valueListenable: _signInStore,
              builder: (context, tokenInfoState, child) {
                return _buildPageView(tokenInfoState);
              });
        }),
        bottomNavigationBar: ValueListenableBuilder(
            valueListenable: _signInStore,
            builder: (context, tokenInfoState, child) {
              return _buildConvexAppBar(context, HOME_PAGE, tokenInfoState);
            }));
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

    if (state is InitialObjectState) {
      return PageView(
        pageSnapping: false,
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          HomePage(title: 'OrçApp', userLogged: false),
        ],
      );
    }

    if (state is UnauthorizedObjectState<TokenModel?>) {
      return PageView(
        pageSnapping: false,
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          HomePage(title: 'OrçApp', userLogged: false, erroMessage: state.message),
        ],
      );
    }

    if (state is ErrorObjectState<TokenModel?>) {
      return PageView(
        pageSnapping: false,
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          HomePage(title: 'OrçApp', userLogged: false, erroMessage: state.message),
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
    if (state is LoadingObjectState<TokenModel?> ||
        state is InitialObjectState<TokenModel?> ||
        state is UnauthorizedObjectState<TokenModel?>) {
      return ConvexAppBar(
        key: _bottomBar.appBarKey,
        style: TabStyle.fixedCircle,
        backgroundColor: Theme.of(context).secondaryHeaderColor,
        items: const [
          TabItem(icon: FontAwesomeIcons.houseChimney, title: 'Home'),
        ],
        initialActiveIndex: index,
        onTap: _bottomBar.convexAppBarTap,
      );
    }
    if (state is SuccessObjectState<TokenModel?> && state.value != null) {
      return ConvexAppBar(
        key: _bottomBar.appBarKey,
        backgroundColor: Theme.of(context).secondaryHeaderColor,
        items: const [
          TabItem(icon: FontAwesomeIcons.houseChimney, title: 'Home'),
          TabItem(icon: FontAwesomeIcons.accusoft, title: 'Hi'),
          TabItem(icon: FontAwesomeIcons.moneyCheckDollar, title: 'Orçamentos'),
          TabItem(icon: FontAwesomeIcons.fileCirclePlus, title: 'Add'),
        ],
        initialActiveIndex: index,
        onTap: _bottomBar.convexAppBarTap,
      );
    }

    return ConvexAppBar(
      key: _bottomBar.appBarKey,
      style: TabStyle.fixedCircle,
      backgroundColor: Theme.of(context).secondaryHeaderColor,
      items: const [
        TabItem(icon: FontAwesomeIcons.houseChimney, title: 'Home'),
      ],
      initialActiveIndex: index,
      onTap: _bottomBar.convexAppBarTap,
    );
  }
}
