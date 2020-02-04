import 'package:http/http.dart' as http;

getRepositories({int since = 1}) async {
  return await http.get("https://api.github.com/repositories?since=$since");
}

getRepository(String fullName) async {
  return await http.get("https://api.github.com/repos/$fullName");
}

getContributors(String fullName) async {
  return await http.get("https://api.github.com/repos/$fullName/contributors");
}

getCommits(String fullName) async {
  return await http.get("https://api.github.com/repos/$fullName/commits");
}
