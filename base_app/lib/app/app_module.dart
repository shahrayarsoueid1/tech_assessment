import 'package:base_core/main.dart';
import 'package:base_dependencies/main.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [...CoreModule.binds];

  @override
  final List<ModularRoute> routes = [...CoreModule.routes];
}
