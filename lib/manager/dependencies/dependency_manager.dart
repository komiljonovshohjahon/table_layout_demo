import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:table_layout_demo/manager/dependencies/dependencies.dart';

import '../controllers/controllers.dart';

class Manager {
  static final Manager _instance = Manager._internal();

  factory Manager() {
    return _instance;
  }

  Manager._internal();

  static final _getIt = GetIt.instance;

  //Application dependency
  static final AppDep _appDep = AppDep();
  static AppDep get appDep => _getIt<AppDep>();

  //Canvas Controller
  static CanvasController get canvasController => _getIt<CanvasController>();

  //General Table Controller
  static GeneralTableController get generalTableController =>
      _getIt<GeneralTableController>();

  static final ConfigDep _configDep = ConfigDep();
  static ConfigDep get configDep => _getIt<ConfigDep>();

  //It is run in main.dart
  static void init() {
    _getIt.registerSingleton<AppDep>(_appDep);

    final _cController = Get.put<CanvasController>(CanvasController());
    final _gtController =
        Get.put<GeneralTableController>(GeneralTableController());
    _getIt.registerSingleton<CanvasController>(_cController);
    _getIt.registerSingleton<GeneralTableController>(_gtController);

    _getIt.registerSingleton<ConfigDep>(_configDep);
  }
}
