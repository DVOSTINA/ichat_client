import 'dart:convert';

import 'package:http/http.dart';
import 'package:ichat/data/info.dart';
import 'package:image_picker/image_picker.dart';

import '../data/server.dart';

class CustomResponse {
  CustomResponse({
    required this.networkStatus,
    required this.responsedata,
  });

  final bool networkStatus;
  final Map<String, dynamic> responsedata;
}

class ServerApi {
  //! Send Post
  Future<Response> _sendPost(Map<String, String> data) async {
    Response response;
    try {
      response = await post(
        Uri.parse(getIpApi),
        headers: <String, String>{
          'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
        },
        body: data,
      ).timeout(const Duration(seconds: 10));
    } catch (e) {
      response = Response("", 404);
    }

    return response;
  }

  //! Api Login
  Future<CustomResponse> login(String username, String password) async {
    Response response = await _sendPost({
      "username": username,
      "password": password,
      "query": "{login{id,firstname,lastname,username,profile,bio,grade,major,lastNotify,online_at}}",
    });

    return CustomResponse(
      networkStatus: response.statusCode == 200,
      responsedata: response.statusCode == 200 ? jsonDecode(response.body)["data"] : {},
    );
  }

  //! Api Get Users
  Future<CustomResponse> getUsers() async {
    Response response = await _sendPost({
      "username": getMyInfo().username,
      "password": getMyPassword(),
      "query": "{users{id,firstname,lastname,username,profile,bio,grade,major,lastNotify,online_at}}",
    });

    return CustomResponse(
      networkStatus: response.statusCode == 200,
      responsedata: response.statusCode == 200 ? jsonDecode(response.body) : {},
    );
  }

  //! Api Get Rooms
  Future<CustomResponse> getRoom() async {
    Response response = await _sendPost({
      "username": getMyInfo().username,
      "password": getMyPassword(),
      "query": "{rooms{id,creatorId,userId,create_at,update_at,messages(limit:10,page:0){id,senderId,receiverId,roomId,text,file,removed,received,edit,seen,create_at,update_at}}}",
    });

    return CustomResponse(
      networkStatus: response.statusCode == 200,
      responsedata: response.statusCode == 200 ? jsonDecode(response.body) : {},
    );
  }

  //! Api Get Messages
  Future<CustomResponse> getMessages(int page) async {
    Response response = await _sendPost({
      "username": getMyInfo().username,
      "password": getMyPassword(),
      "query": "{messages(limit:10,page:" + page.toString() + "){id,senderId,receiverId,roomId,text,file,removed,received,edit,seen,create_at,update_at}}",
    });

    return CustomResponse(
      networkStatus: response.statusCode == 200,
      responsedata: response.statusCode == 200 ? jsonDecode(response.body) : {},
    );
  }

  //! Api Get News
  Future<CustomResponse> getNews() async {
    Response response = await _sendPost({
      "username": getMyInfo().username,
      "password": getMyPassword(),
      "query": "{news{id,senderId,text,file,removed,edit,create_at,update_at}}",
    });

    return CustomResponse(
      networkStatus: response.statusCode == 200,
      responsedata: response.statusCode == 200 ? jsonDecode(response.body) : {},
    );
  }

  //! Api Set Last Notify
  Future<CustomResponse> lastNotify(int lastNotify) async {
    Response response = await _sendPost({
      "username": getMyInfo().username,
      "password": getMyPassword(),
      "query": "{setLastNotify(id:" + getMyInfo().id.toString() + ",lastNotify:" + lastNotify.toString() + "){id,lastNotify}}",
    });

    return CustomResponse(
      networkStatus: response.statusCode == 200,
      responsedata: response.statusCode == 200 ? jsonDecode(response.body) : {},
    );
  }

  //! Api Set Profile
  Future<Response> setProfile(String firstName, String lastName, XFile img) async {
    Response response = await _sendPost({
      "id": getMyInfo().id.toString(),
      "username": getMyInfo().username,
      "password": getMyInfo().username,
      "firstName": firstName,
      "lastName": lastName,
      "profile": base64Encode(await img.readAsBytes()),
    });

    return response;
  }
}

ServerApi serverApi = ServerApi();
