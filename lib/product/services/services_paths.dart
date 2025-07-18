enum ServicePath {
  //General
  capsules('capsules/'),
  register('auth/register'),
  login('auth/login');

  final String value;
  const ServicePath(this.value);
}

extension ServicePathExt on ServicePath {
  String withQuery(Map<String, String> params) {
    final uri = Uri(path: value, queryParameters: params);
    return uri.toString();
  }
}
