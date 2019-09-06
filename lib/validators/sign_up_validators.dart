import 'dart:async';

class SignUpValidators{
  final validadeName = StreamTransformer<String, String>.fromHandlers(
      handleData: (name, sink){
        if(name.isNotEmpty) {
          sink.add(name);
        } else {
          sink.addError("Name inválido");
        }
      }
  );

  final validadeEmail = StreamTransformer<String, String>.fromHandlers(
      handleData: (email, sink){
        String emailValidationRule = r'^(([^()[\]\\.,;:\s@\"]+(\.[^()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
        RegExp regExp = new RegExp(emailValidationRule);

        if(regExp.hasMatch(email)) {
          sink.add(email);
        } else {
          sink.addError("E_mail inválido");
        }
      }
  );

  final validadePassword = StreamTransformer<String, String>.fromHandlers(
      handleData: (password, sink){

        if(password.isNotEmpty && password.length > 6) {
          sink.add(password);
        } else {
          sink.addError("Senha inválido");
        }
      }
  );

  final validadePhone = StreamTransformer<String, String>.fromHandlers(
      handleData: (phone, sink){
//        String phoneValidationRule = r'/^\(?(\d{3})\)?[- ]?(\d{3})[- ]?(\d{4})$/';
//        RegExp regExp = new RegExp(phoneValidationRule);

//        if(regExp.hasMatch(phone)) {
//          sink.add(phone);
//        } else {
//          sink.addError("E_mail inválido");
//        }
        if(phone.isNotEmpty && phone != null) {
          sink.add(phone);
        } else {
          sink.addError("Phone inválido");
        }
      }
  );

}