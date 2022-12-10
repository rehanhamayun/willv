class ApiService {
  static const apiUrl = 'http://localhost:5002/swagger/index.html';
  //static const apiUrl = 'https://www.pop-check.com/';
  static const imageUrl = "https://popcheckimages.s3.amazonaws.com/";

  static const auth = 'Auth/';
  static const card = 'Card/';
  static const user = 'User/';

  static const creationAccount = 'CreateAccount/';
  static const login = 'Login/';
  static const resetPassword = 'ResetPassword/';

  static const unauthorizedSearchingPlayerBgs =
      'UnauthorizedAdvencedSearchingPlayerBgs/';
  static const unauthorizedSearchingPlayerPsa =
      'UnauthorizedAdvencedSearchingPlayerPsa/';
  static const unauthorizedSearchingPlayerGosgc =
      'UnauthorizedAdvencedSearchingPlayerGosgc/';
  static const unauthorizedSGetCardByCoordinates =
      'UnauthorizedgetCardByCoordinates/';
  static const unauthorizedSearching = 'UnauthorizedSearching/';
  static const unauthorizedGetCardById = 'UnauthorizedGetCardById/';
  static const unauthorizedHomeSearching = 'unauthorizedHomeSearching/';

  static const profile = 'Profile/';
  static const updateProfile = 'UpdateProfile/';
  static const updateProfile2 = 'UpdateProfile2/';
  static const updatePassword = 'UpdatePassword/';

  static const searchingPlayerBgs = 'AdvencedSearchingPlayerBgs/';
  static const searchingPlayerPsa = 'AdvencedSearchingPlayerPsa/';
  static const searchingPlayerGosgc = 'AdvencedSearchingPlayerGosgc/';
  static const getCardByCoordinates = 'getCardByCoordinates/';

  static const homeSearching = 'HomeSearching/';
  static const searching = 'Searching/';
  static const getCardById = 'GetCardById/';

  static const getFavoritCards = 'getFavoritCards/';
  static const addFavoriteCard = 'addFavoriteCard/';
  static const getFavoriteCardById = 'getFavoriteCardById/';
  static const deleteFavoritCard = 'deleteFavoritCard/';
}
