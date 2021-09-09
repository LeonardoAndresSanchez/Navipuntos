import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:navi_puntos/src/blocs/validator.dart';

class LoginBloc with Validators {
  final _emailControler = BehaviorSubject<String>();
  final _passwordControler = BehaviorSubject<String>();

  //recuperar datos del stream
  Stream<String> get emailStream =>
      _emailControler.stream.transform(validarEmail);
  Stream<String> get passwordStream =>
      _passwordControler.stream.transform(validarPassword);

  Stream<bool> get formValidStream =>
      Rx.combineLatest2(emailStream, passwordStream, (e, p) => true);

  //insertar valores al string
  Function(String) get changeEmail => _emailControler.sink.add;
  Function(String) get changePassword => _passwordControler.sink.add;

  //Obtener el ultima valor ingresado a los Streams
  String get email => _emailControler.value;
  String get password => _passwordControler.value;
  dispose() {
    _emailControler?.close();
    _passwordControler?.close();
  }
}
