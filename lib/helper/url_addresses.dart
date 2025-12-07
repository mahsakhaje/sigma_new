class URLs {
  // static const String BaseAddress = 'https://sigmatec.ir:8083/';
  // static const String BaseUrl = 'https://sigmatec.ir:8083/api/v1';
  // static const String TokenUrl = 'https://sigmatec.ir:8083/token';
  // static const String PWAError = 'https://pwa.sigmatec.ir/error';
  // static const String PWASuccess = 'https://pwa.sigmatec.ir/success';

  //
  static const String BaseAddress = 'https://test.sigmatec.ir:8081/';
  static const String BaseUrl = BaseAddress + 'api/v1';
  static const String TokenUrl = BaseAddress + 'token';
  static const String PWAError = 'https://test.sigmatec.ir:81/error';
  static const String PWASuccess = 'https://test.sigmatec.ir:81/success';

// static const String IosBankCallBackFailureUrl = 'https://test.sigmatec.ir/ios-app-pay-error';
// static const String IosBankCallBackSuccessUrl = 'https://test.sigmatec.ir/ios-app-pay-success';
// static const String IosBankCallBackRaiseCreditSuccessUrl =
//     'https://test.sigmatec.ir/ios-app-credit-success';
  static const String PWARaiseCreditSuccess =
      'https://test.sigmatec.ir:81/wallet';
  static const String BankCallBackFailureUrl =
      'https://sigmatec.ir/app-pay-error';
  static const String BankCallBackSuccessUrl =
      'https://sigmatec.ir/app-pay-success';
  static const String BankCallBackRaiseCreditSuccessUrl =
      ' https://sigmatec.ir/app-credit-success';
  static const String IosBankCallBackFailureUrl =
      'https://sigmatec.ir/ios-pay-error';
  static const String IosBankCallBackSuccessUrl =
      'https://sigmatec.ir/ios-pay-success';
  static const String IosBankCallBackRaiseCreditSuccessUrl =
      'https://sigmatec.ir/ios-credit-success';
  static const String AllCarsUrl = '/configurations/getAllCars';
  static const String RegisterUrl = '/accounts/register';
  static const String UpdateUserInfoUrl = '/accounts/updateProfile';
  static const String ConfirmRegisterUrl = '/accounts/confirmRegister';
  static const String LoginUrl = '/accounts/login';
  static const String ResetPasswordUrl = '/accounts/resetPassword';
  static const String VerifyResetPasswordUrl = '/accounts/verifyResetPassword';
  static const String ConfirmNewPasswordUrl = '/accounts/confirmResetPassword';
  static const String GetSalesOrderUrl =
      '/salesorders/getSalesOrdersWithFilterForClient';
  static const String ColorsUrl = '/colors/getColors';
  static const String TrimColorsUrl = '/trimcolors/getTrimColors';
  static const String InsertPurchaseOrderUrl =
      '/purchaseorders/insertPurchaseOrder';
  static const String GetAddressesUrl = '/expertbranches/getExpertBranches';
  static const String GetAvailebleTimeUrl = '/timespans/getAvailableTimespans';
  static const String InsertOrderUrl = '/salesorders/insertSalesOrder';
  static const String UpdateSellOrder =
      '/salesorders/updateSalesOrderWithDocuments';
  static const String UpdateSellOrderByComment =
      '/salesorders/updateSalesOrderWithComment';
  static const String GetExpertAmountUrl = '/salesorders/getOrderAmount';
  static const String GetRegistrationRulesUrl =
      '/configurations/getRegistrationRules';
  static const String GetAboutUsContentUrl =
      '/configurations/getAboutUsContent';
  static const String GetSupportTelephoneUrl =
      '/configurations/getSupportTelephone';
  static const String GetSalesOrderInfoUrl =
      '/salesorders/getSalesOrderInfoWithDetails';
  static const String GetSalesOrdersWithFilterUrl =
      '/salesorders/getSalesOrdersWithFilterForClient';
  static const String ReservationForShowRoomUrl =
      '/reservations/insertReservationForShowRoom';
  static const String TransactionsUrl =
      '/salesorders/getTransactionOrdersWithFilterForClient';
  static const String PublishedTransactionsUrl =
      '/transactions/getPublishedTransactions';
  static const String BlogsUrl = '/configurations/getAllNews';
  static const String FavouritesUrl =
      '/salesorders/getAccountFavouriteSalesOrdersWithFilter';
  static const String ChangeLikeUrl = '/salesorders/changeFavouritSalesOrder';
  static const String AboutUsUrl = '/locales/fa/aboutUs.json';
  static const String GetUserInfoUrl = '/accounts/getProfileInfo';
  static const String GetAccountsSalesOrderUrl =
      '/salesorders/getAccountSalesOrders';
  static const String GetMyReservationsUrl = '/reservations/getMyReservations';
  static const String CancelShowroomUrl = '/reservations/cancelReservation';
  static const String GetMyCarsUrl = '/cars/getMyCars';
  static const String GetExpertOrderUrl = '/expertorders/getExpertOrders';
  static const String GetPurchaseOrderUrl =
      '/purchaseorders/getAccountPurchaseOrders';
  static const String GetVersionUrl = '/configurations/isValidVersion';
  static const String GetRatingExpertUrl = '/ratings/getRatingsForExpert';
  static const String AssignRateToExpertUrl = '/expertorders/assignRaitToOrder';
  static const String GetRatingSaleUrl = '/ratings/getRatingsForSales';
  static const String AssignRateToSaleUrl = '/salesorders/assignRaitToOrder';
  static const String GetPurchaseRatingUrl = '/ratings/getRatingsForPurchase';
  static const String AssignRateToPurchaseUrl =
      '/purchaseorders/assignRaitToOrder';
  static const String GetRatingReservationUrl =
      '/ratings/getRatingsForShowRoom';
  static const String AssignRateToReservationUrl =
      '/reservations/assignRaitToShowRoom';
  static String imageLinks = BaseAddress + 'documents/getImageById/';
  static const String CancelOrdersUrl = '/salesorders/cancelOrder';
  static const String CalculateDiscountAmountUrl =
      '/discountcodes/calculateDiscountAmount';
  static const String ConfirmPaymentUrl = '/salesorders/confirmSalesOrder';
  static const String OnlinePaymentUrl = '/credits/paySalesOrderOnline';
  static const String AddNewCardUrl = '/cars/addNewCar';
  static const String UpdateCardUrl = '/cars/updateCar';
  static const String RaiseCreditUrl = '/credits/raiseCredit';
  static const String GetPrivacyRulesUrl = '/configurations/getPrivacyRules';
  static const String GetExpertReportUrl = '/reports/expertOrderPrintFromSales';
  static const String DeleteCarUrl = '/cars/deleteMyCar';
  static const String CancelReasonUrl =
      '/salesorders/getSalesOrderCancelReasons';
  static const String ManaPricesUrl = '/manaprices/getManaPrices';
  static const String GetAllFaqContentsUrl = '/contents/getAllFaqContents';
  static const String GetApplicationBannersUrl =
      '/banners/getApplicationBanners';
  static const String GetContactUsContentUrl =
      '/configurations/getContactUsContent';
  static const String GetIsValidChassisNumberUrl = '/cars/isValidChassisNumber';
  static const String GetSampleFileInfoUrl = '/samplefiles/getSampleFileInfo';
  static const String GetSampleFilesUrl = '/samplefiles/getSampleFiles';
  static const String GetCarInfoUrl = '/cars/getCarInfo';
  static const String GetSuggestionTypesUrl = '/suggestions/getSuggestionTypes';
  static const String GetInsertSuggestionUrl = '/suggestions/insertSuggestion';
  static const String GetInquiryChassisNumberUrl = '/cars/inquiryChassisNumber';
  static const String EstimateUrl = '/carprices/estimate';
  static const String EstimatePriceItemsUrl = '/configurations/getAllCarPrices';
  static const String TrackingSalesOrderUrl = '/salesorders/trackingSalesOrder';
  static const String ExpertOrderPrintUrl = '/reports/expertOrderPrint';
  static const String ContractPrintUrl = '/reports/draftContractPrint';
  static const String GetAvailableAccountManagersUrl =
      '/salesorders/getAvailableAccountManagers';
  static const String GetHasActiveOrderWithChassisNumberUrl =
      '/salesorders/hasActiveOrderWithChassisNumber';
  static const String GetAllProvincesUrl = '/geonames/getAllProvinces';
  static const String GetProvinceCitiesUrl = '/geonames/getProvinceCities';
  static const String GetAvailableCitiesUrl =
      '/configurations/getAvailableCities';
  static const String GetShowRoomsUnitesUrl = '/configurations/getShowrooms';
  static const String SendOTPUrl = '/accounts/sendOtp';
  static const String ConfirmOTPUrl = '/accounts/confirmOtp';
  static const String GetApplicationsInfoUrl = '/infos/getApplicationInfos';
  static const String GetLoanDurationsUrl = '/loans/getLoanDurations';
  static const String GetCalculateLoanPaymentsUrl =
      '/loans/calculateLoanPayments';
  static const String GetAppAccountNotifsCountUrl =
      '/accountnotifs/getAppAccountNotifsCount';
  static const String SeenNotifsUrl = '/accountnotifs/seenAppNotifByAccount';
  static const String GetNotifsListUrl =
      '/accountnotifs/getAppAccountNotifications';
  static const String GetCarTypeEquipmentInfoUrl =
      '/cartypeequipments/getCarTypeEquipmentInfo';
  static const String GetCarTypeSpecTypesUrl = '/cartypes/getCarTypeSpecTypes';
  static const String GetChangePriceReportUrl =
      '/manaprices/getChangePriceReport';
  static const String UpdateAccountAnnouncementUrl =
      '/accountannouncements/updateAccountAnnouncement';
  static const String GetAccountAnnouncementInfoUrl =
      '/accountannouncements/getAccountAnnouncementInfo';
  static const String GetStockUrl =
      '/salesorders/getStock';
}
