import 'dart:convert';

UsersModel usersModelFromJson(String str) => UsersModel.fromJson(json.decode(str));
 
class UsersModel {
    int code;
    String message;
    UserModel data;

    UsersModel({
        required this.code,
        required this.message,
        required this.data,
    });

    factory UsersModel.fromJson(Map<String, dynamic> json) => UsersModel(
        code: json["code"],
        message: json["message"],
        data: UserModel.fromJson(json["data"]),
    ); 
}

class UserModel {
    int idUser;
    String name;
    String user;
    int roll;
    String token;

    UserModel({
        required this.idUser,
        required this.name,
        required this.user,
        required this.roll,
        required this.token,
    });

    factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        idUser: json["id_user"],
        name: json["name"],
        user: json["user"],
        roll: json["roll"],
        token: json["token"] ?? '',
    );
 
}
