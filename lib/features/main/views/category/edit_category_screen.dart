import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:ddnangcao_project/providers/main_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../../utils/color_lib.dart';
import '../../../../utils/size_lib.dart';
import '../navbar_custom.dart';

class EditCategoryScreen extends StatefulWidget {
  final String cateId;
  final String cateName;
  final String imageUrl;

  const EditCategoryScreen({
    super.key,
    required this.cateId,
    required this.cateName,
    required this.imageUrl,
  });

  @override
  State<EditCategoryScreen> createState() => _EditCategoryScreenState();
}

class _EditCategoryScreenState extends State<EditCategoryScreen> {
  String nameChange = "";
  final TextEditingController nameController = TextEditingController();
  File? _image;

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
  void initState() {
    // TODO: implement initState
    super.initState();
    nameChange = widget.cateName;
    nameController.text = widget.cateName;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Category"),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: GestureDetector(
              onTap: () async {
                if (nameChange != widget.cateName || _image != null) {
                  EasyLoading.show();
                  await Provider.of<MainProvider>(context, listen: false)
                      .editCate(widget.cateId, nameChange, _image!);
                  EasyLoading.dismiss();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CustomerHomeScreen(),
                    ),
                  );
                }
              },
              child: Text(
                "Save",
                style: TextStyle(
                  fontSize: 18,
                  color: nameChange != widget.cateName || _image != null
                      ? Colors.red
                      : Colors.grey,
                ),
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              _image == null
                  ? SizedBox(
                      width: 130,
                      height: 130,
                      child: CachedNetworkImage(
                        fit: BoxFit.fill,
                        imageUrl: widget.imageUrl,
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) => Center(
                          child: CircularProgressIndicator(
                              value: downloadProgress.progress),
                        ),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                    )
                  : Column(
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
                    ),
              const SizedBox(
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
                      border: Border.all(color: ColorLib.primaryColor)),
                  child: const Center(
                    child: Column(
                      children: [
                        Icon(
                          Icons.camera_alt,
                          color: ColorLib.primaryColor,
                        ),
                        Text("Choose Cate Image")
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              TextFormField(
                controller: nameController,
                onChanged: (value) {
                  nameChange = value;
                  setState(() {
                    nameChange = value;
                  });
                },
                decoration: const InputDecoration(
                    hintText: "Enter Food Name", labelText: "Food Name"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
