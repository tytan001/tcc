import 'package:flutter/material.dart';

class InputFieldMaskProfile extends StatelessWidget {
  final String label;
  final bool date;
  final bool phone;
  final Stream<String> stream;
  final Function(String) onChanged;
  final TextEditingController controller;

  InputFieldMaskProfile(
      {this.label,
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
        controller.text = snapshot.data;
        if (snapshot.hasData || snapshot.hasError)
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(label),
              TextFormField(
                onChanged: onChanged,
                controller: controller,
                decoration: InputDecoration(
                  hintText: label,
                  errorText: snapshot.hasError ? snapshot.error : null,
                  labelStyle: TextStyle(color: Colors.black54),
                ),
                style: TextStyle(fontSize: 18.0),
                keyboardType: date ?? false
                    ? TextInputType.datetime
                    : phone ?? false
                        ? TextInputType.datetime
                        : TextInputType.number,
              ),
            ],
          );
        else
          return Container();
      },
    );
  }
}
