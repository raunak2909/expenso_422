import 'package:expenso_422/data/local/model/cat_model.dart';

class AppConstants{

  ///imgPath
  static const String img_coffee = "assets/icons/coffee.png";
  static const String img_fast_food = "assets/icons/fast-food.png";
  static const String img_travel = "assets/icons/travel.png";
  static const String img_snack = "assets/icons/snack.png";
  static const String img_shopping = "assets/icons/shopping-bag.png";
  static const String img_movie = "assets/icons/popcorn.png";
  static const String img_restaurant = "assets/icons/restaurant.png";
  static const String img_app_logo = "assets/icons/ic_app_logo.png";
  static const String img_app_logo_solid = "assets/icons/ic_app_logo_solid.png";
  static const String img_app_logo_outline_black = "assets/icons/ic_app_logo_outline.png";

  ///prefs
  static const String pref_user_id = "pref_user_id";

  static const String dbName = "expensoDB.db";
  static const String expTable = "expense";
  ///columns
  static const String columnExpId = "e_id";
  static const String columnExpTitle = "e_title";
  static const String columnExpDesc = "e_desc";
  static const String columnExpAmt = "e_amt";
  static const String columnExpBal = "e_bal";
  static const String columnExpType = "e_type";
  static const String columnExpCatId = "e_cat_id";
  static const String columnExpCreatedAt = "e_created_at";

  static const String userTable = "user";
  ///columns
  static const String columnUserId = "u_id";
  static const String columnUserName = "u_name";
  static const String columnUserEmail = "u_email";
  static const String columnUserMobNo = "u_mob_no";
  static const String columnUserPass = "u_pass";

  ///cat data
  static final List<CatModel> allCat = [
    CatModel(id: 1, title: "Snack", imgPath: img_snack),
    CatModel(id: 2, title: "Travel", imgPath: img_travel),
    CatModel(id: 3, title: "Shopping", imgPath: img_shopping),
    CatModel(id: 4, title: "Coffee", imgPath: img_coffee),
    CatModel(id: 5, title: "Fast-Food", imgPath: img_fast_food),
    CatModel(id: 6, title: "Restaurant", imgPath: img_restaurant),
    CatModel(id: 7, title: "Movie", imgPath: img_movie),
    CatModel(id: 1, title: "Snack", imgPath: img_snack),
    CatModel(id: 2, title: "Travel", imgPath: img_travel),
    CatModel(id: 3, title: "Shopping", imgPath: img_shopping),
    CatModel(id: 4, title: "Coffee", imgPath: img_coffee),
    CatModel(id: 5, title: "Fast-Food", imgPath: img_fast_food),
    CatModel(id: 6, title: "Restaurant", imgPath: img_restaurant),
    CatModel(id: 7, title: "Movie", imgPath: img_movie),
    CatModel(id: 1, title: "Snack", imgPath: img_snack),
    CatModel(id: 2, title: "Travel", imgPath: img_travel),
    CatModel(id: 3, title: "Shopping", imgPath: img_shopping),
    CatModel(id: 4, title: "Coffee", imgPath: img_coffee),
    CatModel(id: 5, title: "Fast-Food", imgPath: img_fast_food),
    CatModel(id: 6, title: "Restaurant", imgPath: img_restaurant),
    CatModel(id: 7, title: "Movie", imgPath: img_movie),
  ];

}