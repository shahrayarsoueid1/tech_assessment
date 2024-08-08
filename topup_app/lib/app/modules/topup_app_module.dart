// ignore_for_file: avoid_classes_with_only_static_members

import 'package:base_dependencies/main.dart';
import 'package:topup_app/app/modules/topup_module.dart';

class TopUpAppModule {
  static final List<Bind<Object>> binds = <Bind<Object>>[
    ...TopUpModule.getBinds(),
  ];

  static final List<ModularRoute> routes = <ModularRoute>[
    ...TopUpModule.getRoutes(),
  ];
}
