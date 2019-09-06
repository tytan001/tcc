import 'package:flutter/material.dart';

class InputFieldLogin extends StatelessWidget {

  final String label;
  final String hint;
  final bool email;
  final Stream<String> stream;
  final Function(String) onChanged;

  InputFieldLogin({this.label, this.hint, this.email, this.stream, this.onChanged});

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
          keyboardType: email? TextInputType.emailAddress : null,
          obscureText: !email,
        );
      },
    );
  }
}
