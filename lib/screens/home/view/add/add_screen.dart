import 'package:ecommerce_app/utils/firebase_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({Key? key}) : super(key: key);

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  TextEditingController txtname = TextEditingController();
  TextEditingController txtprice = TextEditingController();
  TextEditingController txtrate = TextEditingController();
  TextEditingController txtdesc = TextEditingController();
  TextEditingController txtquan = TextEditingController();
  TextEditingController txtimage = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: Text(
          "Add Your Product",
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: txtname,
                decoration: const InputDecoration(
                    focusedBorder: OutlineInputBorder(),
                    labelStyle: TextStyle(color: Colors.blueGrey),
                    enabledBorder: OutlineInputBorder(),
                    hintText: "Enter name",
                    labelText: "Name"),
              ),
              SizedBox(height: 10),
              TextField(
                controller: txtprice,
                decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(),
                    labelStyle: TextStyle(color: Colors.blueGrey),
                    hintText: "Enter price",
                    labelText: "Price"),
              ),
              SizedBox(height: 10),
              TextField(
                controller: txtrate,
                decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(),
                    labelStyle: TextStyle(color: Colors.blueGrey),
                    enabledBorder: OutlineInputBorder(),
                    hintText: "Enter rate",
                    labelText: "Rate"),
              ),
              SizedBox(height: 10),
              TextField(
                controller: txtquan,
                decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(),
                    labelStyle: TextStyle(color: Colors.blueGrey),
                    enabledBorder: OutlineInputBorder(),
                    hintText: "Enter quantity",
                    labelText: "Quantity"),
              ),
              SizedBox(height: 10),
              TextField(
                controller: txtdesc,
                decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(),
                    labelStyle: TextStyle(color: Colors.blueGrey),
                    enabledBorder: OutlineInputBorder(),
                    hintText: "Enter description",
                    labelText: "Description"),
              ),
              SizedBox(height: 10),
              TextField(
                controller: txtimage,
                decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(),
                    labelStyle: TextStyle(color: Colors.blueGrey),
                    enabledBorder: OutlineInputBorder(),
                    hintText: "Enter url",
                    labelText: "Url"),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueGrey),
                  onPressed: () async {
                    await FireBaseHelper.fireBaseHelper.insert(
                        name: txtname.text,
                        price: txtprice.text,
                        quantity: txtquan.text,
                        description: txtdesc.text,
                        rate: txtrate.text,
                        image: txtimage.text);
                    Get.back();
                  },
                  child: Text("Add")),
            ],
          ),
        ),
      ),
    ));
  }
}
