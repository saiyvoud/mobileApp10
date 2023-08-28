const baseUrl = "https://nodejs2-5f6t.onrender.com/api/v1.0.0";

/// ------- auth --------
class ApiPath {
  static String loginPath = "${baseUrl}/user/login";
  static String registerPath = "${baseUrl}/user/register";
  static String bookPath = "${baseUrl}/book/getAll";
  static String refreshToken = "${baseUrl}/user/refreshToken";
  // --------- address ----------------------
  static String getAddressByUserPath = "${baseUrl}/address/getByUser/";
  static String insertAddressPath = "${baseUrl}/address/insert";
  static String updateAddressPath = "${baseUrl}/address/update/";
}
