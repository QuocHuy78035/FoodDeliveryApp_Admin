import 'dart:io';

import 'package:ddnangcao_project/features/main/controllers/main_controllers.dart';
import 'package:ddnangcao_project/features/main/views/category_screen.dart';
import 'package:ddnangcao_project/providers/main_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../../utils/color_lib.dart';
import '../../../../utils/size_lib.dart';

class AddCategoryScreen extends StatefulWidget {
  const AddCategoryScreen({super.key});

  @override
  State<AddCategoryScreen> createState() => _AddCategoryScreenState();
}

class _AddCategoryScreenState extends State<AddCategoryScreen> {
  File? _image;
  String cateName = "";

  _selectCameraImage() async {
    final ImagePicker _imagePicker = ImagePicker();

    final im = await _imagePicker.pickImage(source: ImageSource.gallery);
    if (im != null) {
      setState(() {
        _image = File(im.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add category"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _image != null
                  ? Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          height: 120,
                          width: 120,
                          child: Image.file(
                            _image!,
                            fit: BoxFit.fill,
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        )
                      ],
                    )
                  : const SizedBox(
                      height: 30,
                    ),
              GestureDetector(
                onTap: () async {
                  await _selectCameraImage();
                },
                child: Container(
                  height: 60,
                  width: GetSize.getWidth(context) / 2.5,
                  decoration: BoxDecoration(
                    border: Border.all(color: ColorLib.primaryColor),
                  ),
                  child: const Center(
                    child: Column(
                      children: [
                        Icon(
                          Icons.camera_alt,
                          color: ColorLib.primaryColor,
                        ),
                        Text("Choose Food Image")
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                onChanged: (value) {
                  cateName = value;
                },
                decoration: const InputDecoration(
                    hintText: "Enter Category Name",
                    labelText: "Category Name"),
              ),
            ],
          ),
        ),
      ),
      bottomSheet: GestureDetector(
        onTap: () async {
          EasyLoading.show(status: "Please wait");
          await Provider.of<MainProvider>(context, listen: false)
              .addCate(cateName, _image!);
          EasyLoading.dismiss();
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const CategoryScreen(),
            ),
          );
        },
        child: Container(
          color: ColorLib.primaryColor,
          height: 50,
          width: GetSize.getWidth(context),
          child: const Center(
            child: Text(
              "Up Load",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
        ),
      ),
    );
  }
}
