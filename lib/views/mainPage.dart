import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:barcode_scan/barcode_scan.dart';
import '../fetchData.dart';
import '../dataClasses.dart';
import '../database.dart';
import '../constants.dart' as Constants;

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
                      child:
                          Text('Einkunn: ', style: Constants.defaultTextStyle),
                    ),
                  ],
                ),
                Column(
                  children: <Widget>[
                    Center(child: Constants.gradeText(snapshot.data.grade)),
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
      //backgroundColor: Color(0xFFF1F8E9),
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
                          print(
                              'ERRORR EERROORR: ${snapshot.error.toString()}');
                          children = <Widget>[
                            Icon(
                              Icons.error_outline,
                              color: Colors.red,
                              size: 80,
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
                              color: Constants.primaryColor,
                              size: 80,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 16),
                              child: Text('Vinsamlegast skannaðu vöru.'),
                            )
                          ];
                        } else {
                          children = <Widget>[
                            SizedBox(
                              child: CircularProgressIndicator(
                                valueColor: new AlwaysStoppedAnimation<Color>(
                                    Constants.primaryColor),
                              ),
                              width: 80,
                              height: 80,
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
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: <Color>[
                            Color(0xFFAED581),
                            Color(0xFF33691E),
                          ],
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 30, horizontal: 50),
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
      _product = prod;
    });

    // Wait for product and then save to history
    Product product = await prod;
    saveProduct(product);
  }
}
