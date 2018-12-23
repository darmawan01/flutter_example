import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Simple Calculcator",
      home: _Home(),
      theme: ThemeData(
        primaryColor: Colors.red,
        accentColor: Colors.redAccent
      ),
    )
  );
}

class _Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeState();
}

class _HomeState extends State<_Home>{
  var _currency = ['Rupiah', 'dollar', 'send'];
  var _minMargin = 5.0;

  TextEditingController txtPrincipal = TextEditingController();
  TextEditingController txtPercent = TextEditingController();
  TextEditingController txtTerm = TextEditingController();

  var _diplayText = '';
  var _currentSelected = '';

  @override
  void initState() {
    _currentSelected = _currency[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    TextStyle textStyle = Theme.of(context).textTheme.title;

    return Scaffold(
      appBar: AppBar(
        title: Text("Simple Calculator Apps"),
      ),
      body: Container(
        margin: EdgeInsets.all(_minMargin*2),
        child: ListView(
          children: <Widget>[
            getImageAssets(),

            Padding(
              padding: EdgeInsets.only(top: _minMargin, bottom: _minMargin),
              child:
              TextField(
                  keyboardType: TextInputType.number,
                  style: textStyle,
                  controller: txtPrincipal,
                  decoration: InputDecoration(
                      labelText: 'Principal',
                      labelStyle: textStyle,
                      hintText: 'Enter principal e.g 1200',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(_minMargin)
                      )
                  ),
              )
            ),

            Padding(
              padding: EdgeInsets.only(top: _minMargin, bottom: _minMargin),
              child: TextField(
                keyboardType: TextInputType.number,
                style: textStyle,
                controller: txtPercent,
                decoration: InputDecoration(
                    labelText: 'Rate of interes',
                    hintText: 'In percent',
                    labelStyle: textStyle,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(_minMargin)
                    )
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.only(top: _minMargin, bottom: _minMargin),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      keyboardType: TextInputType.number,
                      controller: txtTerm,
                      decoration: InputDecoration(
                          labelText: 'Term',
                          hintText: 'Time in years',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(_minMargin)
                          )
                      ),
                    ),
                  ),

                  Container(width: _minMargin*2,),

                  Expanded(
                    child: DropdownButton<String>(
                      items: _currency.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),

                      value: _currency[0],
                      onChanged: (String value){
                        _onDropdownItemSelected(value);
                      },
                    ),
                  )
                ],
              ),
            ),

            Padding(
              padding: EdgeInsets.only(top: _minMargin, bottom: _minMargin),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: RaisedButton(
                      child: Text('Calculate'),
                      onPressed: () {
                        setState(() {
                          this._diplayText = _calculate();
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: RaisedButton(
                      child: Text('Reset'),
                      onPressed: () {
                        setState(() {
                          _clear();
                        });
                      },
                    ),
                  )
                ],
              )
            ),

            Padding(
              padding: EdgeInsets.all(_minMargin*2),
              child: Text(this._diplayText),
            )
          ],
        ),
      ),
    );
  }

  Widget getImageAssets() {
    AssetImage assetImage = AssetImage('images/money.png');
    Image img = Image(image: assetImage, width: 135.0, height: 135.0);

    return Container(child: img, margin: EdgeInsets.all(_minMargin*10),);
  }

  String _calculate() {
    double principal = double.parse(txtPrincipal.text);
    double percent = double.parse(txtPercent.text);
    double term = double.parse(txtTerm.text);

    double total = principal+ (principal*percent*term)/100;

    String result = "After $term years, your investment be wort $total";
    return result;

  }

  void _onDropdownItemSelected(String newVl) {

  }

  void _clear() {
    txtPrincipal.text = '';
    txtTerm.text = '';
    txtPercent.text = '';
    this._diplayText = '--------';
  }
}


