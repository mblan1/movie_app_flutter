class LoginMethod {
  final String icon;
  final String route;
  final bool isActive;

  LoginMethod({
    required this.icon,
    required this.route,
    required this.isActive,
  });
}

List<LoginMethod> loginMethods = [
  LoginMethod(
    isActive: false,
    icon: 'assets/icons/icon-google.svg',
    route: '/homePage',
  ),
  LoginMethod(
    isActive: false,
    icon: 'assets/icons/twitch.svg',
    route: '/homePage',
  ),
  LoginMethod(
    isActive: false,
    icon: 'assets/icons/apple.svg',
    route: '/homePage',
  ),
];
