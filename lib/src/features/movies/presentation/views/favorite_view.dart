import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pagination/src/features/movies/presentation/blocs/favorites/favorites_bloc.dart';
import 'package:pagination/src/features/movies/presentation/blocs/movie/movie_bloc.dart';
import 'package:pagination/src/features/movies/presentation/screens/details_movie_screen.dart';
import 'package:pagination/src/features/movies/presentation/widgets/widgets.dart';

class FavoriteView extends StatelessWidget {
const FavoriteView({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context){

    final movieBloc = BlocProvider.of<MovieBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Favoritos'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          BlocBuilder<FavoritesBloc, FavoritesState>(
            builder: (context, state) {

              final movies = state.favorites;

              if( state.status == FavoritesStatus.loading ){
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if( movies.isEmpty ){
                return const Center(
                  child: Text('No hay favoritos'),
                );
              }

              return Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.all(4),
                  itemCount: movies.length ,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 0.5
                  ), 
                  itemBuilder: ( context, index ){
                    final movie = movies[ index ];
                    return GestureDetector(
                      onTap: (){
                        movieBloc.add( SelectedMovieEvent(movie: movie));
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) => const DetailsMovieScreen())
                        );
                      },
                      child: MovieCard(
                        movie: movie
                      ),
                    );
                  }
                )
              );
            },
          ),

          const SizedBox(
            height: 70,
          ),
        ],
      ),
    );
  }
}