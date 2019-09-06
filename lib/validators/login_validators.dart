import 'dart:async';

class LoginValidators{
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

//      String passwordValidationRule = '((?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[@#%]).{6,10})';
//      RegExp regExp = new RegExp(passwordValidationRule);
//      if (regExp.hasMatch(password)) {
//        sink.add(password);
//      } else {
//        sink.addError(
//            'A senha tem que ter um número, uma letra minúscula, uma maiúscula, um caracter especial "@#%" e no min. 6 a max. 10 caracteres');
//      }

        if(password.isNotEmpty && password.length > 6) {
          sink.add(password);
        } else {
          sink.addError("Senha inválido");
        }
      }
  );

}