import 'dart:async';
import 'dart:math';

import 'package:fitted_text_field_container/fitted_text_field_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fitted Text Field Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Fitted Text Field Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController _plainCtl;
  TextEditingController _poundCtl;
  TextEditingController _aniDollarCtl;
  TextEditingController _aniDongCtl;
  TextEditingController _aniEuroCtl;
  TextEditingController _aniWholePoundCtl;
  FocusNode _plainFocusNode;
  FocusNode _poundFocusNode;
  FocusNode _aniDollarFocusNode;
  FocusNode _aniDongFocusNode;
  FocusNode _aniEuroFocusNode;
  FocusNode _aniWholePoundFocusNode;

  @override
  void initState() {
    super.initState();
    _plainCtl = TextEditingController();
    _poundCtl = TextEditingController();
    _aniDollarCtl = TextEditingController();
    _aniDongCtl = TextEditingController();
    _aniEuroCtl = TextEditingController();
    _aniWholePoundCtl = TextEditingController();
    _plainFocusNode = FocusNode();
    _poundFocusNode = FocusNode();
    _aniDollarFocusNode = FocusNode();
    _aniDongFocusNode = FocusNode();
    _aniEuroFocusNode = FocusNode();
    _aniWholePoundFocusNode = FocusNode();
    Timer(Duration(milliseconds: 2000), () {
      // Uncomment this for automatic text input
      // runInputer(20);
    });
  }

  final Random rand = Random(DateTime.now().millisecondsSinceEpoch);
  void runInputer(int i) {
    Timer(Duration(milliseconds: 50 + rand.nextInt(500)), () {
      setState(() {
        _plainCtl.text += String.fromCharCode(97 + rand.nextInt(25));
        String num = rand.nextInt(9).toString();
        _poundCtl.text += num;
        _aniDollarCtl.text += num;
        _aniDongCtl.text += num;
        _aniEuroCtl.text += num;
        _aniWholePoundCtl.text += num;
        if (i > 0) {
          runInputer(i - 1);
        } else {
          runDelete(10, 2000);
        }
      });
    });
  }

  void runDelete(int end, int delay) {
    Timer(Duration(milliseconds: delay), () {
      setState(() {
        _plainCtl.text = _plainCtl.text.substring(0, end);
        _poundCtl.text = _poundCtl.text.substring(0, end);
        _aniDollarCtl.text = _aniDollarCtl.text.substring(0, end);
        _aniDongCtl.text = _aniDongCtl.text.substring(0, end);
        _aniEuroCtl.text = _aniEuroCtl.text.substring(0, end);
        _aniWholePoundCtl.text = _aniWholePoundCtl.text.substring(0, end);
        if (_plainCtl.text.length > 0) {
          runDelete(_plainCtl.text.length - 1,
              ((600 / 10) * end).round() + rand.nextInt(300) + 300);
        } else {
          Timer(Duration(milliseconds: 2000), () {
            runInputer(20);
          });
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView(
        padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 50),
        children: <Widget>[
          Text(
            'Static examples',
            style: Theme.of(context).textTheme.headline4,
          ),
          Fit(
            child: TextField(
              controller: _plainCtl,
              style: TextStyle(fontSize: 16),
              focusNode: _plainFocusNode,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.text,
              textAlign: TextAlign.left,
              maxLines: null,
              onSubmitted: (String value) {
                FocusScope.of(context).requestFocus(_poundFocusNode);
              },
            ),
          ),
          Fit(
            child: TextField(
              controller: _poundCtl,
              style: TextStyle(fontSize: 26),
              focusNode: _poundFocusNode,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              maxLines: null,
              inputFormatters: [
                WhitelistingTextInputFormatter(RegExp(r"\d+\.?\d*")),
              ],
              textAlign: TextAlign.right,
              decoration: InputDecoration(
                prefixText: "£",
                hintText: "0",
              ),
              onSubmitted: (String value) {
                FocusScope.of(context).requestFocus(_aniDollarFocusNode);
              },
            ),
          ),
          Text(
            'Animated examples',
            style: Theme.of(context).textTheme.headline4,
          ),
          AnimFit(
            child: TextField(
              controller: _aniDollarCtl,
              style: TextStyle(fontSize: 16),
              focusNode: _aniDollarFocusNode,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [
                WhitelistingTextInputFormatter(RegExp(r"\d+\.?\d*")),
              ],
              textAlign: TextAlign.right,
              decoration: InputDecoration(
                prefixText: "\$",
                hintText: "0",
              ),
              onSubmitted: (String value) {
                FocusScope.of(context).requestFocus(_aniEuroFocusNode);
              },
            ),
          ),
          AnimFit(
            child: TextField(
              controller: _aniEuroCtl,
              style: TextStyle(fontSize: 26),
              focusNode: _aniEuroFocusNode,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [
                WhitelistingTextInputFormatter(RegExp(r"\d+\.?\d*")),
              ],
              textAlign: TextAlign.right,
              decoration: InputDecoration(
                suffixText: "€",
              ),
              onSubmitted: (String value) {
                FocusScope.of(context).requestFocus(_aniDongFocusNode);
              },
            ),
          ),
          AnimFit(
            child: TextField(
              controller: _aniDongCtl,
              style: TextStyle(fontSize: 26),
              focusNode: _aniDongFocusNode,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.number,
              inputFormatters: [
                WhitelistingTextInputFormatter(RegExp(r"\d+")),
              ],
              textAlign: TextAlign.right,
              decoration: InputDecoration(
                suffixText: " ₫",
                hintText: "0",
              ),
              onSubmitted: (String value) {
                FocusScope.of(context).requestFocus(_aniWholePoundFocusNode);
              },
            ),
          ),
          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: AnimatedFittedTextFieldContainer(
                growDuration: Duration(milliseconds: 300),
                shrinkDuration: Duration(milliseconds: 600),
                growCurve: Curves.easeOutCirc,
                shrinkCurve: Curves.easeInCirc,
                child: TextField(
                  controller: _aniWholePoundCtl,
                  style: TextStyle(fontSize: 26),
                  focusNode: _aniWholePoundFocusNode,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    WhitelistingTextInputFormatter(RegExp(r"\d+")),
                  ],
                  textAlign: TextAlign.right,
                  decoration: InputDecoration(
                    prefixText: "£",
                    suffixText: ".00",
                    hintText: "0",
                  ),
                  onChanged: (value) => setState(() {}),
                  onSubmitted: (String value) {
                    FocusScope.of(context).requestFocus(_plainFocusNode);
                  },
                ),
                builder: (context, child) => Container(
                  child: Stack(
                    overflow: Overflow.visible,
                    children: <Widget>[
                      child,
                      Positioned(
                        top: 0,
                        right: -22,
                        child: _aniWholePoundCtl.text.isEmpty
                            ? Icon(Icons.star_border)
                            : Icon(Icons.star, color: Colors.amber),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Fit extends StatelessWidget {
  final Widget child;

  Fit({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: FittedTextFieldContainer(minWidth: 16, child: child),
      ),
    );
  }
}

class AnimFit extends StatelessWidget {
  final TextField child;

  AnimFit({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: AnimatedFittedTextFieldContainer(
          growDuration: Duration(milliseconds: 300),
          shrinkDuration: Duration(milliseconds: 600),
          growCurve: Curves.easeOutCirc,
          shrinkCurve: Curves.easeInCirc,
          child: child,
        ),
      ),
    );
  }
}
