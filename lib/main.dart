import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:juniors_on_map/src/providers/locations_providers.dart';
import 'package:provider/provider.dart';

import 'src/app.dart';

void main() async {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => MapProvider(),)
      ],
    child: const MyApp(),
  ));
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
  ));
}
