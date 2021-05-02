class Utils {
  static T tryImportFromJson<T>(
      String jsonKey, Map<String, dynamic> json, T fallback) {
    // using ? indicator to say we might have a null here
    final result = (json[jsonKey] ?? fallback) as T;
    return result;
  }
}

List<T> getFirstPossibleNumberOfItems<T>(
    List<T> listOfItems, int numberOfItemsToGet) {
  final numberOfItemsAvailable = listOfItems.length;
  var numberOfPossibleItems = numberOfItemsAvailable <= numberOfItemsToGet
      ? numberOfItemsAvailable
      : numberOfItemsToGet;

  return listOfItems.sublist(0, numberOfPossibleItems);
}
