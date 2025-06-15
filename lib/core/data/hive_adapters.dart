import '../../hive_registrar.g.dart';
import 'package:hive_ce/hive.dart';
import 'package:path_provider/path_provider.dart';

/// Add adapters to Hive per entity
class HiveAdapters {
  /// User Entity
  static const user = 0;
  static const onboarding = 2;

  /// Initialize adapters when app starts
  static Future<void> setUp() async {
    final appDir = await getApplicationDocumentsDirectory();
    Hive
      ..init(appDir.path)
      ..registerAdapters();
  }
}
