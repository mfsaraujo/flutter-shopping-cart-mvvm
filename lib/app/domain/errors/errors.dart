abstract class Failure implements Exception {
  final String message;
  Failure(this.message);
}

class ServerFailure extends Failure {
  ServerFailure([String message = 'Erro no servidor']) : super(message);
}

class DatasourceFailure extends Failure {
  DatasourceFailure([String message = 'Erro ao processar dados'])
    : super(message);
}

class BusinessFailure extends Failure {
  BusinessFailure(String message) : super(message);
}
