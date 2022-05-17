class NoSuchElementException implements Exception {
  
  const NoSuchElementException([this.message = '']);

  final String message;

  @override
  String toString() {
    return "NoSuchElementException: '$message'";
  }
}
