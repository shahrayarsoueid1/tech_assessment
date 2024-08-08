import 'package:base_app/app/app_module.dart';
import 'package:base_app/app/app_widget.dart';
import 'package:base_app/bootstrap.dart';
import 'package:base_dependencies/main.dart';

void main() {
  bootstrap(
    () => ModularApp(
      module: AppModule(),
      child: const AppWidget(),
    ),
  );
}
