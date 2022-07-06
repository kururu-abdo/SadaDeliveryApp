class ProductModel {
  int _totalSize;
  int _limit;
  int _offset;
  List<Product> _products;

  ProductModel(
      {int totalSize, int limit, int offset, List<Product> products}) {
    _totalSize = totalSize;
    _limit = limit;
    _offset = offset;
    _products = products;
  }

  int get totalSize => _totalSize;
  int get limit => _limit;
  int get offset => _offset;
  List<Product> get products => _products;

  ProductModel.fromJson(Map<String, dynamic> json) {
    _totalSize = json['total_size'];
    _limit = json['limit'];
    _offset = json['offset'];
    if (json['products'] != null) {
      _products = [];
      json['products'].forEach((v) {_products.add(Product.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total_size'] = _totalSize;
    data['limit'] = _limit;
    data['offset'] = _offset;
    if (_products != null) {
      data['products'] = _products.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Product {
  int _id;
  String _addedBy;
  int _userId;
  String _name;
  List<CategoryIds> _categoryIds;
  String _unit;
  List<String> _images;
  String _thumbnail;
  List<ProductColors> _colors;
  List<String> _attributes;
  List<ChoiceOptions> _choiceOptions;
  List<Variation> _variation;
  double _unitPrice;
  double _purchasePrice;
  double _tax;
  int _minQty;
  String _taxType;
  double _discount;
  String _discountType;
  int _currentStock;
  String _details;
  String _createdAt;
  String _updatedAt;
  List<Rating> _rating;

  Product(
      {int id,
        String addedBy,
        int userId,
        String name,
        List<CategoryIds> categoryIds,
        String unit,
        int minQty,
        List<String> images,
        String thumbnail,
        List<ProductColors> colors,
        String variantProduct,
        List<String> attributes,
        List<ChoiceOptions> choiceOptions,
        List<Variation> variation,
        double unitPrice,
        double purchasePrice,
        double tax,
        String taxType,
        double discount,
        String discountType,
        int currentStock,
        String details,
        String attachment,
        String createdAt,
        String updatedAt,
        int featuredStatus,
        List<Rating> rating}) {
    _id = id;
    _addedBy = addedBy;
    _userId = userId;
    _name = name;
    _categoryIds = categoryIds;
    _unit = unit;
    _minQty = minQty;
    _images = images;
    _thumbnail = thumbnail;
    _colors = colors;
    _attributes = attributes;
    _choiceOptions = choiceOptions;
    _variation = variation;
    _unitPrice = unitPrice;
    _purchasePrice = purchasePrice;
    _tax = tax;
    _taxType = taxType;
    _discount = discount;
    _discountType = discountType;
    _currentStock = currentStock;
    _details = details;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _rating = rating;
  }

  int get id => _id;
  String get addedBy => _addedBy;
  int get userId => _userId;
  String get name => _name;
  List<CategoryIds> get categoryIds => _categoryIds;
  String get unit => _unit;
  int get minQty => _minQty;
  List<String> get images => _images;
  String get thumbnail => _thumbnail;
  List<ProductColors> get colors => _colors;
  List<String> get attributes => _attributes;
  List<ChoiceOptions> get choiceOptions => _choiceOptions;
  List<Variation> get variation => _variation;
  double get unitPrice => _unitPrice;
  double get purchasePrice => _purchasePrice;
  double get tax => _tax;
  String get taxType => _taxType;
  double get discount => _discount;
  String get discountType => _discountType;
  int get currentStock => _currentStock;
  String get details => _details;
  String get createdAt => _createdAt;
  String get updatedAt => _updatedAt;
  List<Rating> get rating => _rating;

  Product.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _addedBy = json['added_by'];
    _userId = json['user_id'];
    _name = json['name'];
    if (json['category_ids'] != null) {
      _categoryIds = [];
      json['category_ids'].forEach((v) {
        _categoryIds.add(CategoryIds.fromJson(v));
      });
    }
    _unit = json['unit'];
    _minQty = json['min_qty'];
    _images = json['images'] != null ? json['images'].cast<String>() : [];
    _thumbnail = json['thumbnail'];
    if (json['colors'] != null) {
      _colors = [];
      json['colors'].forEach((v) {
        _colors.add(ProductColors.fromJson(v));
      });
    }
    if(json['attributes'] != null) {
      _attributes = json['attributes'].cast<String>();
    }
    if (json['choice_options'] != null) {
      _choiceOptions = [];
      json['choice_options'].forEach((v) {
        _choiceOptions.add(ChoiceOptions.fromJson(v));
      });
    }
    if (json['variation'] != null) {
      _variation = [];
      json['variation'].forEach((v) {
        _variation.add(Variation.fromJson(v));
      });
    }
    if(json['unit_price'] != null){
      _unitPrice = json['unit_price'].toDouble();
    }
    if(json['purchase_price']!=null){
      _purchasePrice = json['purchase_price'].toDouble();
    }

    if(json['tax'] != null){
      _tax = json['tax'].toDouble();
    }
    _taxType = json['tax_type'];
    if(json['discount'] != null ){
      _discount = json['discount'].toDouble();
    }
    _discountType = json['discount_type'];
    _currentStock = json['current_stock'];
    _details = json['details'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    if (json['rating'] != null) {
      _rating = [];
      json['rating'].forEach((v) {
        _rating.add(Rating.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = _id;
    data['added_by'] = _addedBy;
    data['user_id'] = _userId;
    data['name'] = _name;
    if (_categoryIds != null) {
      data['category_ids'] = _categoryIds.map((v) => v.toJson()).toList();
    }
    data['unit'] = _unit;
    data['min_qty'] = _minQty;
    data['images'] = _images;
    data['thumbnail'] = _thumbnail;
    if (_colors != null) {
      data['colors'] = _colors.map((v) => v.toJson()).toList();
    }
    data['attributes'] = _attributes;
    if (_choiceOptions != null) {
      data['choice_options'] =
          _choiceOptions.map((v) => v.toJson()).toList();
    }
    if (_variation != null) {
      data['variation'] = _variation.map((v) => v.toJson()).toList();
    }
    data['unit_price'] = _unitPrice;
    data['purchase_price'] = _purchasePrice;
    data['tax'] = _tax;
    data['tax_type'] = _taxType;
    data['discount'] = _discount;
    data['discount_type'] = _discountType;
    data['current_stock'] = _currentStock;
    data['details'] = _details;
    data['created_at'] = _createdAt;
    data['updated_at'] = _updatedAt;
    if (_rating != null) {
      data['rating'] = _rating.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CategoryIds {
  int _position;

  CategoryIds({int position}) {
    _position = position;
  }

  int get position => _position;

  CategoryIds.fromJson(Map<String, dynamic> json) {
    _position = json['position'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['position'] = _position;
    return data;
  }
}

class ProductColors {
  String _name;
  String _code;

  ProductColors({String name, String code}) {
    _name = name;
    _code = code;
  }

  String get name => _name;
  String get code => _code;

  ProductColors.fromJson(Map<String, dynamic> json) {
    _name = json['name'];
    _code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = _name;
    data['code'] = _code;
    return data;
  }
}

class ChoiceOptions {
  String _name;
  String _title;
  List<String> _options;

  ChoiceOptions({String name, String title, List<String> options}) {
    _name = name;
    _title = title;
    _options = options;
  }

  String get name => _name;
  String get title => _title;
  List<String> get options => _options;

  ChoiceOptions.fromJson(Map<String, dynamic> json) {
    _name = json['name'];
    _title = json['title'];
    _options = json['options'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = _name;
    data['title'] = _title;
    data['options'] = _options;
    return data;
  }
}

class Variation {
  String _type;
  double _price;
  String _sku;
  int _qty;

  Variation({String type, double price, String sku, int qty}) {
    _type = type;
    _price = price;
    _sku = sku;
    _qty = qty;
  }

  String get type => _type;
  double get price => _price;
  String get sku => _sku;
  int get qty => _qty;

  Variation.fromJson(Map<String, dynamic> json) {
    _type = json['type'];
    _price = json['price'].toDouble();
    _sku = json['sku'];
    _qty = json['qty'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = _type;
    data['price'] = _price;
    data['sku'] = _sku;
    data['qty'] = _qty;
    return data;
  }
}

class Rating {
  String _average;
  int _productId;

  Rating({String average, int productId}) {
    _average = average;
    _productId = productId;
  }

  String get average => _average;
  int get productId => _productId;

  Rating.fromJson(Map<String, dynamic> json) {
    _average = json['average'].toString();
    _productId = json['product_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['average'] = _average;
    data['product_id'] = _productId;
    return data;
  }
}
