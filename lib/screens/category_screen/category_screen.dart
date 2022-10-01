import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app_api/bloc/genre_bloc/genre_bloc.dart';
import 'package:movie_app_api/models/movie.dart';
import 'package:movie_app_api/screens/movie_detail_screen.dart';

import '../../bloc/genre_bloc/genre_event.dart';
import '../../bloc/genre_bloc/genre_state.dart';
import '../../bloc/movie_blocs/movie_bloc.dart';
import '../../models/genre.dart';

class BuildWidgetCategory extends StatefulWidget {
  final int selectedGenre;
  const BuildWidgetCategory({super.key, this.selectedGenre = 28});

  @override
  State<BuildWidgetCategory> createState() => _BuildWidgetCategoryState();
}

class _BuildWidgetCategoryState extends State<BuildWidgetCategory> {
  int? selectedGenre;
  @override
  void initState() {
    super.initState();
    selectedGenre = widget.selectedGenre;
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<GenreBloc>(
          create: ((context) => GenreBloc()..add(GenreStartedEvent())),
        ),
        BlocProvider<MovieBloc>(
          create: ((context) =>
              MovieBloc()..add(MovieEventStarted(widget.selectedGenre, ''))),
        ),
      ],
      child: _buildGenre(context),
    );
  }

  Widget _buildGenre(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BlocBuilder<GenreBloc, GenreState>(
          builder: ((context, state) {
            if (state is GenreLoadingState) {
              return const Center(
                child: CupertinoActivityIndicator(),
              );
            } else if (state is GenreLoadedState) {
              List<Genre> genres = state.genreList;
              return SizedBox(
                height: 45,
                child: ListView.separated(
                  itemCount: genres.length,
                  separatorBuilder: (context, index) => const VerticalDivider(
                    color: Colors.transparent,
                    width: 5,
                  ),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    Genre genre = genres[index];
                    return Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedGenre = genre.genreId;
                              context
                                  .read<MovieBloc>()
                                  .add(MovieEventStarted(selectedGenre!, ''));
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: genre.genreId == selectedGenre
                                  ? Colors.black45
                                  : Colors.white,
                              border: Border.all(
                                color: genre.genreId == selectedGenre
                                    ? Colors.white
                                    : Colors.black45,
                              ),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(25),
                              ),
                            ),
                            child: Text(
                              genre.genreName!.toUpperCase(),
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: genre.genreId == selectedGenre
                                    ? Colors.white
                                    : Colors.black45,
                                fontFamily: 'Muli',
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              );
            } else {
              return Container();
            }
          }),
        ),
        const SizedBox(
          height: 18,
        ),
        Container(
          child: Text(
            'new playing'.toUpperCase(),
            style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.black45,
                fontFamily: 'Muli'),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        BlocBuilder<MovieBloc, MovieState>(
          builder: ((context, state) {
            if (state is MovieLoading) {
              return const Center(child: CupertinoActivityIndicator());
            } else if (state is MovieLoaded) {
              List<Movie> movieList = state.movieList;
              return SizedBox(
                height: 300,
                child: ListView.separated(
                  itemCount: movieList.length,
                  separatorBuilder: (context, index) => const VerticalDivider(
                    color: Colors.transparent,
                    width: 10,
                  ),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    Movie movie = movieList[index];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    MovieDetailScreen(movie: movie)));
                          },
                          child: ClipRRect(
                            child: CachedNetworkImage(
                              imageUrl:
                                  'https://image.tmdb.org/t/p/original/${movie.backdropPath}',
                              imageBuilder: (context, imageProvider) {
                                return Container(
                                  width: 180,
                                  height: 250,
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(12),
                                    ),
                                    image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.cover),
                                  ),
                                );
                              },
                              placeholder: (context, url) => SizedBox(
                                width: 180,
                                height: 250,
                                child: const Center(
                                  child: CupertinoActivityIndicator(),
                                ),
                              ),
                              errorWidget: (context, url, error) => Container(
                                width: 190,
                                height: 250,
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(
                                        'assets/images/img_not_found.jpg'),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          width: 180,
                          child: Text(
                            movie.title!.toUpperCase(),
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.black45,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Muli',
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Container(
                          child: Row(
                            children: [
                              const Icon(
                                Icons.star,
                                color: Colors.yellow,
                                size: 14,
                              ),
                              const Icon(
                                Icons.star,
                                color: Colors.yellow,
                                size: 14,
                              ),
                              const Icon(
                                Icons.star,
                                color: Colors.yellow,
                                size: 14,
                              ),
                              const Icon(
                                Icons.star,
                                color: Colors.yellow,
                                size: 14,
                              ),
                              const Icon(
                                Icons.star,
                                color: Colors.yellow,
                                size: 14,
                              ),
                              Text(
                                movie.voteAverage.toString(),
                                style: const TextStyle(color: Colors.black45),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
              );
            }
            return Container();
          }),
        ),
      ],
    );
  }
}
