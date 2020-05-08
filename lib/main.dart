import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:projectspori/historyPage.dart';
import 'detailPage.dart';
import 'fetchData.dart';
import 'dataClasses.dart';
import 'constants.dart' as Constants;

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
  Future<Product> _product;
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

  Widget _buildForm(AsyncSnapshot<Product> snapshot) {
    _history.add(snapshot.data);
    return Card(
      child: Column(
        children: <Widget>[
          Center(
            child: Text(
              '${snapshot.data.name}',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
          ),
          Center(
              child: Text(
            '${snapshot.data.grade.toStringAsPrecision(3)}',
            style: (() {
              if (snapshot.data.grade < 3.33) {
                return TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.red);
              } else if (snapshot.data.grade < 6.66) {
                return TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.yellow);
              } else {
                return TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.green);
              }
            }()),
          )),
          Center(
            child: OutlineButton(
              child: Text('More Details'),
              onPressed: () => Constants.pushDetail(context, snapshot.data),
            ),
          ),
        ],
      ),
    );
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
            icon: Icon(Icons.search),
            onPressed: () => Constants.pushSearch(context),
          ),
          IconButton(
            icon: Icon(Icons.history),
            onPressed: () => Constants.pushHistory(context, _history),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(25.0),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Center(
                  child: RaisedButton(
                    onPressed: getProduct,
                    textColor: Colors.white,
                    padding: const EdgeInsets.all(0.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      side: BorderSide(color: Colors.black45),
                    ),
                    child: Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        gradient: LinearGradient(
                          colors: <Color>[
                            Color(0xFF005105),
                            Color(0xFF009B0A),
                          ],
                        ),
                      ),
                      padding: const EdgeInsets.all(10.0),
                      child: const Text('Skanna vöru',
                          style: TextStyle(fontSize: 20)),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                if (_barcode.length != 0) Center(child: Text('$_barcode')),
              ],
            ),
            Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 100.0),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    FutureBuilder<Product>(
                      future: _product,
                      builder: (BuildContext context,
                          AsyncSnapshot<Product> snapshot) {
                        List<Widget> children;

                        if (snapshot.hasData) {
                          children = <Widget>[_buildForm(snapshot)];
                        } else if (snapshot.hasError) {
                          children = <Widget>[
                            Icon(
                              Icons.error_outline,
                              color: Colors.red,
                              size: 60,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 16),
                              child: Text('Vara fannst ekki'),
                            ),
                          ];
                        } else if (snapshot.connectionState ==
                            ConnectionState.none) {
                          children = <Widget>[
                            Icon(
                              Icons.info_outline,
                              color: Colors.green,
                              size: 60,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 16),
                              child: Text('Vinsamlegast skannaðu vöru.'),
                            )
                          ];
                        } else {
                          children = <Widget>[
                            SizedBox(
                              child: CircularProgressIndicator(),
                              width: 60,
                              height: 60,
                            ),
                            const Padding(
                              padding: EdgeInsets.only(top: 16),
                              child: Text('Bíðið andartak...'),
                            )
                          ];
                        }
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: children,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> getProduct() async {
    String barcode = await BarcodeScanner.scan();
    Future<Product> prod = fetchProduct(barcode);
    // Image img = Image.network('https://cdn.aha.is/media/catalog/product/cache/1/image/752x501/4137793dd7223b9146d9dcb53ced065c/i/m/image_6084_1_11_1_181_1_128_1_51_1_2_1_8_1_25_1_10_1_6_2_7_1_8_1_1_1_22_1_7_1_1_2_5_1_14_1_8_1_16_1_16_1_6_1_4_2_2_1_8_1_17_1_4_1_4_1_8_1_5_1_11_1_3_1_6_1_2_1_3_1_4_1_1_2_3_1_1_1_16_2_6_1_3_1_21_1_5_1_8_1_4_1_3_1_2_1_8_3_4_1_921_2_2140_1_831.jpg');

    setState(() {
      _barcode = barcode;
      _product = prod;
    });
  }
}
