import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:quadb_tech/models/movie_model.dart';
import 'package:quadb_tech/screens/show_details_screen.dart';

class SearchResults extends StatefulWidget {
  final String searchedString;
  const SearchResults({required this.searchedString, super.key});

  @override
  State<SearchResults> createState() => _SearchResultsState();
}

class _SearchResultsState extends State<SearchResults> {
  Future<List<MovieModel>> getMoviesBySearch(String searchedString) async {
    List<MovieModel> movieListBySearch = [];
    final response = await http.get(Uri.parse(
        "https://api.tvmaze.com/search/shows?q=${widget.searchedString}"));
    var data = jsonDecode(response.body); //try .toString()
    if (response.statusCode == 200) {
      for (Map<String, dynamic> item in data) {
        // print(item['name']);
        movieListBySearch.add(MovieModel.fromJson(item));
      }
      return movieListBySearch;
    } else {
      return movieListBySearch;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Search Results for ${widget.searchedString}"),
          backgroundColor: Colors.black,
        ),
        body: Center(
          child: FutureBuilder(
              future: getMoviesBySearch(widget.searchedString),
              builder: ((context, AsyncSnapshot<List<MovieModel>> snapshot) {
                if (snapshot.hasData &&
                    snapshot.data != null &&
                    snapshot.data!.isNotEmpty) {
                  return GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              mainAxisSpacing: 5,
                              childAspectRatio: 0.65,
                              crossAxisCount: 3),
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        MovieModel movieModel = snapshot.data![index];
                        MovieImage? movieImage;
                        String? movieName = "Show name unavailable";
                        List<String>? movieGenreList = [];

                        if (movieModel.show != null) {
                          movieImage = movieModel.show!.image;
                          movieName = movieModel.show!.name;
                          movieGenreList = movieModel.show!.genres;
                        }
                        //Rendering Cards of respective shows
                        return InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    ShowDetailsScreen(movieModel: movieModel)));
                          },
                          child: Card(
                            // margin: const EdgeInsets.all(5.0),
                            shape: RoundedRectangleBorder(
                                side: const BorderSide(
                                    color: Colors.white10, width: 2),
                                borderRadius: BorderRadius.circular(20)),
                            color: Colors.black,
                            clipBehavior: Clip.hardEdge,
                            child: Column(
                              children: [
                                //thumbnail/image
                                AspectRatio(
                                  aspectRatio: 450 / 451,
                                  child: movieImage != null
                                      ?
                                      // thumbnail available
                                      Container(
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                            fit: BoxFit.fitWidth,
                                            alignment:
                                                FractionalOffset.topCenter,
                                            image: NetworkImage(
                                                movieImage.medium!),
                                          )),
                                        )
                                      :
                                      // when thumbnail is not available
                                      Container(
                                          alignment: Alignment.center,
                                          decoration: const BoxDecoration(
                                              color: Colors.white24),
                                          child: Text(
                                            movieName!,
                                            style:
                                                TextStyle(color: Colors.white),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                ),
                                const SizedBox(height: 5),
                                //name/title
                                Container(
                                  alignment: Alignment.centerLeft,
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  child: Text(
                                    "$movieName",
                                    overflow: TextOverflow.fade,
                                    maxLines: 2,
                                    style: const TextStyle(
                                        fontSize: 17, color: Colors.white),
                                  ),
                                ),
                                //genre
                                Container(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    overflow: TextOverflow.fade,
                                    maxLines: 1,
                                    movieGenreList!.join(" | "),
                                    style: TextStyle(
                                        color: Colors.red[400], fontSize: 14),
                                  ),
                                ),
                                const SizedBox(height: 2),
                              ],
                            ),
                          ),
                        );
                      });
                } else if (snapshot.hasError) {
                  // print("\nsnapshot has error: ${snapshot.error}");
                  return Center(child: Text('${snapshot.error}'));
                } else {
                  // print("\nsnapshot is loading");
                  return const Center(
                    child: CircularProgressIndicator(color: Colors.amber),
                  );
                }
              })),
        ));
  }
}
