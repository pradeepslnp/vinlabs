import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_app/constants/appconstants.dart';
import 'package:demo_app/features/user_auth/presentation/screens/home/home_page_business.dart';
import 'package:demo_app/features/user_auth/presentation/widgets/loader.dart';
import 'package:demo_app/models/data_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with HomePageBusiness {
  bool isLoading = false;
  bool refreshLoader = false;
  ScrollController? scrollController;
  int pageIndex = 1;
  double ratings = 0.0;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  setLoaderVisibility(bool isVisible) {
    setState(() => isLoading = isVisible);
  }

  loadData() async {
    setLoaderVisibility(true);

    await callApi(pageIndex);
    scrollController = ScrollController()..addListener(loadMoreData);
    setLoaderVisibility(false);
  }

  Future<void> loadMoreData() async {
    if (refreshLoader == false &&
        scrollController!.position.extentAfter < 300) {
      setState(() {
        refreshLoader = true;
      });
      pageIndex++;
      await callApi(pageIndex);

      setState(() {
        refreshLoader = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const LoaderScreen()
        : Scaffold(
            body: SizedBox(
            height: screenHeight * 500,
            child: Column(
              children: [
                getContainerLogs.isNotEmpty
                    ? Expanded(
                        child: RefreshIndicator(
                          backgroundColor: Colors.grey,
                          onRefresh: () => loadData(),
                          child: Column(children: [
                            Expanded(
                              child: ListView.builder(
                                  padding: EdgeInsets.zero,
                                  shrinkWrap: true,
                                  itemCount: getContainerLogs.length,
                                  controller: scrollController,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return card(getContainerLogs[index]);
                                  }),
                            ),
                            refreshLoader == true
                                ? const Padding(
                                    padding: EdgeInsets.all(7.0),
                                    child: Center(
                                        child: CircularProgressIndicator(
                                            strokeWidth: 3)))
                                : const SizedBox.shrink()
                          ]),
                        ),
                      )
                    : const Text("No DATA")
              ],
            ),
          ));
  }

  Widget card(DataModel details) {
    return Container(
      height: screenHeight * 100,
      padding: const EdgeInsets.all(8),
      child: Card(
          child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(5),
                width: screenWidth * 70,
                height: screenHeight * 80,
                child: Image.network(
                  details.image.toString(),
                  loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                            : null,
                      ),
                    );
                  },
                ),
              ),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: screenWidth * 250,
                        child: RichText(
                          text: TextSpan(children: [
                            TextSpan(
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: fontSize * 15,
                                  fontWeight: FontWeight.bold),
                              text: details.title,
                            ),
                          ]),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(details.category.toString()),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          RatingBar.builder(
                            itemSize: 20,
                            initialRating:
                                double.parse("${details.rating!.rate}"),
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            wrapAlignment: WrapAlignment.start,
                            itemPadding:
                                const EdgeInsets.symmetric(horizontal: 1.0),
                            itemBuilder: (context, _) => const Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: 10,
                            ),
                            onRatingUpdate: (rating) {
                              ratings = rating;
                              print(rating);
                            },
                          ),
                          Text("(${details.rating!.rate})"),
                          Padding(
                            padding: EdgeInsets.only(left: screenWidth * 60),
                            child: Text(
                              "\$${details.price}",
                              style: TextStyle(
                                  fontSize: fontSize * 15,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        ],
      )),
    );
  }

  Stream<List<UserModel>> _readData() {
    final userCollection = FirebaseFirestore.instance.collection("users");

    return userCollection.snapshots().map((qureySnapshot) => qureySnapshot.docs
        .map(
          (e) => UserModel.fromSnapshot(e),
        )
        .toList());
  }

  void _createData(UserModel userModel) {
    final userCollection = FirebaseFirestore.instance.collection("users");

    String id = userCollection.doc().id;

    final newUser = UserModel(
      username: userModel.username,
      age: userModel.age,
      adress: userModel.adress,
      id: id,
    ).toJson();

    userCollection.doc(id).set(newUser);
  }

  void _updateData(UserModel userModel) {
    final userCollection = FirebaseFirestore.instance.collection("users");

    final newData = UserModel(
      username: userModel.username,
      id: userModel.id,
      adress: userModel.adress,
      age: userModel.age,
    ).toJson();

    userCollection.doc(userModel.id).update(newData);
  }

  void _deleteData(String id) {
    final userCollection = FirebaseFirestore.instance.collection("users");

    userCollection.doc(id).delete();
  }
}

class UserModel {
  final String? username;
  final String? adress;
  final int? age;
  final String? id;

  UserModel({this.id, this.username, this.adress, this.age});

  static UserModel fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    return UserModel(
      username: snapshot['username'],
      adress: snapshot['adress'],
      age: snapshot['age'],
      id: snapshot['id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "username": username,
      "age": age,
      "id": id,
      "adress": adress,
    };
  }
}
