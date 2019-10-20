import 'package:flutter/material.dart';

class InputFieldMaskInitValue extends StatelessWidget {
  final String label;
  final String hint;
  final bool date;
  final bool phone;
  final bool number;
  final bool email;
  final bool noBorder;
  final bool enable;
  final Color color;
  final Stream<String> stream;
  final Function(String) onChanged;
  final TextEditingController controller;

  InputFieldMaskInitValue(
      {this.label,
      this.hint,
      this.date,
      this.phone,
      this.number,
      this.email,
      this.noBorder,
      this.enable,
      this.color,
      this.stream,
      this.onChanged,
      this.controller});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String>(
      stream: stream,
      builder: (context, snapshot) {
        controller.text = snapshot.data;
        if (snapshot.hasData || snapshot.hasError)
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              if (label != null) Text(label),
              TextFormField(
                enabled: enable ?? true,
                onChanged: enable ?? true ? onChanged : null,
                controller: controller,
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
                keyboardType: date ?? false
                    ? TextInputType.datetime
                    : phone ?? false
                        ? TextInputType.datetime
                        : number ?? false
                            ? TextInputType.number
                            : email ?? false
                                ? TextInputType.emailAddress
                                : null,
              ),
            ],
          );
        else
          return Container();
      },
    );
  }
}
