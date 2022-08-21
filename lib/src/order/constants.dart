class OrderStatusItem {
  final String? label;
  final int? value;
  const OrderStatusItem({this.label, this.value});
}

class OrderStatus {
  OrderStatus._();
  static const items = [
    OrderStatusItem(label: '全部', value: 0),
    OrderStatusItem(label: '待支付', value: -1),
    OrderStatusItem(label: '待兌換', value: 1),
    OrderStatusItem(label: '商家準備中', value: 2),
    OrderStatusItem(label: '配送中', value: 3),
    OrderStatusItem(label: '已兌換', value: 4),
    OrderStatusItem(label: '退換中', value: 5),
    OrderStatusItem(label: '已退換', value: 6),
    OrderStatusItem(label: '已過期', value: 7),
    OrderStatusItem(label: '已贈送', value: 8),
  ];

  static String? getLabelByValue(int? value) {
    final item = items.singleWhere(
      (e) => e.value == value,
      orElse: () => const OrderStatusItem(),
    );
    return item.label;
  }
}
