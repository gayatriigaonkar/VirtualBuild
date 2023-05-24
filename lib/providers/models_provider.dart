import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:virtualbuild/models/models3d_model.dart';

class ModelsProvider with ChangeNotifier {
  bool init = false;
  List<Models3D> models = [
    
  ];

  RangeValues currentRangeValuesPrice = const RangeValues(4000, 12000);
  RangeValues currentRangeValuesArea = const RangeValues(1800, 3000);
  double currentValueFloor = 3;
  double currentValueBeds = 6;
  double currentValueBaths = 5;

  List<Models3D> get getModel {
    return [...models];
  }

  Stream<List<Models3D>> get getMyModels {
    var result =
        FirebaseFirestore.instance.collection("models").snapshots().map(
              (snapshot) => snapshot.docs
                  .map((docs) => Models3D.fromJson(docs.data()))
                  .toList(),
            );
    return result;
  }

  List<Models3D> get getFilteredModel {
    print("currentRangeValuesPrice $currentRangeValuesPrice");
    print("currentRangeValuesArea $currentRangeValuesArea");
    print("currentValueFloor $currentValueFloor");
    print("currentValueBeds $currentValueBeds");
    List<Models3D> w3 = models
        .where((e) =>
            (e.modelPrice >= currentRangeValuesPrice.start &&
                e.modelPrice <= currentRangeValuesPrice.end) &&
            (e.modelTotalSquareFootage >= currentRangeValuesArea.start &&
                e.modelTotalSquareFootage <= currentRangeValuesArea.end) &&
            (e.modelFloors >= currentValueFloor) &&
            (e.modelNumberOfBedrooms >= currentValueBeds) &&
            (e.modelNumberOfBaths >= currentValueBaths))
        .toList();
    //models = w3;
    print(w3.length);
    return w3;
  }

  Future<List<Models3D>> get getFavModel async {
    List<Models3D> r = [];
    try {
      var favArch = [];
      final userId = FirebaseAuth.instance.currentUser!.uid;
      DocumentSnapshot<Map<String, dynamic>> userData = await FirebaseFirestore
          .instance
          .collection('users')
          .doc(userId)
          .get();
      favArch = userData["favorites"];
      for (var element in favArch) {
        var result = await FirebaseFirestore.instance
            .collection("models")
            .doc(element)
            .get();
        //print("name ${result["architectName"]}");
        //r.add(Models3D.fromJson(result.data() as Map<String, dynamic>));
        //print(r.length);
      }
      //print("fav $favArch");
      return r;
    } catch (e) {
      print(e);
      return [];
    }
  }

  Models3D getModelById(String id) {
    return models.firstWhere((prod) => prod.modelId == id);
  }
}
