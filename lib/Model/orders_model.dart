class Orders {
  Orders({
    this.id,
    this.quantity,
    this.price,
    this.discount,
    this.vat,
    this.orderDateAndTime,
    this.user,
    this.payment,
    this.orderStatus,
  });

  int id;
  int quantity;
  int price;
  dynamic discount;
  dynamic vat;
  DateTime orderDateAndTime;
  User user;
  Payment payment;
  OrderStatus orderStatus;

  factory Orders.fromJson(Map<String, dynamic> json) => Orders(
    id: json["id"],
    quantity: json["quantity"],
    price: json["price"],
    discount: json["discount"],
    vat: json["VAT"],
    orderDateAndTime: DateTime.parse(json["order_date_and_time"]),
    user: User.fromJson(json["user"]),
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
    "payment": payment.toJson(),
    "order_status": orderStatus.toJson(),
  };
}

class OrderStatus {
  OrderStatus({
    this.orderStatusCategory,
  });

  User orderStatusCategory;

  factory OrderStatus.fromJson(Map<String, dynamic> json) => OrderStatus(
    orderStatusCategory: User.fromJson(json["order_status_category"]),
  );

  Map<String, dynamic> toJson() => {
    "order_status_category": orderStatusCategory.toJson(),
  };
}

class User {
  User({
    this.id,
    this.name,
  });

  int id;
  String name;

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}

class Payment {
  Payment({
    this.paymentStatus,
  });

  int paymentStatus;

  factory Payment.fromJson(Map<String, dynamic> json) => Payment(
    paymentStatus: json["payment_status"],
  );

  Map<String, dynamic> toJson() => {
    "payment_status": paymentStatus,
  };
}
