enum CommandType {
  create("create"),
  // delete("delete"),
  // modify("modify"),
  // editStart("edit start"),
  // editFinish("edit finish"),
  // swap("swap"),
  // wait("wait"),
  unknown("");

  final String value;

  const CommandType(this.value);

  static CommandType from(String? value) {
    return CommandType.values.firstWhere(
      (e) => e.value == value,
      orElse: () => CommandType.unknown,
    );
  }
}
