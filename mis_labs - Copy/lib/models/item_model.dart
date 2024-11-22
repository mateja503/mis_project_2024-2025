class Item{
  final int? id;
  final String name;
  final String description;
  final double price;
  final int? discount;
  final int in_store_count;
  final String image;

  const Item({
    this.id,
    required this.name,
    required this.description,
    required this.price,
    this.discount,
    required this.in_store_count,
    required this.image

  });

  factory Item.fromJson(Map<String,dynamic> json) => Item(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      price: json['price'],
      discount: json['discount'],
      in_store_count: json['in_store_count'],
      image: json['image']

  );


  Map<String,dynamic> toJson() => {
    'id':id,
    'name':name,
    'description':description,
    'price':price,
    'discount':discount,
    'in_store_count':in_store_count,
    'image': image
  };

}