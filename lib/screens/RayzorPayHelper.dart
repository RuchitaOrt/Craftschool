
import 'package:craft_school/main.dart';
import 'package:craft_school/providers/LandingScreenProvider.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';


class RazorpayHelper {
  late Razorpay _razorpay;

  final String orderID;

  RazorpayHelper(this.orderID) {
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWallet);
  }

  void openPaymentGateway(
    Map<String, dynamic> options,
  ) {
    try {
      _razorpay.open(options);

    } catch (e) {
    
    }
  }

  Future<void> handlePaymentSuccess(PaymentSuccessResponse response) async {
    print("handlePaymentSuccess");
    print(response.toString());
    // Handle payment success
                          final provider = Provider.of<LandingScreenProvider>(routeGlobalKey.currentContext!, listen: false);
provider.payNowAPI(
  orderId:orderID,
  payment_id: response.paymentId,
  signature: response.signature,
  payment_response: "Payment Successful",
  payment_status: "1",
  transaction_id: response.paymentId
);
  }

  void handlePaymentError(PaymentFailureResponse response) {
    // Handle payment error

    Get.snackbar('Failed', 'Payment failed: ${response.code}');
  }

  void handleExternalWallet(ExternalWalletResponse response) {
    // Handle external wallet selection
    Get.snackbar('External Wallet', 'External wallet selected');
  }

  // Dispose method if needed
  void dispose() {
    _razorpay.clear();
  }
}
