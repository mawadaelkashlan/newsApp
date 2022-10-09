import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:news_app/layout/cubit/cubit.dart';
import 'package:news_app/layout/cubit/states.dart';
import 'package:news_app/layout/splash_screen.dart';
import 'package:news_app/shared/bloc_observer.dart';
import 'package:news_app/shared/network/local/cache_helper.dart';
import 'package:news_app/shared/network/remote/dio_helper.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  bool? isDark = CacheHelper.getBoolean(key: 'isDark') ?? false ;
  runApp(MyApp(isDark));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final bool isDark;
  MyApp(this.isDark);
  
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AppCubit()..getBusinessData()..getSportsData()..getScienceData()),
        BlocProvider(
          create: (BuildContext context) => AppCubit()..changeThemeMode(
            fromShared: isDark,
          ),),
      ],
      child: BlocConsumer<AppCubit , NewsStates> (
          listener: (context , state){},
          builder:(context , state) {
            return MaterialApp(
              title: 'Flutter Demo',
              theme: ThemeData(
                  primarySwatch: Colors.red,
                  scaffoldBackgroundColor: Colors.white,
                  appBarTheme: AppBarTheme(
                    titleSpacing: 20.0,
                    backwardsCompatibility: false,
                    systemOverlayStyle: SystemUiOverlayStyle(
                      statusBarColor: Colors.white,
                      statusBarIconBrightness: Brightness.dark,
                    ),
                    color: Colors.white,
                    titleTextStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25.0,
                        color: Colors.black
                    ),
                    iconTheme: IconThemeData(
                        color: Colors.black
                    ),
                    elevation: 0.0,
                  ),
                  floatingActionButtonTheme: FloatingActionButtonThemeData(
                    backgroundColor: Colors.redAccent,
                  ),
                  bottomNavigationBarTheme: BottomNavigationBarThemeData(
                      type: BottomNavigationBarType.fixed,
                      selectedItemColor: Colors.redAccent,
                      unselectedItemColor: Colors.grey,
                      backgroundColor: Colors.white,
                      elevation: 50.0
                  ),
                  textTheme: TextTheme(
                      bodyText1: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      )
                  )
              ),
              darkTheme: ThemeData(
                  primarySwatch: Colors.red,
                  scaffoldBackgroundColor: HexColor('333333'),
                  appBarTheme: AppBarTheme(
                    titleSpacing: 20.0,
                    backwardsCompatibility: false,
                    systemOverlayStyle: SystemUiOverlayStyle(
                      statusBarColor:  HexColor('333333'),
                      statusBarIconBrightness: Brightness.light,
                    ),
                    color:  HexColor('333333'),
                    titleTextStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25.0,
                        color: Colors.white
                    ),
                    iconTheme: IconThemeData(
                        color: Colors.white
                    ),
                    elevation: 0.0,
                  ),
                  floatingActionButtonTheme: FloatingActionButtonThemeData(
                    backgroundColor: Colors.redAccent,
                  ),
                  bottomNavigationBarTheme: BottomNavigationBarThemeData(
                      type: BottomNavigationBarType.fixed,
                      selectedItemColor: Colors.redAccent,
                      unselectedItemColor: Colors.grey,
                      backgroundColor: HexColor('333333'),
                      elevation: 50.0
                  ),
                  textTheme: TextTheme(
                      bodyText1: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      )
                  )
              ),
              themeMode: AppCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
              home: SplashScreen(),
            );
          }
      ),
    );
  }
}