import 'package:buger/app/modules/home/pages/detail_page.dart';
import 'package:buger/app/modules/home/provider/product_provider.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'pages/home_page.dart';

class HomeModule extends Module {
  @override
  void binds(Injector i) {
     i.addSingleton(() => ProductProvider());
  }

  @override
  void routes(RouteManager r) {
    r.child('/', child: (_) => const HomePage());
    r.child('/detail', child: (_) => const DetailPage());
  }
}
