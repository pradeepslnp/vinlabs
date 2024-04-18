import 'dart:convert';

import 'package:demo_app/models/data_model.dart';
import 'package:demo_app/services/http_service.dart';

class HomePageBusiness {
  List<DataModel> getContainerLogs = [];
  callApi(index) async {
    var response = await HttpService.httpPhpGet(
        "https://fakestoreapi.com/products?$index");
    Iterable list = json.decode(response.body);

    return getContainerLogs = list.map((e) => DataModel.fromJson(e)).toList();
  }
}
