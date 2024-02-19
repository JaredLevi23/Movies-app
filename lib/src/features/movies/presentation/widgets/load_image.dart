
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pagination/src/features/movies/presentation/widgets/movie_image.dart';

class LoadImage extends StatelessWidget {

  final String path;
const LoadImage({ 
  Key? key, 
  required this.path 
  }) : super(key: key);

  @override
  Widget build(BuildContext context){

    if( path.isEmpty ){
      return const MovieLoader();
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular( 16 ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular( 16 )
        ),
        child: CachedNetworkImage(
          fit: BoxFit.cover,
          imageUrl: path,
          placeholder: (context, url) => const MovieLoader(),
          errorWidget:(context, url, error) => const MovieLoader(),
        ),
      ),
    );

  }
}