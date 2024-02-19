import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pagination/src/features/movies/presentation/blocs/counter_view/counter_view_bloc.dart';
import 'package:pagination/src/features/movies/presentation/blocs/movie/movie_bloc.dart';
import 'package:pagination/src/features/movies/presentation/blocs/movies/movies_bloc.dart';
import 'package:pagination/src/features/movies/presentation/screens/details_movie_screen.dart';
import 'package:pagination/src/features/movies/presentation/widgets/widgets.dart';

class ExploreView extends StatefulWidget {
const ExploreView({ Key? key }) : super(key: key);

  @override
  State<ExploreView> createState() => _ExploreViewState();
}

class _ExploreViewState extends State<ExploreView> {

  final controller = ScrollController();
  double lastScroll = 0;

  @override
  void initState() {

    final counterViewBloc = BlocProvider.of<CounterViewBloc>(context, listen: false);

    controller.addListener(() { 
      if( controller.offset > lastScroll ){
        counterViewBloc.add( const ShowBarEvent(showBar: false));
      }else{
        counterViewBloc.add( const ShowBarEvent(showBar: true));
      }
      lastScroll = controller.offset;
    });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context){

    final movieBloc = BlocProvider.of<MovieBloc>(context);
    final moviesBloc = BlocProvider.of<MoviesBloc>(context);
    final counterViewBloc = BlocProvider.of<CounterViewBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Explorar'),
      ),
      body: BlocBuilder<MoviesBloc, MoviesState>(
        builder: (context, state) {
            
          final movies = state.movies;
            
          if( movies.isEmpty ){
            return const Center(
              child: Text('No se han cargado datos para explorar'),
            );
          }
            
          return GridView.builder(
            padding: const EdgeInsets.all( 8 ),
            controller: controller,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 0.5
            ),
            itemCount: movies.length + 1,
            itemBuilder: ( context, index ){
            
              if( index == movies.length ){
                return MovieLoadCard(
                  backgroundColor: Colors.black,
                  iconColor: Colors.white,
                  icon: Icons.add,
                  onPressed: state.status == MoviesStatus.loading 
                  ? null
                  : (){ 
                    moviesBloc.add( LoadMoviesEvent() );
                  },
                );
              }
            
              final movie = movies[ index ];
              return GestureDetector(
                onTap: (){
                  counterViewBloc.add( const ShowBarEvent(showBar: true ) );
                  movieBloc.add(SelectedMovieEvent(movie: movie));
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const DetailsMovieScreen();
                  }));
                },
                child: MovieCard(
                  movie: movie
                ),
              );
            }
          );
        },
      )
    );
  }
}