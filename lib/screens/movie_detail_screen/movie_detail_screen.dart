import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app_api/bloc/movie_detail_bloc/movie_detail_bloc.dart';
import 'package:movie_app_api/bloc/movie_detail_bloc/movie_detail_event.dart';
import 'package:movie_app_api/bloc/movie_detail_bloc/movie_detail_state.dart';
import 'package:movie_app_api/models/screen_shot.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../models/cast.dart';
import '../../models/movie.dart';
import '../../models/movie_detail.dart';

class MovieDetailScreen extends StatelessWidget {
  final Movie movie;
  const MovieDetailScreen({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => MovieDetailBloc()
        ..add(
          MovieDetailEventStarted(movie.id!),
        ),
      child: WillPopScope(
        child: Scaffold(
          body: _buildDetailBody(context),
        ),
        onWillPop: () async => true,
      ),
    );
  }

  Widget _buildDetailBody(BuildContext context) {
    return BlocBuilder<MovieDetailBloc, MovieDetailState>(
        builder: ((context, state) {
      if (state is MovieDetailLoadingState) {
        return const Center(
          child: CupertinoActivityIndicator(),
        );
      } else if (state is MovieDetailLoadedState) {
        MovieDetail movieDetail = state.movieDetailList;

        return SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  ClipPath(
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                      ),
                      child: CachedNetworkImage(
                        imageUrl:
                            'https://image.tmdb.org/t/p/original/${movieDetail.backdropPath}',
                        height: MediaQuery.of(context).size.height / 2,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        placeholder: (context, url) =>
                            const CupertinoActivityIndicator(),
                        errorWidget: ((context, url, error) => Container(
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(
                                      'assets/images/img_not_found.jpg'),
                                ),
                              ),
                            )),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppBar(
                          backgroundColor: Colors.transparent,
                          elevation: 0,
                        ),
                        Container(
                          padding: const EdgeInsets.only(
                            top: 120,
                          ),
                          child: GestureDetector(
                            onTap: () async {
                              final ytbUrl =
                                  'https://www.youtube.com/watch?v=${movieDetail.trailerId}';

                              if (await canLaunchUrlString(ytbUrl)) {
                                await launchUrlString(ytbUrl);
                              }
                            },
                            child: Center(
                              child: Column(
                                children: [
                                  const Icon(
                                    Icons.play_circle_fill_outlined,
                                    color: Colors.yellow,
                                    size: 65,
                                  ),
                                  Text(
                                    movieDetail.title.toUpperCase(),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Muli',
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 160,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Overview'.toUpperCase(),
                              style:
                                  Theme.of(context).textTheme.caption!.copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),

                        SizedBox(
                          height: 35,
                          child: Text(
                            movieDetail.overview,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontFamily: 'Muli',
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Release date'.toUpperCase(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .caption!
                                        .copyWith(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12,
                                          fontFamily: 'Muli',
                                        ),
                                  ),
                                  Text(
                                    movieDetail.releaseDate,
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle2!
                                        .copyWith(
                                          color: Colors.yellow[800],
                                          fontSize: 12,
                                          fontFamily: 'Muli',
                                        ),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'run time'.toUpperCase(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .caption!
                                        .copyWith(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12,
                                          fontFamily: 'Muli',
                                        ),
                                  ),
                                  Text(
                                    movieDetail.runtime,
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle2!
                                        .copyWith(
                                          color: Colors.yellow[800],
                                          fontSize: 12,
                                          fontFamily: 'Muli',
                                        ),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'budget'.toUpperCase(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .caption!
                                        .copyWith(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12,
                                          fontFamily: 'Muli',
                                        ),
                                  ),
                                  Text(
                                    movieDetail.budget,
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle2!
                                        .copyWith(
                                          color: Colors.yellow[800],
                                          fontSize: 12,
                                          fontFamily: 'Muli',
                                        ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Screenshot'.toUpperCase(),
                          style: Theme.of(context).textTheme.caption!.copyWith(
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Muli',
                              ),
                        ),
                        // ElevatedButton(
                        //     onPressed: () {
                        //       print('${movieDetail.movieImage}');
                        //     },
                        //     child: Text('Text')),
                        SizedBox(
                          height: 155,
                          child: ListView.separated(
                            itemCount: movieDetail.movieImage!.backdrops.length,
                            separatorBuilder: (context, index) =>
                                const VerticalDivider(
                              color: Colors.transparent,
                              width: 5,
                            ),
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              Screenshot image =
                                  movieDetail.movieImage!.backdrops[index];
                              return Container(
                                child: Card(
                                  elevation: 3,
                                  borderOnForeground: true,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: CachedNetworkImage(
                                      errorWidget: (context, url, error) =>
                                          const Center(
                                        child: Text('error'),
                                      ),
                                      placeholder: (context, url) =>
                                          const Center(
                                        child: CupertinoActivityIndicator(),
                                      ),
                                      imageUrl:
                                          'https://image.tmdb.org/t/p/w500/${image.imagePath}',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Casts'.toUpperCase(),
                          style: Theme.of(context).textTheme.caption!.copyWith(
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Muli',
                              ),
                        ),
                        SizedBox(
                          height: 110,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemCount: movieDetail.castList.length,
                            separatorBuilder: (context, index) =>
                                const VerticalDivider(
                              color: Colors.transparent,
                              width: 5,
                            ),
                            itemBuilder: (context, index) {
                              Cast cast = movieDetail.castList[index];
                              return Container(
                                child: Column(
                                  children: [
                                    Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                      ),
                                      elevation: 3,
                                      child: ClipRRect(
                                        child: CachedNetworkImage(
                                          imageUrl:
                                              'https://image.tmdb.org/t/p/w200/${cast.profilePath}',
                                          imageBuilder:
                                              (context, imageProvider) {
                                            // print(imageProvider);
                                            return Container(
                                              height: 80,
                                              width: 80,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    const BorderRadius.all(
                                                  Radius.circular(
                                                    100,
                                                  ),
                                                ),
                                                image: DecorationImage(
                                                  image: imageProvider,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            );
                                          },
                                          placeholder: (context, url) {
                                            // print('This is $url ');
                                            return const SizedBox(
                                              height: 80,
                                              width: 80,
                                              child: Center(
                                                child:
                                                    CupertinoActivityIndicator(),
                                              ),
                                            );
                                          },
                                          errorWidget: (context, url, error) {
                                            return Container(
                                              width: 80,
                                              height: 80,
                                              decoration: const BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(50)),
                                                image: DecorationImage(
                                                  fit: BoxFit.contain,
                                                  image: AssetImage(
                                                      'assets/images/img_not_found.jpg'),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 100,
                                      child: Center(
                                        child: Wrap(children: [
                                          Text(
                                            cast.character.toUpperCase(),
                                            maxLines: 2,
                                            style: const TextStyle(
                                              color: Colors.black54,
                                              fontSize: 8,
                                              fontFamily: 'Muli',
                                            ),
                                          ),
                                        ]),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              )
            ],
          ),
        );
      } else {
        return Container(
          child: const Text('err'),
        );
      }
    }));
  }
}
