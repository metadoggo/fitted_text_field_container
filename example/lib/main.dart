import 'dart:async';
import 'dart:math' show Random;

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
  TextEditingController _textEditingCtl;
  FocusNode _plainFocusNode;
  FocusNode _poundFocusNode;
  FocusNode _paddingFocusNode;
  FocusNode _aniDollarFocusNode;
  FocusNode _aniDongFocusNode;
  FocusNode _aniEuroFocusNode;
  FocusNode _aniPaddingFocusNode;
  FocusNode _aniWholePoundFocusNode;

  @override
  void initState() {
    super.initState();
    _textEditingCtl = TextEditingController();
    _plainFocusNode = FocusNode();
    _poundFocusNode = FocusNode();
    _paddingFocusNode = FocusNode();
    _aniDollarFocusNode = FocusNode();
    _aniDongFocusNode = FocusNode();
    _aniEuroFocusNode = FocusNode();
    _aniPaddingFocusNode = FocusNode();
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
        _textEditingCtl.text += String.fromCharCode(97 + rand.nextInt(25));
        String num = rand.nextInt(9).toString();
        _textEditingCtl.text += num;
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
        _textEditingCtl.text = _textEditingCtl.text.substring(0, end);
        if (_textEditingCtl.text.length > 0) {
          runDelete(_textEditingCtl.text.length - 1,
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
              controller: _textEditingCtl,
              style: TextStyle(fontSize: 16),
              focusNode: _plainFocusNode,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.text,
              textAlign: TextAlign.left,
              maxLines: null,
              onSubmitted: (String value) {
                FocusScope.of(context).requestFocus(_poundFocusNode);
              },
              decoration: InputDecoration(labelText: "Multiline textfield"),
            ),
          ),
          Fit(
            child: TextField(
              controller: _textEditingCtl,
              style: TextStyle(fontSize: 26),
              focusNode: _poundFocusNode,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              maxLines: null,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r"\d+\.?\d*")),
              ],
              textAlign: TextAlign.right,
              decoration: InputDecoration(
                prefixText: "£",
                labelText: "Prefix",
              ),
              onSubmitted: (String value) {
                FocusScope.of(context).requestFocus(_paddingFocusNode);
              },
            ),
          ),
          Fit(
            child: TextField(
              controller: _textEditingCtl,
              style: TextStyle(fontSize: 26),
              focusNode: _paddingFocusNode,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.text,
              textAlign: TextAlign.left,
              maxLines: null,
              onSubmitted: (String value) {
                FocusScope.of(context).requestFocus(_aniDollarFocusNode);
              },
              decoration: InputDecoration(
                fillColor: Colors.white,
                filled: true,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: BorderSide(color: Colors.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: BorderSide(color: Colors.blue, width: 3),
                ),
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(
                  vertical: 15,
                  horizontal: 20,
                ),
                prefixText: "->",
                suffixText: "<-",
                hintText: "Decorations",
              ),
            ),
          ),
          Fit(
            calculator: FittedTextFieldCalculator.fitAll,
            child: TextField(
              controller: _textEditingCtl,
              style: TextStyle(fontSize: 26),
              focusNode: _poundFocusNode,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              maxLines: null,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r"\d+\.?\d*")),
              ],
              textAlign: TextAlign.right,
              decoration: InputDecoration(
                hintText: "Custom width calculator",
              ),
              onSubmitted: (String value) {
                FocusScope.of(context).requestFocus(_paddingFocusNode);
              },
            ),
          ),
          Text(
            'Animated examples',
            style: Theme.of(context).textTheme.headline4,
          ),
          AnimFit(
            child: TextField(
              controller: _textEditingCtl,
              style: TextStyle(fontSize: 16),
              focusNode: _aniDollarFocusNode,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r"\d+\.?\d*")),
              ],
              textAlign: TextAlign.right,
              decoration: InputDecoration(
                prefixText: "\$",
              ),
              onSubmitted: (String value) {
                FocusScope.of(context).requestFocus(_aniEuroFocusNode);
              },
            ),
          ),
          AnimFit(
            child: TextField(
              controller: _textEditingCtl,
              style: TextStyle(fontSize: 26),
              focusNode: _aniEuroFocusNode,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r"\d+\.?\d*")),
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
              controller: _textEditingCtl,
              style: TextStyle(fontSize: 26),
              focusNode: _aniDongFocusNode,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r"\d+")),
              ],
              textAlign: TextAlign.right,
              decoration: InputDecoration(
                suffixText: " ₫",
                hintText: "0",
              ),
              onSubmitted: (String value) {
                FocusScope.of(context).requestFocus(_aniPaddingFocusNode);
              },
            ),
          ),
          AnimFit(
            child: TextField(
              controller: _textEditingCtl,
              style: TextStyle(fontSize: 26),
              focusNode: _aniPaddingFocusNode,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r"\d+")),
              ],
              textAlign: TextAlign.right,
              decoration: InputDecoration(
                fillColor: Colors.white,
                filled: true,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: BorderSide(color: Colors.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: BorderSide(color: Colors.blue, width: 3),
                ),
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(
                  vertical: 15,
                  horizontal: 20,
                ),
              ),
              onSubmitted: (String value) {
                FocusScope.of(context).requestFocus(_aniWholePoundFocusNode);
              },
            ),
          ),
          Text(
            'Custom builder example',
            style: Theme.of(context).textTheme.headline4,
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
                  controller: _textEditingCtl,
                  style: TextStyle(fontSize: 26),
                  focusNode: _aniWholePoundFocusNode,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r"\d+")),
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
                    clipBehavior: Clip.none,
                    children: <Widget>[
                      child,
                      Positioned(
                        top: 0,
                        right: -22,
                        child: _textEditingCtl.text.length < 5
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
  final TextField child;
  final CalculateFunction calculator;

  Fit({Key key, @required this.child, this.calculator}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: FittedTextFieldContainer(child: child, calculator: calculator),
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
