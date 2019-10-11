import 'package:flutter/material.dart';
import '../services/giphy_service.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  String _search;

  Widget _createGifTable(context, snapshot) {
    return GridView.builder(
        padding: EdgeInsets.all(10.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, crossAxisSpacing: 10.0, mainAxisSpacing: 10.0),
        itemCount: snapshot.data["data"].length,
        itemBuilder: (context, index) {
          return GestureDetector(
            child: Image.network(
              snapshot.data["data"][index]["images"]["fixed_height"]["url"],
              height: 300.0,
              fit: BoxFit.cover,
            ),
          );
        });
  }

  @override
  void initState() {
    super.initState();
    GiphyService.getGifs(_search).then((map) => {print(map)});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: Column(
        children: <Widget>[
          TextField(
            decoration: InputDecoration(
              labelText: "Pesquise aqui",
              labelStyle: TextStyle(color: Colors.white),
              border: OutlineInputBorder(),
            ),
            style: TextStyle(color: Colors.white, fontSize: 18.0),
            textAlign: TextAlign.center,
            onSubmitted: (text) {
              setState(() {
                _search = text;
              });
            },
          ),
          Expanded(
            child: FutureBuilder(
                future: GiphyService.getGifs(_search),
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                    case ConnectionState.none:
                      return Container(
                        width: 200.0,
                        height: 200.0,
                        alignment: Alignment.center,
                        child: CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                          strokeWidth: 5.0,
                        ),
                      );
                    default:
                      if (snapshot.hasError)
                        return new Container();
                      else
                        return _createGifTable(context, snapshot);
                  }
                }),
          )
        ],
      ),
    );
  }
}
