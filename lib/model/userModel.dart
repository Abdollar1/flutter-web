class userModel{
  int? userId;
  String? userName;
  String? userPassword;
  int? bookId;
  userModel({this.userId,this.userName,this.userPassword, this.bookId});

  //sending data to the server
  Map <String, dynamic> toMap(){
    return{
      'userId': userId,
      'userName': userName,
      'userPassword': userPassword,
      'bookId': bookId,
    };
  }

  //receiving data from the backend
  factory userModel.fromJson(Map<String, dynamic>map){
    return userModel(
        userId: map["userId"],
        userName: map["userName"],
        userPassword: map["userPassword"],
        bookId: map["bookId"],
    );
  }
}