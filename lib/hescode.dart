import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HesCode extends StatefulWidget {
  const HesCode({Key key}) : super(key: key);
  @override
  _HesCodeState createState() => _HesCodeState();
}

class _HesCodeState extends State<HesCode> {
  final formKey = GlobalKey<FormState>();
  String hesCode;
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  @override
  void initState() {
    super.initState();
    getHesCode();
  }

  Future<void> saveHesCode() async {
    final SharedPreferences prefs = await _prefs;
    setState(() {
      prefs.setString("hesCode", hesCode);
    });
  }

  Future<void> getHesCode() async {
    final SharedPreferences prefs = await _prefs;

    setState(() {
      hesCode = prefs.getString("hesCode");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Form(
        key: formKey,
        child: ListView(
          children: [
            TextFormField(
              onSaved: (value) {
                hesCode = value;
              },
              validator: (value) {
                if (value.length < 13) return "Hes kodu 12 haneden az olamaz";
              },
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Enter your hes code here'),
            ),
            FlatButton(
                onPressed: () {
                  if (formKey.currentState.validate()) {
                    formKey.currentState.save();
                    saveHesCode();
                  }
                },
                child: Text("Kaydet")),
            Text(hesCode != null ? hesCode : ""),
          ],
        ),
      ),
    );
  }
}
