class bookModel{
  String bookId;
  String bookName;
  String category;
  String price;
  String description;
  bookModel({required this.bookId,required this.bookName,required this.category, required this.price,required this.description});

  //sending data to the server
  Map <String, dynamic> toMap(){
    return{
      'bookId': bookId,
      'bookName': bookName,
      'category': category,
      'price': price,
      'descript': description,
    };
  }

  //receiving data from the backend
  factory bookModel.fromJson(Map<String, dynamic>map){
    return bookModel(
        bookId: map["bookId"],
        bookName: map["bookName"],
        price: map["price"],
        category: map["category"],
        description: map["descript"],
    );
  }
}