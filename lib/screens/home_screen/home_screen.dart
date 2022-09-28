// ignore_for_file: prefer_const_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app_api/screens/category_screen/category_screen.dart';

import '../../bloc/movie_blocs/movie_bloc.dart';
import '../../models/movie.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const Icon(
          Icons.menu,
          color: Colors.black,
        ),
        title: Text(
          'Movies'.toUpperCase(),
          style: Theme.of(context).textTheme.caption!.copyWith(
                color: Colors.black45,
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: 'Muli',
              ),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(
              right: 15,
            ),
            child: const CircleAvatar(
              backgroundImage: AssetImage('assets/images/logo.jpg'),
            ),
          )
        ],
      ),
      body: _buildBody(),
    );
  }
}

Widget _buildBody() {
  return LayoutBuilder(
    builder: ((BuildContext context, BoxConstraints constraints) {
      return SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: constraints.maxHeight,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BlocBuilder<MovieBloc, MovieState>(
                builder: (context, state) {
                  if (state is MovieLoading) {
                    print('Loading state was called');
                    return const Center(
                      child: Text('MovieLoading'),
                    );
                  } else if (state is MovieLoaded) {
                    List<Movie> movies = state.movieList;
                    print(movies.length);

                    return Column(
                      children: [
                        CarouselSlider.builder(
                          itemCount: movies.length,
                          itemBuilder: ((context, index, realIndex) {
                            Movie movie = movies[index];
                            return GestureDetector(
                              onTap: () {},
                              child: Stack(
                                alignment: Alignment.bottomLeft,
                                children: <Widget>[
                                  ClipRRect(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                    child: CachedNetworkImage(
                                      imageUrl:
                                          'https://image.tmdb.org/t/p/original/${movie.backdropPath}',
                                      height:
                                          MediaQuery.of(context).size.height /
                                              3,
                                      width: MediaQuery.of(context).size.width,
                                      fit: BoxFit.cover,
                                      placeholder: (context, url) =>
                                          CupertinoActivityIndicator(),
                                      errorWidget: (context, url, error) =>
                                          Container(
                                        // ignore: prefer_const_constructors
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: AssetImage(
                                                'assets/images/img_not_found.jpg'),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                      bottom: 15,
                                      left: 15,
                                    ),
                                    child: Text(
                                      movie.title!.toUpperCase(),
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        fontFamily: 'Muli',
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                          options: CarouselOptions(
                            enableInfiniteScroll: true,
                            autoPlay: true,
                            autoPlayInterval: Duration(seconds: 5),
                            autoPlayAnimationDuration:
                                Duration(milliseconds: 800),
                            pauseAutoPlayOnTouch: true,
                            viewportFraction: 0.8,
                            enlargeCenterPage: true,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 12,
                              ),
                              BuildWidgetCategory(),
                            ],
                          ),
                        ),
                      ],
                    );
                  } else {
                    return Container();
                  }
                },
              ),
            ],
          ),
        ),
      );
    }),
  );
}
