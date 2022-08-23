import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:yo_gift/widgets/app_asset_image.dart';

import 'loading_button.dart';

class StripePayForm extends StatefulWidget {
  final String publishableKey;
  final String clientSecret;
  final String accountId;
  final Function()? onSuccess;
  final Function()? onFailed;
  final Function()? onCancel;

  const StripePayForm({
    Key? key,
    required this.publishableKey,
    required this.clientSecret,
    required this.accountId,
    this.onSuccess,
    this.onFailed,
    this.onCancel,
  }) : super(key: key);

  @override
  _StripePayFormState createState() => _StripePayFormState();
}

class _StripePayFormState extends State<StripePayForm> {
  final controller = CardEditController();

  @override
  void initState() {
    controller.addListener(update);
    init();
    super.initState();
  }

  void init() {
    Stripe.publishableKey = widget.publishableKey;
    Stripe.stripeAccountId = widget.accountId;
    Stripe.instance.applySettings();
  }

  void update() => setState(() {});

  @override
  void dispose() {
    controller.removeListener(update);
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = ThemeData.light().copyWith(
      inputDecorationTheme: const InputDecorationTheme(
        filled: true,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        contentPadding: EdgeInsets.all(12),
      ),
    );
    return Container(
      height: 320,
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(20.r),
        ),
      ),
      child: Column(
        children: [
          SizedBox(
            height: 46.w,
            child: Align(
              alignment: Alignment.centerRight,
              child: AppAssetImage(
                width: 24.w,
                img: 'icon_close.png',
                onTap: widget.onCancel,
              ),
            ),
          ),
          Theme(
            data: theme,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 150,
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(vertical: 20.w),
              child: CardField(
                controller: controller,
                decoration: InputDecoration(
                  labelText: theme.inputDecorationTheme.floatingLabelBehavior ==
                          FloatingLabelBehavior.always
                      ? '卡號'
                      : null,
                ),
                onCardChanged: (card) {
                  // logger.i(card);
                },
              ),
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: 140.w,
            child: LoadingButton(
              text: '立即支付',
              onPressed: _handlePayPress,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _handlePayPress() async {
    if (!controller.complete) {
      return;
    }
    const billingDetails = BillingDetails(
      email: '',
      phone: '',
      address: Address(
        city: 'HK',
        country: 'ZH',
        line1: '',
        line2: '',
        state: '',
        postalCode: '',
      ),
    );
    final paymentIntent = await Stripe.instance.confirmPayment(
      widget.clientSecret,
      const PaymentMethodParams.card(
        billingDetails: billingDetails,
      ),
    );
    if (paymentIntent.status == PaymentIntentsStatus.Succeeded) {
      widget.onSuccess?.call();
    } else {
      widget.onFailed?.call();
    }
  }
}
