class OnBoarding {
  final String title;
  final String image;

  OnBoarding({
    required this.title,
    required this.image,
  });
}

List<OnBoarding> onboardingContents = [
  OnBoarding(
    title: 'Transfert d\'argent',
    image: 'assets/images/recharge_mobile.gif',
  ),
  OnBoarding(
    title: 'Portefeuille crypto',
    image: 'assets/images/gestion_crypto.gif',
  ),
  OnBoarding(
    title: 'Caisse d\'epargne',
    image: 'assets/images/epargne.gif',
  ),
  OnBoarding(
    title: 'Frais reduit \n& \n Pourcentage d\'epargne',
    image: 'assets/images/logo_avec_nom_sur_fond_blanc.png',
  ),
];
