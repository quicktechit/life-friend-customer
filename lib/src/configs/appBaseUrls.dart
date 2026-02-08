class Urls {
  /// base url
  static const domain = "https://pickuploadbd.com";
  static const baseUrl = "$domain/api/v1";

  static String getImageURL({required String endPoint}) => '$domain/public/$endPoint/';

  static String registration = "$baseUrl/customer/register";
  static String otpSubmit = "$baseUrl/customer/login";
  static String sliders = "$baseUrl/customer/sliders";

  static String offers = "$baseUrl/customer/offers";

  static String profile() =>
      "$baseUrl/customer/profile";
  ///pdf
  static const pdfGenerate = "$baseUrl/customer/generate-pdf";//done
  static const pdfDownload = "$baseUrl/customer/download-pdf/";//done
  ///
  static String editProfile = "$baseUrl/customer/profile-update";
  static String carList = "$baseUrl/customer/category/1";
  static String rentalTripHistory = "$baseUrl/customer/trip-history";
  static String allConfirmTripHistory = "$baseUrl/customer/all-confirm-trip-history";
  static String allCancelTripHistory = "$baseUrl/customer/all-cancel-trip-history";
  static String allCompleteTripHistory = "$baseUrl/customer/all-complete-trip-history";
  static String allOngoingTripHistory = "$baseUrl/customer/all-start-trip-history";
  static String promoCode = "$baseUrl/customer/promos";
  static String singleTripAmount = "$baseUrl/customer/trip-amount-single";
  static String cancelList = "$baseUrl/customer/cancel-reasons";
  static String returnTripHistory = "$baseUrl/customer/return-trip-status";
  static String rentalTripFormCheckSubmit = "$baseUrl/customer/trip-form-check";
  static String rentalTripSubmit = "$baseUrl/customer/trip-form-submit";
  static String extraAmount = "$baseUrl/customer/trip-request-extend-amount";
  static String productType = "$baseUrl/partner/product-types";
  static String liveBid = "$baseUrl/customer/bid-list";
  static String division = "$baseUrl/customer/divisions";
  static String returnFilter = "$baseUrl/customer/return-trip";
  static String returnAllTrip= "$baseUrl/customer/return-trip-lists";
  static String returnBidConfirm = "$baseUrl/customer/customer-bid";
  static String returnBidCancel = "$baseUrl/customer/customer-bid-cancel";
  static String expireTrip = "$baseUrl/customer/trip-expire-submit";
  static String bidConfirm = "$baseUrl/customer/bid-confirm";
  static String guideLine = "$baseUrl/customer/guide";
  static String truckCategory = "$baseUrl/partner/category-without-type";
  static String service = "$baseUrl/partner/trip-services";
  static String range = "$baseUrl/customer/trip-range?vehicle_id=";
  static String typeCatList = "$baseUrl/partner/product-types";
  static String singleReturnTripDetails =
      "$baseUrl/customer/return-single-history";
  static String singleTripDetails = "$baseUrl/customer/single-trip-history";
  static String tripCancel = "$baseUrl/customer/trip-request-cancel";
  static String tripConfirmCancel = "$baseUrl/customer/trip-confirm-cancel";
  static String returnTripConfirmCancel = "$baseUrl/customer/return-trip-confirm-cancel";
  static String notificationList = "$baseUrl/customer/notification-history";
  static String notificationDelete = "$baseUrl/customer/notification-history-clear";
  static String notificationListDelete =
      "$baseUrl/customer/notifcation/delete-all";
}
