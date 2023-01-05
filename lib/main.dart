import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:todoapp/app/modules/home/binding.dart';
import 'app/data/services/storage/services.dart';
import 'app/modules/home/view.dart';


void main() async{
  await GetStorage.init();
  await Get.putAsync(() => StorageService().init());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
         SystemUiOverlayStyle(statusBarColor: Colors.pinkAccent.withOpacity(0.85))  // To hide top scroll bar
    );
    return  GetMaterialApp(
      title: 'Todo List App',
      initialBinding: HomeBinding(),
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
      builder: EasyLoading.init(),
    );
  }
}

