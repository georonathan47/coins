import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'core/data/routes.dart';
import 'core/theme/theme.dart';
import 'core/utils/bindings/general_bindings.dart';
import 'flavors.dart';

class Bitcoins extends StatelessWidget {
  const Bitcoins({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: F.title,
      theme: TAppTheme.lightTheme,
      themeMode: ThemeMode.system,
      useInheritedMediaQuery: true,
      darkTheme: TAppTheme.darkTheme,
      getPages: RouteManager.getPages(),
      initialBinding: GeneralBindings(),
      debugShowCheckedModeBanner: false,
      initialRoute: RouteManager.initial,
    );
  }
}
