bool isDevEnvironment() {
  return const String.fromEnvironment('FLAVOR') == 'dev';
}
