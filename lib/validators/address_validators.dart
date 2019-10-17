import 'dart:async';

class AddressValidators {
  final validateCep =
      StreamTransformer<String, String>.fromHandlers(handleData: (name, sink) {
    if (name.isNotEmpty) {
      sink.add(name);
    } else {
      sink.addError("CEP inválido");
    }
  });

  final validatePublicPlace =
  StreamTransformer<String, String>.fromHandlers(handleData: (name, sink) {
    if (name.isNotEmpty) {
      sink.add(name);
    } else {
      sink.addError("Logradouro inválido");
    }
  });

  final validateComplement =
  StreamTransformer<String, String>.fromHandlers(handleData: (name, sink) {
    if (name.isNotEmpty) {
      sink.add(name);
    } else {
      sink.addError("Complemento inválido");
    }
  });

  final validateNeighborhood =
  StreamTransformer<String, String>.fromHandlers(handleData: (name, sink) {
    if (name.isNotEmpty) {
      sink.add(name);
    } else {
      sink.addError("Bairro inválido");
    }
  });

  final validateLocality =
  StreamTransformer<String, String>.fromHandlers(handleData: (name, sink) {
    if (name.isNotEmpty) {
      sink.add(name);
    } else {
      sink.addError("Cidade inválida");
    }
  });

  final validateUf =
  StreamTransformer<String, String>.fromHandlers(handleData: (name, sink) {
    if (name.isNotEmpty) {
      sink.add(name);
    } else {
      sink.addError("UF inválido");
    }
  });

  final validateNumber =
  StreamTransformer<String, String>.fromHandlers(handleData: (name, sink) {
    if (name.isNotEmpty) {
      sink.add(name);
    } else {
      sink.addError("Número inválido");
    }
  });

}
