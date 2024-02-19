import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pagination/src/features/movies/domain/models/movie_model.dart';
import 'package:pagination/src/features/movies/domain/models/reviews_model.dart';
import 'package:pagination/src/features/movies/presentation/blocs/auth/auth_bloc.dart';
import 'package:pagination/src/features/movies/presentation/blocs/favorites/favorites_bloc.dart';
import 'package:pagination/src/features/movies/presentation/blocs/movie/movie_bloc.dart';
import 'package:pagination/src/features/movies/presentation/blocs/movies/movies_bloc.dart';
import 'package:pagination/src/features/movies/presentation/widgets/movie_image.dart';
import 'package:pagination/src/features/movies/presentation/widgets/widgets.dart';

class DetailsMovieScreen extends StatelessWidget {
const DetailsMovieScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context){

    final authBloc = BlocProvider.of<AuthBloc>(context);
    final favoritesBloc = BlocProvider.of<FavoritesBloc>(context);
    final movieBloc = BlocProvider.of<MovieBloc>(context);
    final moviesBloc = BlocProvider.of<MoviesBloc>(context);
    final user = BlocProvider.of<AuthBloc>(context).state.user;

    return BlocBuilder<MovieBloc, MovieState>(
      builder: (context, state) {

        final movie = state.currentMovie!;
        final reviews = state.review;

        return Scaffold(
          body: CustomScrollView(
            slivers: [

              SliverAppBar(
                expandedHeight: 150,
                backgroundColor: Colors.white,
                flexibleSpace: Container(
                  color: Colors.black,
                  child: MovieImage(path: movie.backdropPath ?? '' )
                )
              ),

              SliverList(delegate: SliverChildListDelegate([

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      margin: const EdgeInsets.all( 16 ),
                      width: 150,
                      height: 250,
                      child: MovieImage(path: movie.posterPath ?? ''),
                    ),

                    Expanded(
                      child: Column(
                        children: [

                          Padding(
                            padding: const EdgeInsets.only( right: 16 ),
                            child: Text(
                              movie.title ?? '',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 23,
                                fontWeight: FontWeight.w400,
                                                  
                              ),
                            ),
                          ),

                          const SizedBox(
                            height: 8,
                          ),

                          Text(
                            movie.releaseDate.toString().split(' ')[0],
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w300,
                      
                            ),
                          ),

                          BlocBuilder<FavoritesBloc,FavoritesState>(
                            builder:( context, state ){

                              final isSaved = state.favorites.map((e) => e.id ).toList().contains( movie.id );

                              return Container(
                                width: double.infinity,
                                margin: const EdgeInsets.only( right: 16 ),
                                child: FilledButton.icon(
                                  onPressed: isSaved 
                                  ? (){
                                    showDialog(
                                      context: context, 
                                      builder: ( context ){
                                        return AlertDialog(
                                          title: const Text(
                                            '¿Desea eliminar este elemento de favoritos?',
                                            textAlign: TextAlign.center,
                                          ),
                                          content: SingleChildScrollView(
                                            child: Column(
                                              children: [
                                            
                                                Center(
                                                  child: Container(
                                                    margin: const EdgeInsets.all( 8 ),
                                                    width: 100,
                                                    height: 150,
                                                    child: MovieImage(
                                                      path: movie.posterPath ?? ''
                                                    ),
                                                  ),
                                                ),
                                            
                                                Text( 
                                                  movie.title ?? 'No title',
                                                  textAlign: TextAlign.center,
                                                )
                                              ],
                                            ),
                                          ),
                                          actions: [
                                            TextButton(
                                              onPressed: (){
                                                Navigator.pop(context);
                                                favoritesBloc.add( RemoveFavoritesEvent(movie: movie, uid: authBloc.state.user?.uid ));
                                              }, 
                                              child: const Text( 'Confirmar' )
                                            ),
                                            TextButton(
                                              onPressed: () => Navigator.pop(context), 
                                              child: const Text( 'Cancelar' )
                                            ),
                                          ],
                                        );
                                      }
                                    );
                                  }
                                  : (){
                                    favoritesBloc.add( SaveFavoritesEvent(movie: movie, uid: authBloc.state.user?.uid ) );
                                  }, 
                                  icon:  Icon( isSaved ? Icons.heart_broken : Icons.favorite ), 
                                  label: Text( isSaved ? 'Remover de favoritos' : 'Agregar a favoritos')
                                ),
                              );
                            },
                          ),

                          Container(
                            width: double.infinity,
                            margin: const EdgeInsets.only( right: 16 ),
                            child: FilledButton.icon(
                              onPressed: (){

                                movieBloc.add( AddReviewEvent(review: ReviewModel(
                                  id: '${movie.id}',
                                  url: '',
                                  uid: user?.uid ?? '',
                                  author: user?.displayName ?? 'No name'
                                )));

                                showDialog(
                                  context: context, 
                                  builder: (context){
                                    return BlocConsumer<MovieBloc, MovieState>(
                                      listener: (context, state) {
                                        if( state.status == MovieStatus.loaded ){
                                          Navigator.pop(context);
                                          moviesBloc.add( AddReviewListEvent(review: state.currentReview! ));
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            const SnackBar(content: Text('Reseña guardada'))
                                          );
                                        }
                                      },
                                      builder: (context, state) {

                                        if( state.status == MovieStatus.loading ){
                                          return const AlertDialog(
                                            content: SingleChildScrollView(
                                              child: Column(
                                                children: [
                                                  Text('Subiendo reseña'),
                                                  SizedBox(
                                                    height: 16,
                                                  ),
                                                  CircularProgressIndicator(),
                                                ],
                                              ),
                                            ),
                                          );
                                        }
                                        
                                        return AlertDialog(
                                          content: ReviewForm(movie: movie),
                                          actions: [
                                            TextButton(
                                              onPressed: (){
                                                print( movieBloc.state.currentReview );
                                                movieBloc.add( SaveReviewEvent(
                                                  review: movieBloc.state.currentReview!.copyWith(
                                                    createdAt: DateTime.now()
                                                  )
                                                ));
                                              }, 
                                              child: const Text( 'Agregar' )
                                            ),
                                            TextButton(
                                              onPressed: (){
                                                Navigator.pop(context);
                                              }, 
                                              child: const Text( 'Cancelar' )
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  }
                                );
                              }, 
                              icon: const Icon( Icons.message_outlined ), 
                              label: const Text('Agregar reseña')
                            ),
                          ),
                          
                        ],
                      ),
                    )
                  ],
                ),

                const SizedBox(
                  height: 20,
                ),

                Padding(
                  padding: const EdgeInsets.all( 16.0 ),
                  child: Text(
                    movie.overview ?? '',
                    textAlign: TextAlign.justify,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w300,
                  
                    ),
                  ),
                ),

                if( state.status == MovieStatus.loading )
                const Center(
                  child: CircularProgressIndicator()
                ),

                if( reviews != null && reviews.results!.isNotEmpty )
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  
                      const Text('Reseñas', style: TextStyle( fontSize: 21, fontWeight: FontWeight.bold ),),

                      const Divider(),

                      ...reviews.results!.map((e){

                        return GestureDetector(
                          onTap: (){
                            showModalBottomSheet(context: context, builder: (context){
                              return SingleChildScrollView(
                                padding: const EdgeInsets.all( 16 ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox( width: double.infinity ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text( e.author ?? 'Sin nombre', style: const TextStyle( fontSize: 20 ), ),
                                              Text( e.createdAt.toString().split('.')[0] , style: const TextStyle( fontSize: 12 ), ),
                                            ],
                                          ),
                                        ),
                                        if( e.url != null && e.url!.startsWith('http') )
                                        SizedBox(
                                          width: 100,
                                          height: 150,
                                          child: LoadImage(path: e.url ?? '' )
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    Text(  e.content ?? ''),
                                  ],
                                ),
                              );
                            });
                          },
                          child: Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.all( 4 ),
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular( 16 ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                          
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text( e.content ?? '', maxLines: 3, overflow: TextOverflow.ellipsis),
                                         if( e.url != null && e.url!.startsWith('http') )
                                          SizedBox(
                                            width: 40,
                                            height: 60,
                                            child: LoadImage(path: e.url ?? '' )
                                          )
                                      ],
                                    ),

                                    const SizedBox(
                                      height: 10,
                                    ),

                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text( 'AUTOR: ${ e.author }', maxLines: 3 ),
                                      ],
                                    ), 
                          
                                  ],
                                ),
                              ),
                              const Divider()
                            ],
                          ),
                        );
                      }).toList()
                  
                    ],
                  ),
                )

              ]))

            ],
          ),
        );
      },
    );
  }
}

class ReviewForm extends StatefulWidget {
  const ReviewForm({
    super.key,
    required this.movie,
  });

  final MovieModel movie;

  @override
  State<ReviewForm> createState() => _ReviewFormState();
}

class _ReviewFormState extends State<ReviewForm> {

  String? path;
  bool useCamera = false;

  @override
  Widget build(BuildContext context) {

    final movieBloc = BlocProvider.of<MovieBloc>(context);

    return SingleChildScrollView(
      child: Column(
        children: [
          
          Row(
            children: [

              if( path == null )
              Container(
                margin: const EdgeInsets.only( right: 16  , bottom: 16 ),
                width: 100,
                height: 150,
                child: MovieImage(
                  path: widget.movie.posterPath ?? ''
                ),
              )
              else 
              Stack(
                children: [

                  ClipRRect(
                    borderRadius: BorderRadius.circular( 16 ),
                    child: Container(
                      margin: const EdgeInsets.only( right: 8 ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular( 16 )
                      ),
                      width: 100,
                      height: 150,
                      child: Image.file( 
                        File( path! ) 
                      )
                    ),
                  ),

                  Positioned(
                    top: 0,
                    right: 0,
                    child: IconButton(
                      style: const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll( Colors.red ),
                        iconColor: MaterialStatePropertyAll( Colors.white )
                      ),
                      onPressed: (){
                        path = null;
                        setState(() {});
                        movieBloc.add( AddReviewEvent(review: movieBloc.state.currentReview!.copyWith(
                          url: ''
                        )));
                      }, 
                      icon: const Icon( Icons.close )
                    )
                  )

                ],
              ),
      
              Expanded(
                child: Column(
                  children: [
                    const Text(
                      'Nueva reseña',
                      style: TextStyle(
                        fontSize: 23
                      ),
                    ),
                    Row(
                      children: [
                        const Icon( Icons.camera_alt_outlined ),
                        Switch(
                          inactiveTrackColor: Colors.indigo,
                          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          value: useCamera, 
                          onChanged: ( value ){
                            useCamera = value;
                            setState(() {});
                          }
                        ),
                        const Icon( Icons.photo_album ),
                      ],
                    ),
                    TextButton(
                      onPressed: () async {
                        final result = await ImagePicker().pickImage(source: !useCamera ? ImageSource.camera : ImageSource.gallery);
                        if (result != null) {
                          XFile file = XFile(result.path);
                          path = file.path;
                          movieBloc.add( AddReviewEvent(review: movieBloc.state.currentReview!.copyWith(
                            url: file.path
                          )));
                          setState(() {});
                        }
                      }, 
                      child: const Text('Agregar imagen')
                    )
                  ],
                ),
              ),
      
          
            ],
          ),
      
          TextFormField(
            minLines: 5,
            maxLines: 10,
            decoration: InputDecoration(
              hintText: 'Escribe algo...',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular( 16 ),
              ),              
            ),
            onChanged: ( value ){
              movieBloc.add( AddReviewEvent(review: movieBloc.state.currentReview!.copyWith(
                content: value
              )));
            }
          ),
        
        ],
      ),
    );
  }
}