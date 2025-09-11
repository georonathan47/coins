import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'bitcoins.dart';
import 'core/shared/data/hive_adapters.dart';
import 'flavors.dart';
import 'injection_container.dart';

Future<void> main({Flavor? env}) async {
  WidgetsFlutterBinding.ensureInitialized();

  env ??= Flavor.values.firstWhere((element) => element.name == appFlavor);
  await HiveAdapters.setUp();
  initBindings();
  runApp(const Bitcoins());
}
