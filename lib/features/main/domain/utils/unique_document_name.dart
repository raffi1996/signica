import 'package:path/path.dart' as p;

String uniqueDocumentName({
  required String desiredName,
  required Iterable<String> existingNames,
}) {
  final trimmed = desiredName.trim();
  if (trimmed.isEmpty) {
    return trimmed;
  }

  final extension = p.extension(trimmed);
  final stem = extension.isEmpty
      ? trimmed
      : p.basenameWithoutExtension(trimmed);

  final taken = <int>{};
  final numberedPattern = RegExp(
    '^${RegExp.escape(stem)} (\\d+)${RegExp.escape(extension)}\$',
  );

  for (final name in existingNames) {
    if (name == trimmed || name == '$stem$extension') {
      taken.add(1);
      continue;
    }
    final match = numberedPattern.firstMatch(name);
    if (match != null) {
      final number = int.tryParse(match.group(1)!);
      if (number != null && number >= 1) {
        taken.add(number);
      }
    }
  }

  if (!taken.contains(1)) {
    return '$stem$extension';
  }

  var candidate = 2;
  while (taken.contains(candidate)) {
    candidate++;
  }
  return '$stem $candidate$extension';
}
