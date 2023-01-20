import 'package:http/http.dart' as http;

getnews() async {
  try {
    //This is the Api call for latest news articles

    var newsapiurl =
        Uri.parse('https://api.dev.agrishots.in/articles?page=1&perPage=15');
    return await http.get(newsapiurl);
  } catch (e) {
    return e;
  }
}
