import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'fetchData.dart';
import 'dataClasses.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Project Spori',
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final CameraDescription camera;

  const MyHomePage({
    Key key,
    @required this.camera,
  }) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  CameraController _controller;
  final Set<Product> _history = Set<Product>();
  String _barcode = '';
  String _name = '';
  num _score = -1;
  Image _image;

  @override
  void initState() {
    super.initState();
    _controller = CameraController(
      widget.camera,
      ResolutionPreset.medium,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("Spori"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.history),
            onPressed: _pushHistory,
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Center(
              // Center is a layout widget. It takes a single child and positions it
              // in the middle of the parent.
              child: OutlineButton(
                child: Text("Skanna vöru"),
                onPressed: getProduct,
              ),
            ),
            if (_name.length != 0)
              Card(
                child: Column(
                  children: <Widget>[
                    if (_barcode.length != 0) Center(child: Text('$_barcode')),
                    if (_name.length != 0)
                      Center(
                        child: Text(
                          '$_name',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 24),
                        ),
                      ),
                    if (_score != -1)
                      Center(
                          child: Text(
                        '$_score',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 24),
                      )),
                  ],
                ),
              ),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void _pushHistory() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context) {
          final Iterable<ListTile> tiles = _history.map((Product prod) {
            return ListTile(
              title: Text(
                prod.name,
              ),
            );
          });
          final List<Widget> divided = ListTile.divideTiles(
            context: context,
            tiles: tiles,
          ).toList();
          return Scaffold(
            appBar: AppBar(
              title: Text('History'),
            ),
            body: ListView(children: divided),
          );
        },
      ),
    );
  }

  Future<void> getProduct() async {
    String barcode = await BarcodeScanner.scan();
    Product prod = await fetchProduct(barcode);
    // Image img = Image.network('https://cdn.aha.is/media/catalog/product/cache/1/image/752x501/4137793dd7223b9146d9dcb53ced065c/i/m/image_6084_1_11_1_181_1_128_1_51_1_2_1_8_1_25_1_10_1_6_2_7_1_8_1_1_1_22_1_7_1_1_2_5_1_14_1_8_1_16_1_16_1_6_1_4_2_2_1_8_1_17_1_4_1_4_1_8_1_5_1_11_1_3_1_6_1_2_1_3_1_4_1_1_2_3_1_1_1_16_2_6_1_3_1_21_1_5_1_8_1_4_1_3_1_2_1_8_3_4_1_921_2_2140_1_831.jpg');

    setState(() {
      _history.add(prod);
      _barcode = barcode;
      _name = prod.name;
      _score = prod.score;
    });
  }
}
