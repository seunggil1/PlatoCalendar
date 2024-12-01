class TodosRepository {
  Stream<int> getTodos() async* {
    for (var i = 0; i < 20; i++) {
      yield i;

      await Future.delayed(const Duration(seconds: 1));
    }
  }

}