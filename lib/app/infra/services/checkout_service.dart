class CheckoutService {
  Future<bool> finalizeOrder() async {
    await Future.delayed(const Duration(seconds: 2));
    return true;
  }

  Future<void> simulateRemoveError() async {
    await Future.delayed(const Duration(milliseconds: 500));
    throw Exception("Falha ao sincronizar remoção com o servidor.");
  }
}
