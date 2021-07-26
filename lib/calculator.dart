import 'package:flutter/material.dart';

class Calculator extends StatefulWidget {
  const Calculator({Key key}) : super(key: key);
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  int number1 = 0;
  int number2 = 0;
  int result = 0;
  int mode = 0;
  String temp = "";
  String operation = "";
  var formKey = GlobalKey<FormState>();
  var _controller = TextEditingController();

  void calculate(String value) {
    if (mode == 1) {
      if (value.isEmpty) {
        setState(() {
          number1 = 0;
          result = number2 + number1;
        });
      } else {
        setState(() {
          number1 = int.parse(value);
          result = number2 + number1;
        });
      }
    } else if (mode == 2) {
      if (value.isEmpty) {
        setState(() {
          number1 = 0;
          result = number2 - number1;
        });
      } else {
        setState(() {
          number1 = int.parse(value);
          result = number2 - number1;
        });
      }
    } else if (mode == 3) {
      if (value.isEmpty) {
        setState(() {
          number1 = 1;
          result = number2 * number1;
        });
      } else {
        setState(() {
          number1 = int.parse(value);
          result = number2 * number1;
        });
      }
    } else if (mode == 4) {
      if (value.isEmpty) {
        setState(() {
          number1 = 1;
          var temp2 = (number2 / number1).toString().split('.');
          temp = "";
          result = int.parse(temp2[0]);
        });
      } else {
        setState(() {
          number1 = int.parse(value);
          var temp2 = (number2 / number1).toString().split('.');
          temp = "." + temp2[1];
          result = int.parse(temp2[0]);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculator"),
      ),
      body: Container(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              Center(
                  child: Container(
                padding: EdgeInsets.only(left: 25, right: 25),
                child: TextFormField(
                  controller: _controller,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    hintText: 'Enter a number',
                    labelText: 'Number *',
                  ),
                  onSaved: (String value) {
                    debugPrint("çalıştı");
                    number1 = int.parse(value);
                  },
                  onChanged: (String value) {
                    debugPrint(value.isEmpty.toString());
                    calculate(value);
                  },
                  validator: (String value) {
                    return value.isEmpty ? 'Enter some number.' : null;
                  },
                ),
              )),
              Container(
                padding: EdgeInsets.only(top: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    RaisedButton(
                        onPressed: () {
                          if (formKey.currentState.validate()) {
                            formKey.currentState.save();
                            setState(() {
                              number2 = number1;
                              number1 = 0;
                              mode = 1;
                              operation = "+";
                            });
                            _controller.clear();
                          }
                        },
                        child: Icon(Icons.add)),
                    RaisedButton(
                        onPressed: () {
                          if (formKey.currentState.validate()) {
                            formKey.currentState.save();
                            setState(() {
                              number2 = number1;
                              number1 = 0;
                              mode = 2;
                              operation = "-";
                            });
                            _controller.clear();
                          }
                        },
                        child: Icon(Icons.remove)),
                    RaisedButton(
                        onPressed: () {
                          if (formKey.currentState.validate()) {
                            formKey.currentState.save();
                            setState(() {
                              number2 = number1;
                              number1 = 0;
                              mode = 3;
                              operation = "x";
                            });
                            _controller.clear();
                          }
                        },
                        child: Icon(Icons.close)),
                    RaisedButton(
                        onPressed: () {
                          if (formKey.currentState.validate()) {
                            formKey.currentState.save();
                            setState(() {
                              number2 = number1;
                              number1 = 0;
                              mode = 4;
                              operation = "/";
                            });
                            _controller.clear();
                          }
                        },
                        child: Text("∕")),
                  ],
                ),
              ),
              Container(
                  child: Text(
                '$number2 $operation $number1 = $result$temp',
                style: TextStyle(fontSize: 32),
              )),
              Container(
                padding: EdgeInsets.only(top: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MaterialButton(
                      onPressed: () {
                        _controller.clear();
                        setState(() {
                          number1 = 0;
                          number2 = 0;
                          mode = 0;
                          result = 0;
                          temp = "";
                          operation = "";
                        });
                      },
                      color: Colors.black,
                      textColor: Colors.white,
                      child: Text("C"),
                      padding: EdgeInsets.all(16),
                      shape: CircleBorder(),
                    ),
                    MaterialButton(
                      onPressed: () {
                        _controller.clear();
                      },
                      color: Colors.black,
                      textColor: Colors.white,
                      child: Text("CE"),
                      padding: EdgeInsets.all(16),
                      shape: CircleBorder(),
                    ),
                    MaterialButton(
                      onPressed: () {
                        if (_controller.text != null &&
                            _controller.text.length > 0) {
                          _controller.text = _controller.text
                              .substring(0, _controller.text.length - 1);
                        }
                        calculate(_controller.text);
                      },
                      color: Colors.black,
                      textColor: Colors.white,
                      child: Icon(Icons.backspace),
                      padding: EdgeInsets.all(16),
                      shape: CircleBorder(),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MaterialButton(
                      onPressed: () {
                        _controller.text += "1";
                        calculate(_controller.text);
                      },
                      color: Colors.black,
                      textColor: Colors.white,
                      child: Text("1"),
                      padding: EdgeInsets.all(16),
                      shape: CircleBorder(),
                    ),
                    MaterialButton(
                      onPressed: () {
                        _controller.text += "2";
                        calculate(_controller.text);
                      },
                      color: Colors.black,
                      textColor: Colors.white,
                      child: Text("2"),
                      padding: EdgeInsets.all(16),
                      shape: CircleBorder(),
                    ),
                    MaterialButton(
                      onPressed: () {
                        _controller.text += "3";
                        calculate(_controller.text);
                      },
                      color: Colors.black,
                      textColor: Colors.white,
                      child: Text("3"),
                      padding: EdgeInsets.all(16),
                      shape: CircleBorder(),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MaterialButton(
                      onPressed: () {
                        _controller.text += "4";
                        calculate(_controller.text);
                      },
                      color: Colors.black,
                      textColor: Colors.white,
                      child: Text("4"),
                      padding: EdgeInsets.all(16),
                      shape: CircleBorder(),
                    ),
                    MaterialButton(
                      onPressed: () {
                        _controller.text += "5";
                        calculate(_controller.text);
                      },
                      color: Colors.black,
                      textColor: Colors.white,
                      child: Text("5"),
                      padding: EdgeInsets.all(16),
                      shape: CircleBorder(),
                    ),
                    MaterialButton(
                      onPressed: () {
                        _controller.text += "6";
                        calculate(_controller.text);
                      },
                      color: Colors.black,
                      textColor: Colors.white,
                      child: Text("6"),
                      padding: EdgeInsets.all(16),
                      shape: CircleBorder(),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MaterialButton(
                      onPressed: () {
                        _controller.text += "7";
                        calculate(_controller.text);
                      },
                      color: Colors.black,
                      textColor: Colors.white,
                      child: Text("7"),
                      padding: EdgeInsets.all(16),
                      shape: CircleBorder(),
                    ),
                    MaterialButton(
                      onPressed: () {
                        _controller.text += "8";
                        calculate(_controller.text);
                      },
                      color: Colors.black,
                      textColor: Colors.white,
                      child: Text("8"),
                      padding: EdgeInsets.all(16),
                      shape: CircleBorder(),
                    ),
                    MaterialButton(
                      onPressed: () {
                        _controller.text += "9";
                        calculate(_controller.text);
                      },
                      color: Colors.black,
                      textColor: Colors.white,
                      child: Text("9"),
                      padding: EdgeInsets.all(16),
                      shape: CircleBorder(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
