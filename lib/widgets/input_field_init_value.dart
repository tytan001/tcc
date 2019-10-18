import 'package:flutter/material.dart';

class InputFieldInitValue extends StatelessWidget {
  final String label;
  final String hint;
  final bool email;
  final bool number;
  final bool password;
  final bool noBorder;
  final bool enable;
  final Color color;
  final int maxLines;
  final Stream<String> stream;
  final Function(String) onChanged;

  InputFieldInitValue(
      {this.label,
      this.hint,
      this.email,
      this.number,
      this.password,
      this.noBorder,
      this.enable,
      this.color,
      this.maxLines,
      this.stream,
      this.onChanged});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String>(
      stream: stream,
      builder: (context, snapshot) {
        if (snapshot.hasData || snapshot.hasError) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              if (label != null) Text(label),
              TextFormField(
                enabled: enable ?? true,
                maxLines: maxLines != null ? maxLines : null,
                onChanged: onChanged,
                initialValue: snapshot.data,
                decoration: InputDecoration(
                  border: noBorder ?? false ? InputBorder.none : null,
                  hintText: hint,
                  errorText: snapshot.hasError ? snapshot.error : null,
                  labelStyle: TextStyle(color: Colors.black54),
                ),
                style: TextStyle(
                  fontSize: 18.0,
                  color: color != null
                      ? color
                      : Theme.of(context).primaryColorDark,
                ),
                keyboardType: email ?? false
                    ? TextInputType.emailAddress
                    : number ?? false ? TextInputType.number : null,
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
