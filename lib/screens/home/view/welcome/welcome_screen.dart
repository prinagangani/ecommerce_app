import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/screens/home/modal/home_modal.dart';
import 'package:ecommerce_app/utils/firebase_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
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
          appBar: AppBar(title: Text("Ecommerce App"),centerTitle: true,backgroundColor: Colors.blueGrey,
          actions: [
            IconButton(onPressed: () {
              FireBaseHelper.fireBaseHelper.logout();
            }, icon: Icon(Icons.logout)),
          ],),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueGrey,
        onPressed: () {
          Get.toNamed('/add');
        },
        child: Icon(Icons.add),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: FireBaseHelper.fireBaseHelper.read(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                } else if (snapshot.hasData) {
                  List<HomeModal> dataList = [];
                  QuerySnapshot? snapdata = snapshot.data;
                  for (var x in snapdata!.docs) {
                    Map data = x.data() as Map;
                    String name = data['name'];
                    String price = data['price'];
                    String quantity = data['quantity'];
                    String rate = data['rate'];
                    String description = data['description'];
                    String image = data['image'];
                    String docId = x.id;
                    HomeModal homemodal = HomeModal(
                        name: name,
                        docId: docId,
                        price: price,
                        quantity: quantity,
                        rate: rate,
                        description: description,
                    image:image);
                    dataList.add(homemodal);
                  }
                  return GridView.builder(
                    itemCount: dataList.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(

                        crossAxisCount: 2,mainAxisExtent: 290),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onDoubleTap: () async {
                            await FireBaseHelper.fireBaseHelper.delete(dataList[index].docId!);
                          },
                          onTap: ()       {
                            txtname = TextEditingController(text: dataList[index].name);
                            txtprice = TextEditingController(text: dataList[index].price);
                            txtrate = TextEditingController(text: dataList[index].rate);
                            txtquan = TextEditingController(text: dataList[index].quantity);
                            txtdesc = TextEditingController(text: dataList[index].description);
                            txtimage = TextEditingController(text: dataList[index].image);
                            showDialog(context: context, builder: (context) {
                              return AlertDialog(
                                content: SingleChildScrollView(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      TextField(
                                        controller: txtname,
                                        decoration: InputDecoration(
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
                                            labelText: "Quantity"),),
                                      SizedBox(height: 10),
                                      TextField(
                                        controller: txtquan,
                                        decoration: InputDecoration(
                                            focusedBorder: OutlineInputBorder(),
                                            labelStyle: TextStyle(color: Colors.blueGrey),
                                            enabledBorder: OutlineInputBorder(),
                                            hintText: "Enter image",
                                            labelText: "Image"),),
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
                                            hintText: "Enter imageUrl",
                                            labelText: "Url"),
                                      ),
                                      SizedBox(height: 20),


                                      ElevatedButton(
                                          style: ElevatedButton.styleFrom(backgroundColor: Colors.blueGrey),
                                          onPressed: () async {
                                            HomeModal homeModal = HomeModal(
                                              name: txtname.text,
                                              price: txtprice.text,
                                              rate: txtrate.text,
                                              quantity: txtquan.text,
                                              description: txtdesc.text,
                                              docId: dataList[index].docId,
                                              image: dataList[index].image,
                                            );
                                            FireBaseHelper.fireBaseHelper.update(homeModal, homeModal.docId!);
                                            Get.back();
                                          },
                                          child: Text("Update")),
                                    ],
                                  ),
                                ),
                              );
                            },);
                          },
                          child: Container(
                            margin: EdgeInsets.all(10),
                            height: 90,
                            width: 100,
                            decoration: BoxDecoration(
                              // color: Colors.blueGrey.shade50,
                                borderRadius: BorderRadius.circular(12),
                                // border: Border.all(width: 1.3,color: Colors.blueGrey)
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.network("${dataList[index].image}",),
                                Padding(
                                  padding: const EdgeInsets.only(left: 20),
                                  child: Text("${dataList[index].name}",style: TextStyle(fontSize: 17),),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 50),
                                  child: Text("\$ ${dataList[index].price}",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.orange),),
                                ),
                              ],
                            ),
                            // child: Column(
                            //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            //   children: [
                            //     Container(
                            //       height: 150,
                            //         child: Image.network("${dataList[index].image}",fit: BoxFit.cover,)),
                            //     Align(
                            //       alignment: Alignment.topLeft,
                            //       child: Padding(
                            //         padding: const EdgeInsets.only(left: 20),
                            //         child: Container(
                            //           child: Column(
                            //             children: [
                            //               Text("${dataList[index].name}",style: TextStyle(fontSize: 22),),
                            //               Text("Rs.${dataList[index].price}",style: TextStyle(fontSize: 12),),
                            //             ],
                            //           ),
                            //         ),
                            //       ),
                            //     ),
                            //     // Text("${dataList[index].name}",style: TextStyle(fontSize: 25),),
                            //     // Text("Rs.${dataList[index].price}",style: TextStyle(fontSize: 19),),
                            //     // Row(
                            //     //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                            //     //   children: [
                            //     //     Text("${dataList[index].rate}"),
                            //     //     Text("${dataList[index].description}"),
                            //     //   ],
                            //     // ),
                            //   ],
                            // ),
                          ),
                        ),
                      );
                    },
                  );
                  // return ListView.builder(itemBuilder: (context, index) {
                  //   return ListTile(
                  //     title: Text("${dataList[index].name}"),
                  //     subtitle: Text("${dataList[index].price}"),
                  //   );
                  // },itemCount: dataList.length,);
                }
                return CircularProgressIndicator();
              },
            ),
          )
        ],
      ),
    ));
  }

}
