// Convert Enum -> String
String _enumToString<T>(T enumValue) {
  return enumValue.toString().split('.').last;
}

// Convert String -> Enum (works with any enum)
T? stringToEnum<T>(String? value, List<T> enumValues) {
  try {
    if (value == null) return null;
    return enumValues.firstWhere(
      (e) => _enumToString(e).toLowerCase() == value.toLowerCase(),
    );
  } catch (_) {
    return null;
  }
}

extension StringFormatter on String {
  String get withSpaces {
    return replaceAllMapped(
      RegExp(r'(?<!^)([A-Z])'),
      (match) => ' ${match.group(1)}',
    );
  }
}
