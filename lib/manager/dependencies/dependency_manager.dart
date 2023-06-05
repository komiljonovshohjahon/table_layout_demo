import 'package:get_it/get_it.dart';
import 'package:table_layout_demo/manager/dependencies/dependencies.dart';

class DependencyManager {
  static final DependencyManager _instance = DependencyManager._internal();

  factory DependencyManager() {
    return _instance;
  }

  DependencyManager._internal();

  static final _getIt = GetIt.instance;

  //Application dependency
  static final AppDep _appDep = AppDep();
  static AppDep get appDep => _getIt<AppDep>();

  //It is run in main.dart
  static void init() {
    _getIt.registerSingleton<AppDep>(_appDep);
  }
}
