import 'package:flutter/material.dart';

class DecorBorder extends StatelessWidget {
  final String label;
  final String text;
  final Function changed;
  final TextEditingController controller;

  const DecorBorder (this.label, {this.text, this.changed, this.controller, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    dynamic borda() {
      return OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: Colors.white));
    }

    return Container(
      padding: EdgeInsets.only(left: 100, right: 100),
      child: TextFormField(
        controller: controller,
        cursorColor: Colors.white,
        style: TextStyle(color: Colors.white, fontSize: 20),
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
            suffix: Text(text ?? ""),
            suffixStyle: TextStyle(color: Colors.white, fontSize: 20),
            border: borda(),
            focusedBorder: borda(),
            enabledBorder: borda(),
            labelText: label,
            labelStyle: TextStyle(color: Colors.white, fontSize: 16)),
        textAlign: TextAlign.center,

        // ignore: missing_return
        validator: (value){
          if(value.isEmpty){
            return "Insira um valor válido";
          }
        },
        onChanged: changed,
      ),
    );
  }
}
