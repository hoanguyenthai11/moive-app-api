// ignore_for_file: prefer_const_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app_api/screens/category_screen/category_screen.dart';
import 'package:movie_app_api/screens/movie_detail_screen/movie_detail_screen.dart';

import '../../bloc/movie_blocs/movie_bloc.dart';
import '../../bloc/person_bloc/person_bloc.dart';
import '../../bloc/person_bloc/person_event.dart';
import '../../bloc/person_bloc/person_state.dart';
import '../../models/movie.dart';
import '../../models/person.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => MovieBloc()..add(MovieEventStarted(0, '')),
        ),
        BlocProvider(
          create: (_) => PersonBloc()..add(PersonStartedEvent()),
        ),
      ],
      child: Scaffold(
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
      ),
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
                    return const Center(
                      child: CupertinoActivityIndicator(),
                    );
                  } else if (state is MovieLoaded) {
                    List<Movie> movies = state.movieList;
                    return SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        children: [
                          CarouselSlider.builder(
                            itemCount: movies.length,
                            itemBuilder: ((context, index, realIndex) {
                              Movie movie = movies[index];
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              MovieDetailScreen(movie: movie)));
                                },
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
                                        width:
                                            MediaQuery.of(context).size.width,
                                        fit: BoxFit.fill,
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
                                Text(
                                  'Trending persons om this week'.toUpperCase(),
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black45,
                                      fontFamily: 'Muli'),
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                Column(
                                  children: [
                                    BlocBuilder<PersonBloc, PersonState>(
                                      builder: ((context, state) {
                                        if (state is PersonLoadingState) {
                                          return Center(
                                            child: CupertinoActivityIndicator(),
                                          );
                                        } else if (state is PersonLoadedState) {
                                          List<Person> personal =
                                              state.personList;
                                          return SizedBox(
                                            height: 110,
                                            child: ListView.separated(
                                              itemCount: personal.length,
                                              scrollDirection: Axis.horizontal,
                                              separatorBuilder:
                                                  (context, index) =>
                                                      VerticalDivider(
                                                color: Colors.transparent,
                                                width: 5,
                                              ),
                                              itemBuilder: (context, index) {
                                                Person person = personal[index];

                                                return Container(
                                                  child: Column(
                                                    children: [
                                                      Card(
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      100),
                                                        ),
                                                        elevation: 3,
                                                        child: ClipRRect(
                                                          child: person
                                                                  .profilePath
                                                                  .isEmpty
                                                              ? Container(
                                                                  width: 80,
                                                                  height: 80,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.all(
                                                                            Radius.circular(50)),
                                                                    image:
                                                                        DecorationImage(
                                                                      fit: BoxFit
                                                                          .contain,
                                                                      image: AssetImage(
                                                                          'assets/images/img_not_found.jpg'),
                                                                    ),
                                                                  ),
                                                                )
                                                              : CachedNetworkImage(
                                                                  errorWidget: (context,
                                                                          url,
                                                                          error) =>
                                                                      Container(
                                                                    width: 80,
                                                                    height: 80,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.all(
                                                                              Radius.circular(50)),
                                                                      image:
                                                                          DecorationImage(
                                                                        fit: BoxFit
                                                                            .contain,
                                                                        image: AssetImage(
                                                                            'assets/images/img_not_found.jpg'),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  imageUrl:
                                                                      'https://image.tmdb.org/t/p/w300/${person.profilePath}',
                                                                  imageBuilder:
                                                                      (context,
                                                                          imageProvider) {
                                                                    // print(
                                                                    //     'imageprovider $imageProvider');
                                                                    return Container(
                                                                      height:
                                                                          80,
                                                                      width: 80,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.all(
                                                                          Radius.circular(
                                                                              100),
                                                                        ),
                                                                        image:
                                                                            DecorationImage(
                                                                          image:
                                                                              imageProvider,
                                                                          fit: BoxFit
                                                                              .cover,
                                                                        ),
                                                                      ),
                                                                    );
                                                                  },
                                                                  placeholder:
                                                                      (context,
                                                                          url) {
                                                                    return Container(
                                                                      width: 80,
                                                                      height:
                                                                          80,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.all(Radius.circular(50)),
                                                                        image:
                                                                            DecorationImage(
                                                                          fit: BoxFit
                                                                              .contain,
                                                                          image:
                                                                              AssetImage('assets/images/img_not_found.jpg'),
                                                                        ),
                                                                      ),
                                                                      child: Center(
                                                                          child:
                                                                              CupertinoActivityIndicator()),
                                                                    );
                                                                  },
                                                                ),
                                                        ),
                                                      ),
                                                      Container(
                                                        child: Center(
                                                          child: Text(
                                                            person.name
                                                                .toUpperCase(),
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black45,
                                                                fontSize: 8,
                                                                fontFamily:
                                                                    'Muli'),
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        child: Center(
                                                          child: Text(
                                                            person
                                                                .knowForDepartment
                                                                .toUpperCase(),
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black45,
                                                                fontSize: 8,
                                                                fontFamily:
                                                                    'Muli'),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              },
                                            ),
                                          );
                                        } else {
                                          return Container();
                                        }
                                      }),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  } else {
                    return Container();
                  }
                },
              ),
              const SizedBox(
                height: 50,
              )
            ],
          ),
        ),
      );
    }),
  );
}
