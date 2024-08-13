import 'package:flutter/material.dart';
import 'services/api/orcamento_api_service.dart';
import 'services/service_manager.dart';
import 'services/themes/theme_service.dart';
import 'services/api/account_api_service.dart';
import 'services/api/item_orcamento_api_service.dart';
import 'package:orcamento_app_flutter/App/stores/orcamentos_store.dart';
import 'package:orcamento_app_flutter/App/stores/signin_store.dart';
import 'package:provider/provider.dart';
import 'data/enums/theme_type.dart';
import 'pages/main_page.dart';
import 'pages/splash/splash_page.dart';

class OrcApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<ServiceManager>(create: (_) => ServiceManager()),
        Provider<AccountAPIService>(create: (_) => AccountAPIService()),
        Provider<OrcamentoAPIService>(create: (_) => OrcamentoAPIService()),
        Provider<ItemOrcamentoApiService>(create: (_) => ItemOrcamentoApiService()),
        ChangeNotifierProvider(create: (context) => SignInStore(context.read())),
        ChangeNotifierProvider(create: (context) => OrcamentosStore(context.read())),
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
