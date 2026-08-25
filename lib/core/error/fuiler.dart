abstract class Fuiler {
  final String message;

  Fuiler(this.message);

  factory Fuiler.errServer(String errorMessage) {
    return ServerFuiler(errorMessage);
  }
}

class ServerFuiler extends Fuiler {
  ServerFuiler(super.message);
}