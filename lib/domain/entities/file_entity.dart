import 'package:equatable/equatable.dart';

class FileEntity extends Equatable {
  final List<String> preSignedUrls;

  const FileEntity({
    required this.preSignedUrls,
  });

  @override
  List<Object> get props => [preSignedUrls];
}
