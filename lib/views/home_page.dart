import 'package:flutter/material.dart';
import 'package:library_frontend/models/book.dart';
import 'package:library_frontend/services/rest_api/book_api.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:library_frontend/widgets/book_description.dart';


class Home extends StatefulWidget {

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  BookApi bookApi;


  @override
  void initState() {
    bookApi = BookApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      color: Colors.white,

      child: FutureBuilder(
          future: bookApi.getBooks(),
          builder: (context, AsyncSnapshot<List<Book>> data) {

            if (data.data == null || data == null) {
              return Center(
                child: CircularProgressIndicator(),
              );

            } else {

              return StaggeredGridView.countBuilder(
                  crossAxisCount: 4,
                  itemCount: (data.data == null) ? 0 : data.data.length,
                  itemBuilder: (context, index) {

                    return Card(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: GestureDetector(
                          child: Image.network(
                              '${bookApi.urlServer}/download/${data.data[index].cover}'
                          ),

                          onTap: () {
                            Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (BuildContext context) {
                                      return BookDescription(book: data.data[index]);
                                    })
                            );},
                        ),
                      ),
                    );},

                  staggeredTileBuilder: (int index) => StaggeredTile.fit(2)
              );
            }
          }),
    );

  }
}
