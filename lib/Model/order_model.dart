
class Order {
  Order({
    this.id,
    this.quantity,
    this.price,
    this.discount,
    this.vat,
    this.orderDateAndTime,
    this.user,
    this.orderFoodItems,
    this.payment,
    this.orderStatus,
  });

  int id;
  String quantity;
  String price;
  dynamic discount;
  dynamic vat;
  DateTime orderDateAndTime;
  User user;
  List<OrderFoodItem> orderFoodItems;
  Payment payment;
  OrderStatus orderStatus;

  factory Order.fromJson(Map<String, dynamic> json) => Order(
    id: json["id"],
    quantity: json["quantity"],
    price: json["price"],
    discount: json["discount"],
    vat: json["VAT"],
    orderDateAndTime: DateTime.parse(json["order_date_and_time"]),
    user: User.fromJson(json["user"]),
    orderFoodItems: List<OrderFoodItem>.from(json["order_food_items"].map((x) => OrderFoodItem.fromJson(x))),
    payment: Payment.fromJson(json["payment"]),
    orderStatus: OrderStatus.fromJson(json["order_status"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "quantity": quantity,
    "price": price,
    "discount": discount,
    "VAT": vat,
    "order_date_and_time": orderDateAndTime.toIso8601String(),
    "user": user.toJson(),
    "order_food_items": List<dynamic>.from(orderFoodItems.map((x) => x.toJson())),
    "payment": payment.toJson(),
    "order_status": orderStatus.toJson(),
  };
}

class OrderFoodItem {
  OrderFoodItem({
    this.id,
    this.name,
    this.pivot,
    this.price,
  });

  int id;
  String name;
  Pivot pivot;
  List<Price> price;

  factory OrderFoodItem.fromJson(Map<String, dynamic> json) => OrderFoodItem(
    id: json["id"],
    name: json["name"],
    pivot: Pivot.fromJson(json["pivot"]),
    price: List<Price>.from(json["price"].map((x) => Price.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "pivot": pivot.toJson(),
    "price": List<dynamic>.from(price.map((x) => x.toJson())),
  };
}

class Pivot {
  Pivot({
    this.orderId,
    this.foodItemId,
    this.foodItemPriceId,
    this.quantity,
    this.createdAt,
    this.updatedAt,
  });

  String orderId;
  String foodItemId;
  String foodItemPriceId;
  String quantity;
  DateTime createdAt;
  DateTime updatedAt;

  factory Pivot.fromJson(Map<String, dynamic> json) => Pivot(
    orderId: json["order_id"],
    foodItemId: json["food_item_id"],
    foodItemPriceId: json["food_item_price_id"],
    quantity: json["quantity"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "order_id": orderId,
    "food_item_id": foodItemId,
    "food_item_price_id": foodItemPriceId,
    "quantity": quantity,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}

class Price {
  Price({
    this.originalPrice,
    this.discountedPrice,
  });

  String originalPrice;
  String discountedPrice;

  factory Price.fromJson(Map<String, dynamic> json) => Price(
    originalPrice: json["original_price"],
    discountedPrice: json["discounted_price"],
  );

  Map<String, dynamic> toJson() => {
    "original_price": originalPrice,
    "discounted_price": discountedPrice,
  };
}

class OrderStatus {
  OrderStatus({
    this.orderStatusCategory,
  });

  OrderStatusCategory orderStatusCategory;

  factory OrderStatus.fromJson(Map<String, dynamic> json) => OrderStatus(
    orderStatusCategory: OrderStatusCategory.fromJson(json["order_status_category"]),
  );

  Map<String, dynamic> toJson() => {
    "order_status_category": orderStatusCategory.toJson(),
  };
}

class OrderStatusCategory {
  OrderStatusCategory({
    this.name,
  });

  String name;

  factory OrderStatusCategory.fromJson(Map<String, dynamic> json) => OrderStatusCategory(
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
  };
}

class Payment {
  Payment({
    this.paymentStatus,
  });

  String paymentStatus;

  factory Payment.fromJson(Map<String, dynamic> json) => Payment(
    paymentStatus: json["payment_status"],
  );

  Map<String, dynamic> toJson() => {
    "payment_status": paymentStatus,
  };
}

class User {
  User({
    this.name,
    this.email,
    this.contact,
    this.image,
    this.billingAddress,
  });

  String name;
  String email;
  String contact;
  String image;
  BillingAddress billingAddress;

  factory User.fromJson(Map<String, dynamic> json) => User(
    name: json["name"],
    email: json["email"],
    contact: json["contact"],
    image: json["image"],
    billingAddress: BillingAddress.fromJson(json["billing_address"]),
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "email": email,
    "contact": contact,
    "image": image,
    "billing_address": billingAddress.toJson(),
  };
}

class BillingAddress {
  BillingAddress({
    this.area,
    this.appartment,
    this.house,
    this.road,
    this.city,
    this.district,
    this.zipCode,
  });

  String area;
  String appartment;
  String house;
  String road;
  String city;
  String district;
  String zipCode;

  factory BillingAddress.fromJson(Map<String, dynamic> json) => BillingAddress(
    area: json["area"],
    appartment: json["appartment"],
    house: json["house"],
    road: json["road"],
    city: json["city"],
    district: json["district"],
    zipCode: json["zip_code"],
  );

  Map<String, dynamic> toJson() => {
    "area": area,
    "appartment": appartment,
    "house": house,
    "road": road,
    "city": city,
    "district": district,
    "zip_code": zipCode,
  };
}
