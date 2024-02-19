
import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';
import 'package:pagination/firebase_options.dart';
import 'package:pagination/src/core/db/db_local.dart';
import 'package:pagination/src/features/movies/data/data_sources/local/tmdb_db_impl.dart';
import 'package:pagination/src/features/movies/movies_injections.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> initInjections() async{
  await _initFirebase();
  await _initDB();
  await _initSharedPrefsInjections();
  await initMoviesInjections();
}

Future<void>_initFirebase () async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
}

Future<void>_initDB () async {
  sl.registerSingleton<DbLocal>( DbLocal() );
  final db = await sl<DbLocal>().initDB();
  sl.registerSingleton<TmdbDB>( TmdbDB( database: db ) );
}

_initSharedPrefsInjections() async {
  sl.registerSingletonAsync<SharedPreferences>(() async {
    return await SharedPreferences.getInstance();
  });
  await sl.isReady<SharedPreferences>();
}

