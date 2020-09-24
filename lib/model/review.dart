class Review {
  String name;
  String userId;
  String review;
  String placeId;
  String reviewId;
  String userPhoto;
  DateTime dateCreated;

  Review(
      {this.name,
      this.placeId,
      this.userId,
      this.dateCreated,
      this.review,
      this.reviewId,
      this.userPhoto});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'userId': userId,
      'review': review,
      'placeId': placeId,
      'reviewId': reviewId,
      'userPhoto': userPhoto,
      'dateCreated': dateCreated,
    };
  }

  Review.fromFirestore(Map<String, dynamic> doc)
      : name = doc['name'],
        userId = doc['userId'],
        review = doc['review'],
        placeId = doc['placeId'],
        reviewId = doc['reviewId'],
        userPhoto = doc['userPhoto'],
        dateCreated = doc['dateCreated'].toDate();
}
