import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'fetchData.dart';
import 'dataClasses.dart';
import 'database.dart';
import 'constants.dart' as Constants;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Project Spori',
      theme: ThemeData(
        primaryColor: Color(0xFF228B22),
        accentColor: Color(0xFF2E8B57),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final CameraDescription camera;

  const MyHomePage({
    Key key,
    this.camera,
  }) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  CameraController _controller;
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

  Widget _buildProductCard(AsyncSnapshot<Product> snapshot) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            Center(
              child: Text(
                '${snapshot.data.name}',
                style: Constants.headerTextStyle,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Center(
                      child: Text('Einkunn: ',
                          style: Constants.defaultTextStyle),
                    ),
                  ],
                ),
                Column(
                  children: <Widget>[
                    Center(
                        child: Constants.gradeText(snapshot.data.grade)
                    ),
                  ],
                ),
              ],
            ),
            Center(
              child: OutlineButton(
                child: Text('Meiri upplýsingar'),
                highlightedBorderColor: Constants.primaryColor,
                onPressed: () => Constants.pushDetail(context, snapshot.data),
              ),
            ),
          ],
        ),
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
            onPressed: () => Constants.pushHistory(context),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(25.0),
        child: Column(
          children: <Widget>[
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
                          children = <Widget>[_buildProductCard(snapshot)];
                        } else if (snapshot.hasError) {
                          print('ERRORR EERROORR: ${snapshot.error.toString()}');
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
                              color: Color(0xFF228B22),
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
                            Color(0xFF22AB22),
                            Color(0xFF228B22),
                          ],
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 50),
                      child: const Text('Skanna strikamerki',
                          style: TextStyle(fontSize: 20)),
                    ),
                  ),
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

    setState(() {
      _barcode = barcode;
      _product = prod;
    });

    // Image img = Image.network('https://cdn.aha.is/media/catalog/product/cache/1/image/752x501/4137793dd7223b9146d9dcb53ced065c/i/m/image_6084_1_11_1_181_1_128_1_51_1_2_1_8_1_25_1_10_1_6_2_7_1_8_1_1_1_22_1_7_1_1_2_5_1_14_1_8_1_16_1_16_1_6_1_4_2_2_1_8_1_17_1_4_1_4_1_8_1_5_1_11_1_3_1_6_1_2_1_3_1_4_1_1_2_3_1_1_1_16_2_6_1_3_1_21_1_5_1_8_1_4_1_3_1_2_1_8_3_4_1_921_2_2140_1_831.jpg');
    Product product = await prod;
    saveProduct(product);
  }
}
