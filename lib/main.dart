import 'package:WashWoosh/bloc/auth/login/login_bloc.dart';
import 'package:WashWoosh/bloc/mitra/mitra_dashboard/mitra_dashboard_bloc.dart';
import 'package:WashWoosh/bloc/mitra/mitra_detail/mitra_detail_bloc.dart';
import 'package:WashWoosh/bloc/mitra/mitra_register/mitra_register_bloc.dart';
import 'package:WashWoosh/bloc/user/laundry/laundry_list_bloc.dart';
import 'package:WashWoosh/bloc/user/laundry_detail/laundry_detail_bloc.dart';
import 'package:WashWoosh/bloc/user/user_register/user_register_bloc.dart';
import 'package:WashWoosh/routes/routes.dart';
import 'package:WashWoosh/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<LoginBloc>(create: (context) => LoginBloc()),
        BlocProvider<UserRegisterBloc>(create: (context) => UserRegisterBloc()),
        BlocProvider<MitraRegisterBloc>(
            create: (context) => MitraRegisterBloc()),
        BlocProvider<LaundryListBloc>(create: (context) => LaundryListBloc()),
        BlocProvider<LaundryDetailBloc>(
            create: (context) => LaundryDetailBloc()),
        BlocProvider<MitraDashboardBloc>(
            create: (context) => MitraDashboardBloc()),
        BlocProvider<MitraDetailBloc>(create: (context) => MitraDetailBloc()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WashWoosh',
      initialRoute: AppRoutes.home,
      routes: AppRoutes.routes,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.light(
          primary: CustomTheme.primaryColor,
          secondary: CustomTheme.secondaryColor,
          onSecondary: CustomTheme.textWhite,
          onPrimary: CustomTheme.textWhite,
          onBackground: CustomTheme.textBlack,
        ),
        brightness: Brightness.light,
      ),
      // home: const MitraDetailOrder(),
    );
  }
}
