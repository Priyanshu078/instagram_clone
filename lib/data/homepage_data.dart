class HomePageData {
  final String url;

  const HomePageData(this.url);

  factory HomePageData.fromJson(Map<String, dynamic> json) {
    return HomePageData(json['url']);
  }
}
