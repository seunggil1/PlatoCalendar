import 'package:isar/isar.dart';

part 'plato_credential.g.dart';

@collection
class PlatoCredential {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late String username;
  late String password;

  @override
  int get hashCode => Object.hash(username, null);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;

    return other is PlatoCredential && other.username == username;
  }

  @override
  String toString() {
    return 'PlatoCredential{username: $username}';
  }

}