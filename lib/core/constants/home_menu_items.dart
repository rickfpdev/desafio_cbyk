class HomeMenuItem {
  final String label;
  final String iconAsset;
  final Function()? onTap;
  final String? url;

  const HomeMenuItem({
    required this.label,
    required this.iconAsset,
    this.onTap,
    this.url
  });
}

const List<HomeMenuItem> homeMenuItems = [
  HomeMenuItem(label: 'Automóvel', iconAsset: 'assets/svg/car.svg', url: 'https://jsonplaceholder.typicode.com/'),
  HomeMenuItem(label: 'Residência', iconAsset: 'assets/svg/house.svg'),
  HomeMenuItem(label: 'Vida', iconAsset: 'assets/svg/health.svg'),
  HomeMenuItem(label: 'Acidentes Pessoais', iconAsset: 'assets/svg/crutch.svg'),
];
