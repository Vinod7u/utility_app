class ServiceConfig {
  final String title;
  final String inputHint;
  final String topSectionTitle;
  final String allSectionTitle;
  final List<Map<String, String>> topItems;
  final List<Map<String, String>> allItems;
  final bool showSearchBar;
  final bool showInfoCard;
  final String? infoCardTitle;
  final String? infoCardDescription;
  final String? infoCardButtonText;

  ServiceConfig({
    required this.title,
    required this.inputHint,
    required this.topSectionTitle,
    required this.allSectionTitle,
    required this.topItems,
    required this.allItems,
    this.showSearchBar = false,
    this.showInfoCard = false,
    this.infoCardTitle,
    this.infoCardDescription,
    this.infoCardButtonText,
  });
}

