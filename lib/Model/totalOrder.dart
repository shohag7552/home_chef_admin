class TotalOrder {
  TotalOrder({
    this.totalOrder,
  });

  int totalOrder;

  factory TotalOrder.fromJson(Map<String, dynamic> json) => TotalOrder(
    totalOrder: json["total_order"],
  );

  Map<String, dynamic> toJson() => {
    "total_order": totalOrder,
  };
}
