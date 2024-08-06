import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:orcamento_app_flutter/App/orc_app.dart';

import 'App/services/service_manager.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  GetIt.I.registerSingletonAsync<ServiceManager>(() async {
    var serviceManager = ServiceManager();
    await serviceManager.initializeServices();
    return serviceManager;
  });
  runApp(OrcApp());
}
