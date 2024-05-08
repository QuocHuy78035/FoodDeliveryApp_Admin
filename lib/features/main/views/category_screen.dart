import 'package:ddnangcao_project/features/main/views/category/edit_category_screen.dart';
import 'package:ddnangcao_project/models/category.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/main_provider.dart';
import '../../../utils/size_lib.dart';
import 'category/add_category_screen.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  List<Category> listCate = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<MainProvider>(context, listen: false)
        .getCategory()
        .then((value) {
      setState(() {
        listCate = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Category"),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddCategoryScreen(),
                  ),
                );
              },
              child: const Icon(
                Icons.add,
              ),
            ),
          )
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: GetSize.symmetricPadding * 2),
            child: listCate.isEmpty
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Column(
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: listCate.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => EditCategoryScreen(
                                    cateId: listCate[index].id,
                                    cateName: listCate[index].name,
                                    imageUrl: listCate[index].image,
                                  ),
                                ),
                              );
                            },
                            child: CategoryItem(
                              imageUrl: listCate[index].image,
                              name: listCate[index].name,
                            ),
                          );
                        },
                      )
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}

class CategoryItem extends StatelessWidget {
  final String name;
  final String imageUrl;

  const CategoryItem({super.key, required this.name, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            SizedBox(
              height: 50,
              child: Image.network(imageUrl),
            ),
            const SizedBox(
              width: 20,
            ),
            Text(
              name,
              style: const TextStyle(fontSize: 20),
            )
          ],
        ),
        const SizedBox(
          height: 30,
        )
      ],
    );
  }
}
