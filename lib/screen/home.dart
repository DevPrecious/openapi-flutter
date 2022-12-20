import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:imagecreate/controllers/image_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ImageController _imageController = Get.put(ImageController());
  final TextEditingController _imageTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Generator'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: TextField(
                      controller: _imageTextController,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Image to generate',
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 10.0,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20.0,
                ),
                Obx(() {
                  return _imageController.isLoading.value
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                          ),
                          onPressed: () async {
                            await _imageController.getImage(
                              imageText: _imageTextController.text.trim(),
                            );
                          },
                          child: const Text('Create'),
                        );
                }),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Obx(() {
              return _imageController.isLoading.value
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Container(
                      width: double.infinity,
                      height: 300,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: _imageController.data.value.isNotEmpty
                                ? NetworkImage(
                                    _imageController.data.value,
                                  )
                                : NetworkImage(
                                    'https://cdn.searchenginejournal.com/wp-content/uploads/2022/06/image-search-1600-x-840-px-62c6dc4ff1eee-sej-1520x800.png')),
                      ),
                    );
            }),
          ],
        ),
      ),
    );
  }
}
