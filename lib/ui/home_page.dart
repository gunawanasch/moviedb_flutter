import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviedb_flutter/bloc/popular_movies_bloc.dart';
import 'package:moviedb_flutter/bloc/movies_event.dart';
import 'package:moviedb_flutter/bloc/movies_state.dart';
import 'package:moviedb_flutter/bloc/upcoming_movies_bloc.dart';
import 'package:moviedb_flutter/data/movies_repository.dart';
import 'package:moviedb_flutter/model/popular_movies_model.dart';
import 'package:moviedb_flutter/model/upcoming_movies_model.dart';
import 'package:moviedb_flutter/ui/popular_movies_detail_page.dart';
import 'package:moviedb_flutter/ui/upcoming_movies_detail_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Movie DB"),
      ),
      body: Container(
        child: BlocProvider(
            create: (_) => UpcomingMoviesBloc(MoviesRepository())..add(GetUpcomingMovies()),
            child: BlocBuilder<UpcomingMoviesBloc, MoviesState>(
              // ignore: missing_return
              builder: (context, state) {
                if (state is MoviesInitial) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is MoviesLoading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is UpcomingMoviesSuccess) {
                  return ListView.builder(
                    itemBuilder: (BuildContext context, int index) {
                      if (index == 0) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 5.0),
                              child: Text("Popular Movies",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            listViewPopularMovies(),
                            Container(
                              padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 5.0),
                              child: Text("Upcoming Movies",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            UpcomingMoviesRow(resultsUpcomingMovies: state.upcomingMoviesModel.results[index]),
                          ],
                        );
                      } else {
                        return UpcomingMoviesRow(resultsUpcomingMovies: state.upcomingMoviesModel.results[index]);
                      }
                    },
                    itemCount: state.upcomingMoviesModel.results.length,
                  );
                } else if (state is MoviesError) {
                  return Center(child: Text("Cannot display data"));
                }
              },
            ),
        ),
      ),
    );
  }

  Widget listViewPopularMovies() {
    return Container(
      height: MediaQuery.of(context).size.height/3,
      child: BlocProvider(
        create: (_) => PopularMoviesBloc(MoviesRepository())..add(GetPopularMovies()),
        child: BlocBuilder<PopularMoviesBloc, MoviesState>(
          // ignore: missing_return
          builder: (context, state) {
            if (state is MoviesInitial) {
              return Center(child: CircularProgressIndicator());
            } else if (state is MoviesLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is PopularMoviesSuccess) {
              return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return PopularMoviesRow(resultsPopularMovies: state.popularMoviesModel.results[index]);
                  },
                  itemCount: state.popularMoviesModel.results.length,
              );
            } else if (state is MoviesError) {
              return Center(child: Text("Cannot display data"));
            }
          },
        ),
      ),
    );
  }

}

class PopularMoviesRow extends StatelessWidget {
  PopularMoviesRow({Key key, this.resultsPopularMovies}) : super(key: key);
  final ResultsPopularMovies resultsPopularMovies;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return PopularMoviesDetailPage(resultsPopularMovies: resultsPopularMovies);
            }
        ));
      },
      child: Container(
        width: MediaQuery.of(context).size.width/3,
        margin: EdgeInsets.only(left: 5.0, right: 5.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              child: Container(
                height: MediaQuery.of(context).size.height/3.5,
                width: MediaQuery.of(context).size.width/3,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  image: DecorationImage(
                    image: resultsPopularMovies.posterPath != null ? NetworkImage("https://image.tmdb.org/t/p/w500"+resultsPopularMovies.posterPath) : AssetImage("ic_image.png"),
                    fit: resultsPopularMovies.posterPath != null ? BoxFit.cover : BoxFit.contain,
                  ),
                ),
              ),
            ),
            SizedBox(height: 5),
            Container(
              width: MediaQuery.of(context).size.width/3,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Text(
                        resultsPopularMovies.title,
                        maxLines: 1,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class UpcomingMoviesRow extends StatelessWidget {
  UpcomingMoviesRow({Key key, this.resultsUpcomingMovies}) : super(key: key);
  final ResultsUpcomingMovies resultsUpcomingMovies;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return UpcomingMoviesDetailPage(resultsUpcomingMovies: resultsUpcomingMovies);
            }
        ));
      },
      child: Container(
        height: 150,
        padding: EdgeInsets.all(5.0),
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: MediaQuery.of(context).size.width/4,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.horizontal(left: Radius.circular(10)),
                  image: DecorationImage(
                    image: resultsUpcomingMovies.posterPath != null ? NetworkImage("https://image.tmdb.org/t/p/w500"+resultsUpcomingMovies.posterPath) : AssetImage("ic_image.png"),
                    fit: resultsUpcomingMovies.posterPath != null ? BoxFit.cover : BoxFit.contain,
                  ),
                ),
              ),
              Expanded(
                  child: Container(
                    padding: EdgeInsets.all(6.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          resultsUpcomingMovies.title,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          resultsUpcomingMovies.overview,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 15),
                        ),
                      ],
                    ),
                  )
              ),
            ],
          ),
        ),
      ),
    );
  }
}

