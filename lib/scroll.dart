import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:orderapp/bottomnavigation.dart';
import 'dart:convert';

import 'package:orderapp/dashboard.dart';
import 'package:orderapp/homepage/top_bar.dart';
import 'package:orderapp/homepage/topbar1.dart';
//import 'package:orderapp/bottomnavigation.dart';
//import 'package:orderapp/drawer.dart';

class PhotosListScreen extends StatefulWidget {
  // PhotosListScreen({Key key}) : super(key: key);
  @override
  _PhotosListScreenState createState() => _PhotosListScreenState();
}

class _PhotosListScreenState extends State<PhotosListScreen> {
  late bool _hasMore;
  late int _pageNumber;
  late bool _error;
  late bool _loading;
  final int _defaultPhotosPerPageCount = 10;
  late List<Photo> _photos;
  final int _nextPageThreshold = 5;
  @override
  void initState() {
    super.initState();
    _hasMore = true;
    _pageNumber = 5;
    _error = false;
    _loading = true;
    _photos = [];
    fetchPhotos();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent[700],
        title: TopBar1(),
        // title: Text("Products"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Dashboard()),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigation(),
      body:

          // Column(
          //   mainAxisAlignment: MainAxisAlignment.start,
          //   children: [
          //     // TopBar(),
          //     // Container(
          //     //   padding: EdgeInsets.all(5),
          //     //   color: Colors.grey[350],
          //     //   height: size.height * 0.10,
          //     //   child: Column(
          //     //     children: [
          //     //       Container(
          //     //           padding: EdgeInsets.only(left: 10, right: 10),
          //     //           margin: EdgeInsets.all(5),
          //     //           color: Colors.white,
          //     //           child: Row(
          //     //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     //             children: <Widget>[
          //     //               Container(
          //     //                 width: size.width * 0.7,
          //     //                 child: TextFormField(
          //     //                   decoration: InputDecoration(
          //     //                       border: InputBorder.none,
          //     //                       hintText: 'Search APLORDER Item',
          //     //                       icon: Icon(Icons.search, color: Colors.blue)),
          //     //                   // onChanged: (text) {
          //     //                   //   text.toLowerCase();
          //     //                   //   setState(() {
          //     //                   //     productsdisplay = items3.where((items3) {
          //     //                   //       items3 = items3.toLowerCase();
          //     //                   //       return items3.contains(text);
          //     //                   //     }).toList();
          //     //                   //   });
          //     //                   // },
          //     //                 ),
          //     //               ),
          //     //               Icon(Icons.camera_alt, color: Colors.blue)
          //     //             ],
          //     //           )),
          //     //     ],
          //     //   ),
          //     // ),

          //   ],
          // ),
          getBody(),
    );
  }

  Widget getBody() {
    if (_photos.isEmpty) {
      if (_loading) {
        return Center(
            child: Padding(
          padding: const EdgeInsets.all(8),
          child: CircularProgressIndicator(),
        ));
      } else if (_error) {
        return Center(
            child: InkWell(
          onTap: () {
            setState(() {
              _loading = true;
              _error = false;
              fetchPhotos();
            });
          },
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Text("Error while loading photos, tap to try agin"),
          ),
        ));
      }
    } else {
      return ListView.builder(
          itemCount: _photos.length + (_hasMore ? 1 : 0),
          itemBuilder: (context, index) {
            if (index == _photos.length - _nextPageThreshold) {
              fetchPhotos();
            }
            if (index == _photos.length) {
              if (_error) {
                return Center(
                    child: InkWell(
                  onTap: () {
                    setState(() {
                      _loading = true;
                      _error = false;
                      fetchPhotos();
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text("Error while loading photos, tap to try agin"),
                  ),
                ));
              } else {
                return Center(
                    child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: CircularProgressIndicator(),
                ));
              }
            }
            final Photo photo = _photos[index];

            return Padding(
              padding: const EdgeInsets.all(4.0),
              child: Card(
                child: Column(
                  children: <Widget>[
                    // Image.network(
                    //   photo.itemno,
                    //   fit: BoxFit.fitWidth,
                    //   width: double.infinity,
                    //   height: 160,
                    // ),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text(photo.desc,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(
                            Icons.favorite,
                            color: Colors.red,
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          Icon(
                            Icons.add_circle,
                            color: Colors.green,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          });
    }
    return Container();
  }

  Future<void> fetchPhotos() async {
    try {
      // var url = Uri.parse(
      //     'https://jsonplaceholder.typicode.com/photos?_page=$_pageNumber');
      var url =
          Uri.parse('http://114.143.151.6:901/product-all?limit=$_pageNumber');

      http.Response response;
      response = await http.get(url);
      // final response = await http.get(
      //     "https://jsonplaceholder.typicode.com/photos?_page=$_pageNumber");
      List<Photo> fetchedPhotos = Photo.parseList(json.decode(response.body));
      setState(() {
        _hasMore = fetchedPhotos.length == _defaultPhotosPerPageCount;
        _loading = false;
        _pageNumber = _pageNumber + 1;
        _photos.addAll(fetchedPhotos);
      });
    } catch (e) {
      setState(() {
        _loading = false;
        _error = true;
      });
    }
  }
}

class Photo {
  final String desc;
  // final String itemno;
  Photo(
    this.desc,
  );
  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
      json["desc"],
    );
  }
  static List<Photo> parseList(List<dynamic> list) {
    return list.map((i) => Photo.fromJson(i)).toList();
  }
}
