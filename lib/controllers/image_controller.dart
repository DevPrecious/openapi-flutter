import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:imagecreate/models/image_model.dart';

class ImageController extends GetxController {
  var url = Uri.parse('https://api.openai.com/v1/images/generations');
  // ignore: non_constant_identifier_names
  var api_token = '';

  Rx<List<ImageModel>> image = Rx<List<ImageModel>>([]);
  final data = ''.obs;

  final isLoading = false.obs;

  Future getImage({required String imageText}) async {
    try {
      isLoading.value = true;
      var request = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $api_token',
        },
        body: jsonEncode(
          {
            'prompt': imageText,
          },
        ),
      );
      if (request.statusCode == 200) {
        isLoading.value = false;
        data.value = jsonDecode(request.body)['data'][0]['url'];
        print(data.value);
        // image.value.add(ImageModel.fromJson((jsonDecode(request.body))));
        print(jsonDecode(request.body));
      } else {
        isLoading.value = false;

        print(jsonDecode(request.body));
      }
    } catch (e) {
      isLoading.value = false;

      print(e.toString());
    }
  }
}
