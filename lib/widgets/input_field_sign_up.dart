import 'package:flutter/material.dart';
import 'package:masked_text/masked_text.dart';

class InputFieldSignUp extends StatelessWidget {

  final String label;
  final String hint;
  final bool email;
  final bool password;
  final bool phone;
  final Stream<String> stream;
  final Function(String) onChanged;

  InputFieldSignUp({this.label, this.hint, this.email, this.password, this.phone, this.stream, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String>(
      stream: stream,
      builder: (context, snapshot){
        return TextField(
          onChanged: onChanged,
          decoration: InputDecoration(
            hintText: hint,
            labelText: label,

            errorText: snapshot.hasError ? snapshot.error : null,
          ),
          style: TextStyle(fontSize: 18.0),
          keyboardType: email ? TextInputType.emailAddress : phone ? TextInputType.phone : null,
          obscureText: password ,
        );
      },
    );
  }
}
