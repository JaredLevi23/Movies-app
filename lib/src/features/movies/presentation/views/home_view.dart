import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pagination/src/features/movies/presentation/blocs/movie/movie_bloc.dart';
import 'package:pagination/src/features/movies/presentation/blocs/now_playing/now_playing_bloc.dart';
import 'package:pagination/src/features/movies/presentation/blocs/populars/populars_bloc.dart';
import 'package:pagination/src/features/movies/presentation/blocs/top_rated/top_rated_bloc.dart';
import 'package:pagination/src/features/movies/presentation/blocs/upcomming/upcomming_bloc.dart';
import 'package:pagination/src/features/movies/presentation/screens/details_movie_screen.dart';
import 'package:pagination/src/features/movies/presentation/widgets/widgets.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final nowPlayingController = ScrollController();
  final topRatedController = ScrollController();
  final popularController = ScrollController();
  final upcomingController = ScrollController();

  @override
  void initState() {
    nowPlayingController.addListener(_nowPlayinglistenerScrollController);
    topRatedController.addListener(_topRatedlistenerScrollController);
    popularController.addListener(_popularlistenerScrollController);
    upcomingController.addListener(_upcominglistenerScrollController);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final movieBloc = BlocProvider.of<MovieBloc>(context);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
        
              const CustomTitle(label: 'Lo más visto'),
        
              BlocBuilder<NowPlayingBloc, NowPlayingState>(
                builder: (context, state) {
                  final movies = state.movies;
        
                  if (movies.isEmpty) {
                    return SizedBox(
                      height: 265,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 10,
                        itemBuilder: (context, index) {
                          return const SizedBox(
                            width: 150,
                            height: 250,
                            child: MovieLoader()
                          );
                        }
                      ),
                    );
                  }
        
                  return SizedBox(
                    height: 265,
                    child: ListView.builder(
                      controller: nowPlayingController,
                      scrollDirection: Axis.horizontal,
                      itemCount: state.status == NowPlayingStatus.loading
                        ? movies.length + 1
                        : movies.length,
                      itemBuilder: (context, index) {
                        if (index == movies.length) {
                          return const SizedBox(
                            width: 150,
                            height: 250,
                            child: MovieLoader()
                          );
                        }
        
                        final movie = movies[index];
                        return GestureDetector(
                          onTap: () {
                            movieBloc.add(SelectedMovieEvent(movie: movie));
                            Navigator.push(context, MaterialPageRoute(builder: (context) {
                              return const DetailsMovieScreen();
                            }));
                          },
                          child: MovieCard(movie: movie),
                        );
                      }
                    ),
                  );
                },
              ),
        
              const CustomTitle(label: 'Proximos lanzamientos'),
        
              BlocBuilder<UpcommingBloc, UpcommingState>(
                builder: (context, state) {
                  final movies = state.movies;
        
                  if (movies.isEmpty) {
                    return SizedBox(
                      height: 265,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 10,
                        itemBuilder: (context, index) {
                          return const SizedBox(
                            width: 150,
                            height: 250,
                            child: MovieLoader()
                          );
                        }
                      ),
                    );
                  }
        
                  return SizedBox(
                    height: 265,
                    child: ListView.builder(
                      controller: upcomingController,
                      scrollDirection: Axis.horizontal,
                      itemCount: state.status == UpcommingStatus.loading
                        ? movies.length + 1
                        : movies.length,
                      itemBuilder: (context, index) {
                        if (index == movies.length) {
                          return const SizedBox(
                            width: 150,
                            height: 250,
                            child: MovieLoader()
                          );
                        }
        
                        final movie = movies[index];
                        return GestureDetector(
                          onTap: () {
                            movieBloc.add(SelectedMovieEvent(movie: movie));
                            Navigator.push(context, MaterialPageRoute(builder: (context) {
                              return const DetailsMovieScreen();
                            }));
                          },
                          child: MovieCard(movie: movie),
                        );
                      }
                    ),
                  );
                },
              ),
        
              const CustomTitle(label: 'Populares'),
        
              BlocBuilder<PopularsBloc, PopularsState>(
                builder: (context, state) {
                  final movies = state.movies;
        
                  if (movies.isEmpty) {
                    return SizedBox(
                      height: 265,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 10,
                        itemBuilder: (context, index) {
                          return const SizedBox(
                            width: 150,
                            height: 250,
                            child: MovieLoader()
                          );
                        }
                      ),
                    );
                  }
        
                  return SizedBox(
                    height: 265,
                    child: ListView.builder(
                      controller: popularController,
                      scrollDirection: Axis.horizontal,
                      itemCount: state.status == PopulatsStatus.loading
                        ? movies.length + 1
                        : movies.length,
                      itemBuilder: (context, index) {
                        if (index == movies.length) {
                          return const SizedBox(
                            width: 150,
                            height: 250,
                            child: MovieLoader()
                          );
                        }
        
                        final movie = movies[index];
                        return GestureDetector(
                          onTap: () {
                            movieBloc.add(SelectedMovieEvent(movie: movie));
                            Navigator.push(context, MaterialPageRoute(builder: (context) {
                              return const DetailsMovieScreen();
                            }));
                          },
                          child: MovieCard(movie: movie),
                        );
                      }
                    ),
                  );
                },
              ),
        
              const CustomTitle(label: 'Mejor valorados'),
        
              BlocBuilder<TopRatedBloc, TopRatedState>(
                builder: (context, state) {
                  final movies = state.movies;
        
                  if (movies.isEmpty) {
                    return SizedBox(
                      height: 265,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 10,
                        itemBuilder: (context, index) {
                          return const SizedBox(
                            width: 150,
                            height: 250,
                            child: MovieLoader()
                          );
                        }
                      ),
                    );
                  }
        
                  return SizedBox(
                    height: 265,
                    child: ListView.builder(
                      controller: topRatedController,
                      scrollDirection: Axis.horizontal,
                      itemCount: state.status == TopRatedStatus.loading
                        ? movies.length + 1
                        : movies.length,
                      itemBuilder: (context, index) {
                        if (index == movies.length) {
                          return const SizedBox(
                            width: 150,
                            height: 250,
                            child: MovieLoader()
                          );
                        }
        
                        final movie = movies[index];
                        return GestureDetector(
                          onTap: () {
                            movieBloc.add(SelectedMovieEvent(movie: movie));
                            Navigator.push(context, MaterialPageRoute(builder: (context) {
                              return const DetailsMovieScreen();
                            }));
                          },
                          child: MovieCard(movie: movie),
                        );
                      }
                    ),
                  );
                },
              ),

              const SizedBox(
                height: 75,
              )

            ],
          ),
        ),
      ),
    );
  }

  void _nowPlayinglistenerScrollController() {
    final nowPlayingBloc = BlocProvider.of<NowPlayingBloc>(context);
    if (nowPlayingController.offset >=
            nowPlayingController.position.maxScrollExtent &&
        !nowPlayingController.position.outOfRange) {
      nowPlayingBloc.add(LoadNowPlayingEvent());
    }
  }

  void _popularlistenerScrollController() {
    final popularsBloc = BlocProvider.of<PopularsBloc>(context);
    if (popularController.offset >=
            popularController.position.maxScrollExtent &&
        !popularController.position.outOfRange) {
      popularsBloc.add(LoadPopularsEvent());
    }
  }

  void _topRatedlistenerScrollController() {
    final topRatedBloc = BlocProvider.of<TopRatedBloc>(context);
    if (topRatedController.offset >=
            topRatedController.position.maxScrollExtent &&
        !topRatedController.position.outOfRange) {
      topRatedBloc.add(LoadTopRatedEvent());
    }
  }

  void _upcominglistenerScrollController() {
    final upcomingBloc = BlocProvider.of<UpcommingBloc>(context);
    if (upcomingController.offset >=
            upcomingController.position.maxScrollExtent &&
        !nowPlayingController.position.outOfRange) {
      upcomingBloc.add(LoadUpcommingEvent());
    }
  }
}

