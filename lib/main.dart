import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pagination/src/core/utils/injections.dart';
import 'package:pagination/src/features/movies/presentation/blocs/auth/auth_bloc.dart';
import 'package:pagination/src/features/movies/presentation/blocs/blocs.dart';
import 'package:pagination/src/features/movies/presentation/blocs/favorites/favorites_bloc.dart';
import 'package:pagination/src/features/movies/presentation/screens/home_screen.dart';

void main() async {
  
  WidgetsFlutterBinding.ensureInitialized();
  await initInjections();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [

        BlocProvider(create: ( context ) => MovieBloc( service: sl(), reviews: sl() ) ),
        BlocProvider(create: ( context ) => CounterViewBloc() ),
        BlocProvider(create: ( context ) => AuthBloc( authService: sl() ) ),
        BlocProvider(create: ( context ) => MoviesBloc( service: sl(), db: sl(), reviewsRepository: sl())),
        BlocProvider(create: ( context ) => PopularsBloc( repository: sl(), db: sl() )),
        BlocProvider(create: ( context ) => UpcommingBloc( repository: sl(), db: sl() )),
        BlocProvider(create: ( context ) => TopRatedBloc( repository: sl(), db: sl() )),
        BlocProvider(create: ( context ) => NowPlayingBloc( repository: sl(), db: sl() )),
        BlocProvider(create: ( context ) => FavoritesBloc( api: sl(), db: sl(), tmdbApi: sl() )),
        
      ],
      child: MaterialApp(
        home: const HomeScreen(),
        theme: ThemeData.dark(),
      ),
    );
  }
}
