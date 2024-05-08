import 'package:ddnangcao_project/providers/main_provider.dart';
import 'package:ddnangcao_project/utils/color_lib.dart';
import 'package:ddnangcao_project/utils/size_lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import '../../../models/pending_vendor.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<PendingVendor> pendingVendor = [];

  @override
  void initState() {
    super.initState();
    Provider.of<MainProvider>(context, listen: false)
        .getPendingVendor()
        .then((value) {
      setState(() {
        pendingVendor = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Vendor request"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: GetSize.symmetricPadding * 2),
            child: pendingVendor.isEmpty
                ? const Center(
                    child: Text("No have vendor request"),
                  )
                : Column(
                    children: [
                      const SizedBox(
                        height: 50,
                      ),
                      ListView.builder(
                          shrinkWrap: true,
                          itemCount: pendingVendor.length,
                          itemBuilder: (context, index) {
                            return UserCheck(
                              mobile: pendingVendor[index].mobile ?? "",
                              name: pendingVendor[index].name ?? '',
                              email: pendingVendor[index].email ?? '',
                              createAt: pendingVendor[index].createdAt ?? '',
                              approve: ()async {
                                EasyLoading.show();
                                await Provider.of<MainProvider>(context,
                                        listen: false)
                                    .changeStatusUser(
                                        pendingVendor[index].id ?? "",
                                        "active",
                                        index);
                                EasyLoading.dismiss();
                              },
                              reject: () async {
                                EasyLoading.show();
                                await Provider.of<MainProvider>(context,
                                        listen: false)
                                    .changeStatusUser(
                                        pendingVendor[index].id ?? "",
                                        "inactive",
                                        index);
                                EasyLoading.dismiss();

                              },
                            );
                          })
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}

class UserCheck extends StatelessWidget {
  final String name;
  final String email;
  final String createAt;
  final String mobile;
  final void Function() approve;
  final void Function() reject;

  const UserCheck({
    super.key,
    required this.name,
    required this.email,
    required this.createAt,
    required this.mobile,
    required this.approve,
    required this.reject,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      width: GetSize.getWidth(context),
      decoration: BoxDecoration(
          border: Border.all(color: ColorLib.primaryColor),
          borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "StoreName: $name",
            style: const TextStyle(fontSize: 16),
          ),
          Text(
            "Email: $email",
            style: const TextStyle(fontSize: 16),
          ),
          Text(
            "Mobile: $mobile",
            style: const TextStyle(fontSize: 16),
          ),
          Text(
            "Create at: $createAt",
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: approve,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: ColorLib.primaryColor,
                      border: Border.all(color: ColorLib.primaryColor)),
                  height: 40,
                  width: 100,
                  child: const Center(
                    child: Text(
                      "Approve",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: reject,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: ColorLib.primaryColor)),
                  height: 40,
                  width: 100,
                  child: const Center(
                    child: Text(
                      "Reject",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: ColorLib.primaryColor),
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
