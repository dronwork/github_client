import 'package:http/http.dart' as http;

import '../utils/consts.dart';

getRepositories({int since = 1}) async {
  return await http.get("$url/repositories?since=$since");
}

getRepository(String fullName) async {
  return await http.get("$url/repos/$fullName");
}

getContributors(String fullName) async {
  return await http.get("$url/repos/$fullName/contributors");
}

getCommits(String fullName) async {
  return await http.get("$url/repos/$fullName/commits");
}
