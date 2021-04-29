class Utils {
  static T tryImportFromJson<T>(
      String jsonKey, Map<String, dynamic> json, T fallback) {
    // using ? indicator to say we might have a null here
    final result = (json[jsonKey] ?? fallback) as T;
    return result;
  }
}
