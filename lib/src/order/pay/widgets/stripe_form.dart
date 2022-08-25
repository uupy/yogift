import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:yo_gift/common/app.dart';
import 'package:yo_gift/common/logger.dart';
import 'package:yo_gift/widgets/app_asset_image.dart';

import 'loading_button.dart';

class StripePayForm extends StatefulWidget {
  final String publishableKey;
  final String clientSecret;
  final String accountId;
  final Function()? onSuccess;
  final Function(dynamic err)? onFailed;
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
  final controller = CardFormEditController();

  @override
  void initState() {
    controller.addListener(update);
    super.initState();
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
    return Container(
      height: 450,
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
          Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(vertical: 20.w),
            child: CardFormField(
              controller: controller,
              countryCode: 'HK',
              enablePostalCode: false,
              style: CardFormStyle(
                borderColor: Colors.blueGrey,
                textColor: Colors.black,
                fontSize: 18,
                placeholderColor: Colors.blue,
              ),
            ),
          ),
          const SizedBox(height: 15),
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
    final complete = controller.details.complete;
    if (!complete) {
      return;
    }
    try {
      Stripe.publishableKey = widget.publishableKey;
      await Stripe.instance.applySettings();
      // 2。发起支付确认付款
      final paymentIntent = await Stripe.instance.confirmPayment(
        widget.clientSecret,
        const PaymentMethodParams.card(
          paymentMethodData: PaymentMethodData(),
          options: PaymentMethodOptions(
            setupFutureUsage: PaymentIntentsFutureUsage.OffSession,
          ),
        ),
      );

      if (paymentIntent.status == PaymentIntentsStatus.Succeeded) {
        widget.onSuccess?.call();
      } else {
        app.showToast('支付失敗');
      }
    } catch (err) {
      logger.e(err.toString());
      if (err is StripeException) {
        app.showToast('${err.error.localizedMessage}');
      } else if (err is StripeError) {
        app.showToast(err.message);
      } else if (err is Exception) {
        app.showToast(err.toString());
      } else {
        app.showToast('$err');
      }
      widget.onFailed?.call(err);
    }
  }
}
