import 'package:flutter/material.dart';

class CustTextFormSign extends StatelessWidget {
  final String hint ; 
  final String? Function(String?) valid ; 
  final TextEditingController mycontroller ; 
  const CustTextFormSign({Key? key, required this.hint, required this.mycontroller, required this.valid}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: TextFormField(
        validator: valid,
        controller: mycontroller,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
            hintText: hint,
            border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black, width: 1),
                borderRadius: BorderRadius.all(Radius.circular(10)))),
      ),
    );
  }
}
