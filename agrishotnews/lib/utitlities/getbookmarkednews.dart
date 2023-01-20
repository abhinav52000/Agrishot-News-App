import 'package:http/http.dart' as http;

getbookmarkednews(String deviceId) async {
  //This is the Api call for bookmarked news articles
  try {
    var newsapiurl = Uri.parse(
        'https://api.dev.agrishots.in/articles?perPage=10&page=3&language=hn');
    return await http.get(newsapiurl, headers: {
      'x-device-hash': deviceId,
    });
    // Probably the device Hash is not working here hence we are not getting the desired result.
  } catch (e) {
    // On error handles the problem in case the deivceId doesn't work then we can directly call for API mentioned.
    return e;
  }
}
