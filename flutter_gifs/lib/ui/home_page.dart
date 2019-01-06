import 'package:flutter/material.dart';
import '../services/giphy_service.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _search;

  @override
  void initState() {
    // var future = GiphyService.getGigsTrending();
    // future.then((value) {
    //   print(value);
    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
