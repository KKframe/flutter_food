class FoodItem {
  final int id;
  final String name;
  final int price;
  final String image;

  FoodItem({
    required this.id,
    required this.name,
    required this.price,
    required this.image,
  }); //กำหนดเป็น named parameter เพื่อบังคับให้ส่งค่า ห้ามเป็น null เด็ดขาด

  factory FoodItem.fromJson(Map<String, dynamic> json) {
    return FoodItem(
      id: json['id'],
      name: json['name'],
      price: json['price'],
      image: json['image'],
    );
  }

  FoodItem.fromJson2(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        price = json['price'],
        image = json['image'];

  @override
  String toString() {
    return '$id: $name ราคา $price บาท';
  }
}