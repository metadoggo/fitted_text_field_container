import 'package:fitted_text_field_container/fitted_text_field_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
            'Unanimated examples',
            style: Theme.of(context).textTheme.display1,
          ),
          Fit(
            child: TextField(
              controller: _plainCtl,
              style: TextStyle(fontSize: 48),
              focusNode: _plainFocusNode,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.text,
              textAlign: TextAlign.right,
              decoration: InputDecoration(
                hintText: "Name",
              ),
              onSubmitted: (String value) {
                FocusScope.of(context).requestFocus(_poundFocusNode);
              },
            ),
          ),
          Fit(
            child: TextField(
              controller: _poundCtl,
              style: TextStyle(fontSize: 48),
              focusNode: _poundFocusNode,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
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
            style: Theme.of(context).textTheme.display1,
          ),
          AnimFit(
            child: TextField(
              controller: _aniDollarCtl,
              style: TextStyle(fontSize: 48),
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
              style: TextStyle(fontSize: 48),
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
              style: TextStyle(fontSize: 48),
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
          AnimFit(
            child: TextField(
              controller: _aniWholePoundCtl,
              style: TextStyle(fontSize: 48),
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
              onSubmitted: (String value) {
                FocusScope.of(context).requestFocus(_plainFocusNode);
              },
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
        child: FittedTextFieldContainer(child: child),
      ),
    );
  }
}

class AnimFit extends StatelessWidget {
  final Widget child;

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
