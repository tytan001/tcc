
import 'package:laravel_echo/laravel_echo.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;


class EchoSocket {


  void sla(){
    Echo echo = new Echo({
      'broadcaster': 'socket.io',
      'client': IO.io("http://192.168.43.69:8000/"),
    });

// Listening public channel
    echo.channel('my-channel').listen('MyEvent', (e) {
      print(e);
    });

// Accessing socket instance
    echo.socket.on('connect', (_) => print('connected'));
    echo.socket.on('disconnect', (_) => print('disconnected'));
  }

}