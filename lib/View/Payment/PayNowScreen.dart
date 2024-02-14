import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:yopee_customer/Entity/Response/Vehicle/VehicleListResponse.dart';
import 'package:yopee_customer/View/AddVehicle/AddNewVehicle.dart';

import '../../Presenter/YopeeProvider.dart';
import '../../Utility/ColorTheme.dart';

class PayNowScreen extends StatefulWidget {
  String vehicleId;
  String addressId;
  String subscriptionId;
  String subscriptionPrize;

  PayNowScreen(
      {required this.vehicleId,
      required this.addressId,
      required this.subscriptionId,
      required this.subscriptionPrize});

  PayNowScreenState createState() => PayNowScreenState();
}

class PayNowScreenState extends State<PayNowScreen> {
  final _razorpay = Razorpay();
  // Replace your apiKey & apiSecret;
  static String razorPayApiKey = 'rzp_test_QBM5qXj9Ohqaw8';
  static String razorPayApiSecret = 'nMBuv9UZoWeRLlAirGXw6s20';

  Map<String, dynamic> paymentData = {
    'amount': 50000, // amount in paise (e.g., 1000 paise = Rs. 10)
    'currency': 'INR',
    'receipt': 'order_receipt',
    'payment_capture': '1',
  };

  @override
  void initState() {
    super.initState();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var provider = Provider.of<YopeeProvider>(context, listen: false);
    });
  }

  @override
  void dispose() {
    _razorpay.clear(); // Removes all listeners
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<YopeeProvider>(context, listen: false);
    return Consumer<YopeeProvider>(builder: (context, provider, child) {
      return Scaffold(
        appBar: PreferredSize(
          child: Container(
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                color: Color(0xff00000029),
                offset: Offset(0, 0.0),
                blurRadius: 6.0,
              )
            ]),
            child: AppBar(
              elevation: 4,
              shadowColor: Color(0xff00000029),
              toolbarHeight: 53,
              leading: IconButton(
                iconSize: 25,
                icon: const Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () => Navigator.pop(context),
              ),
              centerTitle: true,
              title: Text(
                "Payment",
                style: TextStyle(
                    fontSize: 18,
                    fontFamily: "SemiBold",
                    color: Color(0xff313131)),
              ),
            ),
          ),
          preferredSize: Size.fromHeight(kToolbarHeight),
        ),
        body: provider.isLoading
            ? Container(
                alignment: Alignment.center,
                child: CircularProgressIndicator(
                  color: ColorTheme.themeCircularColor,
                  backgroundColor: ColorTheme.themeLightGrayColor,
                ))
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 43,
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      left: 20,
                    ),
                    child: Text(
                      "Card Number",
                      style: TextStyle(
                          fontSize: 14,
                          fontFamily: "Medium",
                          color: Color(0xff111111)),
                    ),
                  ),
                  Container(
                      height: 50,
                      width: 374,
                      margin: EdgeInsets.only(left: 20, top: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border:
                              Border.all(color: Color(0xff707070), width: 1)),
                      child: TextField(
                          decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(top: 20),
                        isDense: true,
                        suffixIcon: Padding(
                          padding: EdgeInsets.all(10),
                          // add padding to adjust icon
                          child: Image.asset("assets/images/payment_card.png"),
                        ),
                      ))),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 20, top: 20),
                            child: Text(
                              "Expiration Date",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: "Medium",
                                  color: Color(0xff111111)),
                            ),
                          ),
                          Container(
                              height: 50,
                              width: 175,
                              margin: EdgeInsets.only(left: 20, top: 10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                      color: Color(0xff707070), width: 1)),
                              child: TextField(
                                  decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "MM/YY",
                                contentPadding: EdgeInsets.all(10),
                                isDense: true,
                              ))),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 20, top: 20),
                            child: Text(
                              "CVV/CVC",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: "Medium",
                                  color: Color(0xff111111)),
                            ),
                          ),
                          Container(
                              height: 50,
                              width: 175,
                              margin: EdgeInsets.only(left: 20, top: 10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                      color: Color(0xff707070), width: 1)),
                              child: TextField(
                                  decoration: InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.only(top: 20),
                                isDense: true,
                                suffixIcon: Image.asset(
                                    "assets/images/payment_pin.png"),
                              ))),
                        ],
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20, top: 20),
                    child: Text(
                      "Card Holder Name",
                      style: TextStyle(
                          fontSize: 14,
                          fontFamily: "Medium",
                          color: Color(0xff111111)),
                    ),
                  ),
                  Container(
                      height: 50,
                      width: 374,
                      margin: EdgeInsets.only(left: 20, top: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border:
                              Border.all(color: Color(0xff707070), width: 1)),
                      child: TextField(
                          decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(top: 20),
                        isDense: true,
                      ))),
                  Container(
                    margin: const EdgeInsets.only(
                        left: 20, right: 20, bottom: 15, top: 35),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorTheme.themeGreenColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6.0)),
                        minimumSize: Size(374, 56),
                      ),
                      onPressed: () {
                        provider.getSubscriptionAddApi(
                            widget.vehicleId,
                            widget.addressId,
                            widget.subscriptionId,
                            widget.subscriptionPrize,
                            context);
                      },
                      child: const Text(
                        'Pay Now',
                        style: TextStyle(
                            color: ColorTheme.themeBlackColor,
                            fontSize: 18,
                            fontFamily: "SemiBold"),
                      ),
                    ),
                  )
                ],
              ),
      );
    });
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Do something when payment succeeds
    // Here we get razorpay_payment_id razorpay_order_id razorpay_signature
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet is selected
  }

  Future<void> initiatePayment() async {
    String apiUrl = 'https://api.razorpay.com/v1/orders';
    // Make the API request to create an order
    http.Response response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization':
            'Basic ${base64Encode(utf8.encode('$razorPayApiKey:$razorPayApiSecret'))}',
      },
      body: jsonEncode(paymentData),
    );

    if (response.statusCode == 200) {
      // Parse the response to get the order ID
      var responseData = jsonDecode(response.body);
      String orderId = responseData['id'];

      // Set up the payment options
      var options = {
        'key': razorPayApiKey,
        'amount': paymentData['amount'],
        'name': 'Sweet Corner',
        'order_id': orderId,
        'prefill': {'contact': '1234567890', 'email': 'test@example.com'},
        'external': {
          'wallets': ['paytm'] // optional, for adding support for wallets
        }
      };

      // Open the Razorpay payment form
      _razorpay.open(options);
    } else {
      // Handle error response
      debugPrint('Error creating order: ${response.body}');
    }
  }
}
