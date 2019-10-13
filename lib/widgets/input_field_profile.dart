import 'package:flutter/material.dart';

class InputFieldProfile extends StatelessWidget {
  final String label;
  final bool email;
  final bool password;
  final Stream<String> stream;
  final Function(String) onChanged;

  InputFieldProfile(
      {this.label, this.email, this.password, this.stream, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String>(
      stream: stream,
      builder: (context, snapshot) {
        if (snapshot.hasData || snapshot.hasError) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(label),
              TextFormField(
                onChanged: onChanged,
                initialValue: snapshot.data,
                decoration: InputDecoration(
                  hintText: label,
                  errorText: snapshot.hasError ? snapshot.error : null,
                  labelStyle: TextStyle(color: Colors.black54),
                ),
                style: TextStyle(fontSize: 18.0),
                keyboardType:
                    email ?? false ? TextInputType.emailAddress : null,
                obscureText: password ?? false,
              ),
            ],
          );
        } else
          return Container();
      },
    );
  }
}
