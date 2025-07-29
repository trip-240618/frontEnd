enum CommandType {
  create,
  delete,
  modify;

  factory CommandType.from(String value) {
    switch (value) {
      case "create":
        return CommandType.create;
      case "delete":
        return CommandType.delete;
      case "modify":
        return CommandType.modify;
      default:
        throw UnimplementedError('Unknown command: $value');
    }
  }
}
