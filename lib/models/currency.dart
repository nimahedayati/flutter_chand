class Currency {
  final String title;
  final String name;
  final String type;
  final int currentPrice;
  final int previousPrice;
  final String imageUrl;

  Currency({
    required this.title,
    required this.name,
    required this.type,
    required this.currentPrice,
    required this.previousPrice,
    required this.imageUrl,
  });

  factory Currency.fromJson(Map<String, dynamic> json) {
    return Currency(
      title: json['title'] ?? '',
      name: json['name'] ?? '',
      type: json['type'] ?? '',
      currentPrice: json['current_price'] ?? 0,
      previousPrice: json['previous_price'] ?? 0,
      imageUrl: json['image_url'] ?? '',
    );
  }
} 