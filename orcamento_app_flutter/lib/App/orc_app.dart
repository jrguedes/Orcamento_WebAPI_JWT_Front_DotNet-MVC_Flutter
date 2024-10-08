import 'package:flutter/material.dart';
import 'package:orcamento_app_flutter/App/controllers/bottom_bar/bottom_bar_controller.dart';
import 'package:provider/provider.dart';
import 'controllers/account/account_controller.dart';
import 'controllers/home/home_controller.dart';
import 'controllers/item_orcamento/item_orcamento_controller.dart';
import 'controllers/orcamento/orcamento_controller.dart';
import 'data/enums/theme_type.dart';
import 'pages/main_page.dart';
import 'pages/splash/splash_page.dart';
import 'services/api/account_api_service.dart';
import 'services/api/item_orcamento_api_service.dart';
import 'services/api/orcamento_api_service.dart';
import 'services/service_manager.dart';
import 'services/themes/theme_service.dart';
import 'stores/itens_orcamento_store.dart';
import 'stores/orcamentos_store.dart';
import 'stores/signin_store.dart';

class OrcApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          Provider<AccountApiService>(create: (_) => AccountApiService()),
          Provider<OrcamentoApiService>(create: (_) => OrcamentoApiService()),
          Provider<ItemOrcamentoApiService>(create: (_) => ItemOrcamentoApiService()),
          ChangeNotifierProvider<PageController>(create: (_) => PageController(initialPage: 0)),
          Provider<HomeController>(create: (_) => HomeController()),
          Provider<BottomBarController>(
              create: (context) => BottomBarController(context.read<PageController>().animateToPage)),
          ChangeNotifierProvider(create: (context) => OrcamentosStore(context.read())),
          ChangeNotifierProvider(create: (context) => ItensOrcamentoStore(context.read())),
          ChangeNotifierProvider(create: (context) => SignInStore(context.read())),
          Provider<OrcamentoController>(create: (context) => OrcamentoController(context.read())),
          Provider<AccountController>(create: (context) => AccountController(context.read(), context.read())),
          Provider<ItemOrcamentoController>(create: (context) => ItemOrcamentoController(context.read())),
          Provider<ServiceManager>(create: (context) => ServiceManager(context.read())),
        ],
        builder: (context, child) {
          return FutureBuilder(
              future: context.read<ServiceManager>().initializeServices(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const SplashPage(title: 'OrçApp');
                }
                return MaterialApp(
                  debugShowCheckedModeBanner: false,
                  title: 'OrçApp',
                  theme: ThemeService.getTheme(ThemeType.defaultTheme),
                  initialRoute: '/',
                  routes: {
                    '/': (_) => MainPage(title: 'OrçApp'),
                  },
                );
              });
        });
  }
}
