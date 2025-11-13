enum CommandType {
  create,
  delete,
  modify,
  register,
  wait,
  swap;

  factory CommandType.from(String value) {
    switch (value) {
      case "create":
        return CommandType.create;
      case "delete":
        return CommandType.delete;
      case "modify":
        return CommandType.modify;
      case "edit start":
        return CommandType.register;
      case "wait":
        return CommandType.wait;
      case "swap":
        return CommandType.swap;
      default:
        throw UnimplementedError('Unknown command: $value');
    }
  }
}
