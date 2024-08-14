import 'package:flutter/material.dart';
import 'package:orcamento_app_flutter/App/controllers/bottom_bar/bottom_bar_controller.dart';
import 'controllers/account/account_controller.dart';
import 'controllers/home/home_controller.dart';
import 'controllers/orcamento/orcamento_controller.dart';
import 'services/api/orcamento_api_service.dart';
import 'services/service_manager.dart';
import 'services/themes/theme_service.dart';
import 'services/api/account_api_service.dart';
import 'services/api/item_orcamento_api_service.dart';
import 'package:provider/provider.dart';
import 'data/enums/theme_type.dart';
import 'pages/main_page.dart';
import 'pages/splash/splash_page.dart';
import 'stores/orcamentos_store.dart';
import 'stores/signin_store.dart';

class OrcApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<ServiceManager>(create: (context) => ServiceManager(context.read())),
        Provider<AccountAPIService>(create: (_) => AccountAPIService()),
        Provider<OrcamentoAPIService>(create: (_) => OrcamentoAPIService()),
        Provider<ItemOrcamentoApiService>(create: (_) => ItemOrcamentoApiService()),
        ChangeNotifierProvider(create: (context) => SignInStore(context.read())),
        ChangeNotifierProvider(create: (context) => OrcamentosStore(context.read())),
        Provider<AccountController>(create: (context) => AccountController(context.read(), context.read())),
        Provider<PageController>(create: (_) => PageController(initialPage: 0)),
        Provider<HomeController>(create: (_) => HomeController()),
        Provider<BottomBarController>(create: (context) => BottomBarController(context.read().animateToPage)),
        Provider<OrcamentoController>(create: (_) => OrcamentoController()),
      ],
      child: FutureBuilder(
          future: context.read<ServiceManager>().initializeServices(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const SplashPage();
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
          }),
    );
  }
}
