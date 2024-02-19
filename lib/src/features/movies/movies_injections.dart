

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pagination/src/core/helpers/upload.dart';
import 'package:pagination/src/core/utils/injections.dart';
import 'package:pagination/src/features/movies/data/data_sources/remote/auth/abstract_auth_service.dart';
import 'package:pagination/src/features/movies/data/data_sources/remote/auth/auth_service_impl.dart';
import 'package:pagination/src/features/movies/data/data_sources/remote/favorites/abstract_favorites_api.dart';
import 'package:pagination/src/features/movies/data/data_sources/remote/reviews/abstract_review_api.dart';
import 'package:pagination/src/features/movies/data/data_sources/remote/reviews/review_api_impl.dart';
import 'package:pagination/src/features/movies/data/data_sources/remote/tmdb/abstract_tmdb_api.dart';
import 'package:pagination/src/features/movies/data/data_sources/remote/favorites/favorites_api_impl.dart';
import 'package:pagination/src/features/movies/data/data_sources/remote/tmdb/tmdb_api_impl.dart';
import 'package:pagination/src/features/movies/data/repositories/auth_repository.dart';
import 'package:pagination/src/features/movies/data/repositories/db_local_repository.dart';
import 'package:pagination/src/features/movies/data/repositories/favorites_repository.dart';
import 'package:pagination/src/features/movies/data/repositories/review_repository.dart';
import 'package:pagination/src/features/movies/data/repositories/tmdm_repository.dart';
import 'package:pagination/src/features/movies/domain/repositories/abstract_auth_repository.dart';
import 'package:pagination/src/features/movies/domain/repositories/abstract_db_local_repository.dart';
import 'package:pagination/src/features/movies/domain/repositories/abstract_favorites_repository.dart';
import 'package:pagination/src/features/movies/domain/repositories/abstract_reviews_repository.dart';
import 'package:pagination/src/features/movies/domain/repositories/abstract_tmdb_repository.dart';
import 'package:pagination/src/shared/data/data_source/app_shared_prefs.dart';

initMoviesInjections(){
  sl.registerSingleton<UploadFile>( UploadFile() );
  sl.registerSingleton<FirebaseFirestore>( FirebaseFirestore.instance );
  sl.registerSingleton<TmdbApiImpl>( TmdbApiImpl() );
  sl.registerSingleton<AbstractTmdbApi>( TmdbApiImpl() );
  sl.registerSingleton<AbstractAuthService>( AuthServiceImpl() );
  sl.registerSingleton<AuthServiceImpl>( AuthServiceImpl() );
  sl.registerSingleton<AppSharedPrefs>( AppSharedPrefs( sl() ));
  sl.registerSingleton<AbstractTmdbRepository>( TmdbRepository( api: sl() ) );
  sl.registerSingleton<AbstractFavoritesApi>( FavoritesApiImpl( db: sl() ) );
  sl.registerSingleton<AbstractAuthRepository>( AuthRepository(api: sl()) );
  sl.registerSingleton<AuthRepository>( AuthRepository(api: sl()) );
  sl.registerSingleton<AbstractDbLocalRepository>( DBLocalRepository( local: sl() ) );
  sl.registerSingleton<AbstractFavoritesRepository>( FavoritesRepository( api: sl() ) );
  sl.registerSingleton<FavoritesRepository>( FavoritesRepository( api: sl() ) );
  sl.registerSingleton<AbstractReviewsApi>( ReviewApiImpl( db: sl() )  );
  sl.registerSingleton<ReviewApiImpl>( ReviewApiImpl( db: sl() )  );
  sl.registerSingleton<AbstractReviewsRepository>(ReviewRepository( api: sl()  ));
  sl.registerSingleton<ReviewRepository>(ReviewRepository( api: sl()  ));
}