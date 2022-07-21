class ticketResponse {
  int? id;
  String? title;
  int? priority;
  int? rating;
  int? userId;
  int? categoryId;
  int? statusId;
  String? createdAt;
  String? updatedAt;
  bool? assigned;

  ticketResponse(
      {this.id,
      this.title,
      this.priority,
      this.rating,
      this.userId,
      this.categoryId,
      this.statusId,
      this.createdAt,
      this.updatedAt,
      this.assigned});

  ticketResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    priority = json['priority'];
    rating = json['rating'];
    userId = json['user_id'];
    categoryId = json['category_id'];
    statusId = json['status_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    assigned = json['assigned'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['priority'] = this.priority;
    data['rating'] = this.rating;
    data['user_id'] = this.userId;
    data['category_id'] = this.categoryId;
    data['status_id'] = this.statusId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['assigned'] = this.assigned;
    return data;
  }
}
