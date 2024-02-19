
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class MovieImage extends StatelessWidget {
  const MovieImage({
    super.key,
    required this.path
  });

  final String path;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular( 16 ),
      child: CachedNetworkImage(
        fit: BoxFit.cover,
        imageUrl: 'https://image.tmdb.org/t/p/w500$path',
        placeholder: (context, url) => const MovieLoader(),
        errorWidget: (_,__,___) => const MovieLoader(),
      ),
    );
  }
}


class MovieLoader extends StatelessWidget {
  const MovieLoader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Icon( Icons.movie, color: Colors.white );
  }
}

class MovieLoadCard extends StatelessWidget {

  final IconData icon;
  final Color? iconColor;
  final Color? backgroundColor;
  final Function()? onPressed;

  const MovieLoadCard({
    super.key,
    required this.onPressed,
    required this.icon,
    this.backgroundColor,
    this.iconColor
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all( 5 ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular( 16 ),
        border: Border.all( width: 2, color: iconColor ?? Colors.black )
      ),
      child: Center(
        child: IconButton(
          iconSize: 40,
          color: iconColor ?? Colors.black,
          icon: Icon( icon ),
          onPressed: onPressed,
        ),
      ),
    );
  }
}

