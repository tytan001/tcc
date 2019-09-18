import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final String label;
  final String hint;
  final bool email;
  final bool password;
  final bool phone;
  final Stream<String> stream;
  final Function(String) onChanged;

  InputField(
      {this.label,
      this.hint,
      this.email,
      this.password,
      this.phone,
      this.stream,
      this.onChanged});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String>(
      stream: stream,
      builder: (context, snapshot) {
        return TextField(
          onChanged: onChanged,
          decoration: InputDecoration(
              hintText: hint,
              labelText: label,
              errorText: snapshot.hasError ? snapshot.error : null,
              labelStyle: TextStyle(color: Colors.black54),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide:
                      BorderSide(color: Theme.of(context).buttonColor))),
          style: TextStyle(fontSize: 18.0),
          keyboardType: email ?? false
              ? TextInputType.emailAddress
              : phone ?? false ? TextInputType.phone : null,
          obscureText: password ?? false,
        );
      },
    );
  }
}
