class Products {
  Products({
    this.id,
    this.name,
    this.image,
    this.isVisible,
    this.isAvailable,
    this.foodItemCategory,
    this.price,
    this.stockItems,
  });

  int id;
  String name;
  String image;
  int isVisible;
  int isAvailable;
  List<FoodItemCategory> foodItemCategory;
  List<Price> price;
  List<StockItem> stockItems;

  factory Products.fromJson(Map<String, dynamic> json) => Products(
    id: json["id"],
    name: json["name"],
    image: json["image"],
    isVisible: json["is_visible"],
    isAvailable: json["is_available"],
    foodItemCategory: List<FoodItemCategory>.from(json["food_item_category"].map((x) => FoodItemCategory.fromJson(x))),
    price: List<Price>.from(json["price"].map((x) => Price.fromJson(x))),
    stockItems: List<StockItem>.from(json["stock_items"].map((x) => StockItem.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "image": image,
    "is_visible": isVisible,
    "is_available": isAvailable,
    "food_item_category": List<dynamic>.from(foodItemCategory.map((x) => x.toJson())),
    "price": List<dynamic>.from(price.map((x) => x.toJson())),
    "stock_items": List<dynamic>.from(stockItems.map((x) => x.toJson())),
  };
}

class FoodItemCategory {
  FoodItemCategory({
    this.id,
    this.name,
  });

  int id;
  Name name;

  factory FoodItemCategory.fromJson(Map<String, dynamic> json) => FoodItemCategory(
    id: json["id"],
    name: nameValues.map[json["name"]],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": nameValues.reverse[name],
  };
}

enum Name { DRINKS, MAIN_COURSE, SOUPS_SALADS, DESSERTS }

final nameValues = EnumValues({
  "Desserts": Name.DESSERTS,
  "Drinks": Name.DRINKS,
  "Main Course": Name.MAIN_COURSE,
  "Soups & Salads": Name.SOUPS_SALADS
});

class Price {
  Price({
    this.originalPrice,
    this.discountedPrice,
    this.discountType,
    this.fixedValue,
    this.percentOf,
  });

  int originalPrice;
  int discountedPrice;
  DiscountType discountType;
  int fixedValue;
  int percentOf;

  factory Price.fromJson(Map<String, dynamic> json) => Price(
    originalPrice: json["original_price"],
    discountedPrice: json["discounted_price"],
    discountType: discountTypeValues.map[json["discount_type"]],
    fixedValue: json["fixed_value"] == null ? null : json["fixed_value"],
    percentOf: json["percent_of"] == null ? null : json["percent_of"],
  );

  Map<String, dynamic> toJson() => {
    "original_price": originalPrice,
    "discounted_price": discountedPrice,
    "discount_type": discountTypeValues.reverse[discountType],
    "fixed_value": fixedValue == null ? null : fixedValue,
    "percent_of": percentOf == null ? null : percentOf,
  };
}

enum DiscountType { PERCENT, FIXED }

final discountTypeValues = EnumValues({
  "fixed": DiscountType.FIXED,
  "percent": DiscountType.PERCENT
});

class StockItem {
  StockItem({
    this.quantity,
  });

  int quantity;

  factory StockItem.fromJson(Map<String, dynamic> json) => StockItem(
    quantity: json["quantity"],
  );

  Map<String, dynamic> toJson() => {
    "quantity": quantity,
  };
}

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
