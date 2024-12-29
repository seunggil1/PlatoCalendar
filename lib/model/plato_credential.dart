import 'package:drift/drift.dart';

import 'table/table.dart';

class PlatoCredential {
  int? id;

  late String username;
  late String password;

  DateTime dbTimestamp = DateTime.now();

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

extension PlatoCredentialMapper on PlatoCredential {
  PlatoCredentialTableData _toData() {
    return PlatoCredentialTableData(
      id: id ?? 0,
      username: username,
      password: password,
      dbTimestamp: dbTimestamp,
    );
  }

  PlatoCredentialTableCompanion toSchema() {
    return PlatoCredentialTableCompanion(
      username: Value(username),
      password: Value(password),
      dbTimestamp: Value(dbTimestamp),
    );
  }
}

extension PlatoCredentialTableDataMapper on PlatoCredentialTableData {
  PlatoCredential toModel() {
    return PlatoCredential()
      ..id = id
      ..username = username
      ..password = password
      ..dbTimestamp = dbTimestamp;
  }
}
