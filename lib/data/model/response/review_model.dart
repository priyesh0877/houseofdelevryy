class ReviewModel {
  int id;
  String comment;
  int rating;
  String foodName;
  String foodImage;
  String customerName;
  String createdAt;
  String updatedAt;

  ReviewModel(
      {required this.id,
        required this.comment,
        required this.rating,
        required this.foodName,
        required this.foodImage,
        required this.customerName,
        required this.createdAt,
        required this.updatedAt});

  ReviewModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    comment = json['comment'];
    rating = json['rating'];
    foodName = json['food_name'];
    foodImage = json['food_image'];
    customerName = json['customer_name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['comment'] = this.comment;
    data['rating'] = this.rating;
    data['food_name'] = this.foodName;
    data['food_image'] = this.foodImage;
    data['customer_name'] = this.customerName;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}