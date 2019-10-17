import 'package:flutter/material.dart';

class InputFieldMask extends StatelessWidget {
  final String label;
  final String hint;
  final bool date;
  final bool phone;
  final Stream<String> stream;
  final Function(String) onChanged;
  final TextEditingController controller;

  InputFieldMask(
      {this.label,
      this.hint,
      this.date,
      this.phone,
      this.stream,
      this.onChanged,
      this.controller});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String>(
      stream: stream,
      builder: (context, snapshot) {
        return TextField(
          onChanged: onChanged,
          controller: controller,
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
          keyboardType: date ?? false ? TextInputType.datetime
              : phone?? false ? TextInputType.datetime
              : TextInputType.number,
        );
      },
    );
  }
}
