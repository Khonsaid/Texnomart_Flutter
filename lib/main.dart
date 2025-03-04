import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:texnomart/presenter/basket/bloc/card_bloc.dart';
import 'package:texnomart/presenter/basket/bloc/card_event.dart';
import 'package:texnomart/presenter/bottom/bottom_nav_bar.dart';
import 'package:texnomart/utils/colors.dart';
import 'package:yandex_maps_mapkit_lite/init.dart' as init;

import 'data/scource/locel/hive_helper.dart';
import 'di/di.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setup();
  await HiveHelper.init();
  await init.initMapkit(apiKey: '5a93ec00-b078-4c1e-9e72-4d7bb74b25ca');

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.white, // navigation bar color
    statusBarColor: AppColors.primaryColor, // status bar color
  ));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CardBloc()..add(LoadBasketItemsEvent()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
          title: 'Texnomart Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: const ContainerScreen()),
    );
  }
}
