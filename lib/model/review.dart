class Review {
  String userId;
  String review;
  String placeId;
  String reviewId;
  DateTime dateCreated;

  Review(
      {this.placeId,
      this.userId,
      this.dateCreated,
      this.review,
      this.reviewId});

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'review': review,
      'placeId': placeId,
      'reviewId': reviewId,
      'dateCreated': dateCreated,
    };
  }

  Review.fromFirestore(Map<String, dynamic> doc)
      : userId = doc['userId'],
        review = doc['review'],
        placeId = doc['placeId'],
        reviewId = doc['reviewId'],
        dateCreated = doc['dateCreated'];
}
