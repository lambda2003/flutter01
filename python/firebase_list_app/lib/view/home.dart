import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_list_app/model/student.dart';
import 'package:firebase_list_app/view/insert.dart';
import 'package:firebase_list_app/view/update.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Firestore List'),
        actions: [
          IconButton(
            onPressed: () => Get.to(() => Insert()),
            icon: Icon(Icons.add),
          ),
        ],
      ),
      // QuerySnapshot => 메모리에서 불러 온다(Snapshot)
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('students')
            .orderBy('code', descending: false)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: const CircularProgressIndicator());
          }
          final documents = snapshot.data!.docs;
          return ListView(
            children: documents.map((data) => buildItemWidget(data)).toList(),
          );
        },
      ),
    );
  }

  // == Functions
  Widget buildItemWidget(DocumentSnapshot doc) {
    final student = Student(
      code: doc["code"],
      name: doc["name"],
      dept: doc["dept"],
      phone: doc["phone"],
      image: doc["image"],
    );
    return Slidable(
      startActionPane: ActionPane(
        motion: BehindMotion(),
        children: [
          SlidableAction(
            onPressed: (context) => Get.to(() => Update(), arguments: [
              doc.id,
              student

            ]),
            label: "수정",
            icon: Icons.delete_forever_outlined,
            backgroundColor: Colors.green,
          ),
        ],
      ),
      endActionPane: ActionPane(
        motion: BehindMotion(),
        children: [
          SlidableAction(
            onPressed: (context) async {
              await FirebaseFirestore.instance
                  .collection("students")
                  .doc(doc.id)
                  .delete();
              await deleteImage(student.code);
            },
            label: "삭제",
            icon: Icons.delete_forever_outlined,
            backgroundColor: Colors.red,
          ),
        ],
      ),

      child: Card(
        child: ListTile(
          title: Row(
            spacing: 10,
            children: [
              Image.network(student.image, width: 70),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 2,
                children: [
                  Text(
                    "이름: ${student.name}\n학번 : ${student.code}\n전공 : ${student.dept}",
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Functions
  Future<void> deleteImage(String code) async {
    final firebaseFirestore = FirebaseStorage.instance
        .ref()
        // .child('')
        .child("${code}.png");
    await firebaseFirestore.delete();
  }
}
