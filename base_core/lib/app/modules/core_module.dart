import 'package:base_dependencies/main.dart';
import 'package:topup_app/app/modules/topup_app_module.dart';

abstract class CoreModule {
  static final List<Bind> binds = [
    ...TopUpAppModule.binds,
  ];

  static final List<ModularRoute> routes = [
    ...TopUpAppModule.routes,
  ];
}
