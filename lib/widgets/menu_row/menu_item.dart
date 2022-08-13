class MenuItem {
  final String? icon;
  final String? label;
  final String? path;
  final String? key;
  final bool showArrow;
  final Map<String, String>? parameters;

  MenuItem({
    this.icon,
    this.label,
    this.path,
    this.key,
    this.showArrow = true,
    this.parameters,
  });
}
