class ReviewBody {
  String _productId;
  List<String> _fileUpload;
  String _comment;
  String _rating;

  ReviewBody({String productId, String comment, String rating, List<String> fileUpload}) {
    _productId = productId;
    _comment = comment;
    _rating = rating;
    _fileUpload = fileUpload;
  }

  String get productId => _productId;

  String get comment => _comment;

  String get rating => _rating;

  List<String> get fileUpload => _fileUpload;

  ReviewBody.fromJson(Map<String, dynamic> json) {
    _productId = json['product_id'];
    _comment = json['comment'];
    _rating = json['rating'];
    _fileUpload = json['attachment'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['product_id'] = _productId;
    data['comment'] = _comment;
    data['rating'] = _rating;
    data['attachment'] = _fileUpload;
    return data;
  }
}
