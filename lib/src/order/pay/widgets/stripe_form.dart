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
  PaymentIntent? _retrievedPaymentIntent;
  CardFieldInputDetails? _card;
  SetupIntent? _setupIntentResult;

  @override
  void initState() {
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
                decoration: InputDecoration(
                  labelText: theme.inputDecorationTheme.floatingLabelBehavior ==
                          FloatingLabelBehavior.always
                      ? '卡號'
                      : null,
                ),
                onCardChanged: (card) {
                  setState(() {
                    _card = card;
                  });
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
    final complete = _card?.complete ?? false;
    if (!complete) {
      return;
    }
    await Stripe.instance.applySettings();
    _setupIntentResult = await Stripe.instance.confirmSetupIntent(
      widget.clientSecret,
      PaymentMethodParams.card(
        paymentMethodData: PaymentMethodData.fromJson({}),
      ),
    );
    final paymentIntent =
        await Stripe.instance.retrievePaymentIntent(widget.clientSecret);

    final paymentMethodId =
        paymentIntent.paymentMethodId ?? _setupIntentResult?.paymentMethodId;

    setState(() {
      _retrievedPaymentIntent =
          paymentIntent.copyWith(paymentMethodId: paymentMethodId);
    });
    if (_retrievedPaymentIntent?.paymentMethodId != null && _card != null) {
      await Stripe.instance.confirmPayment(
        _retrievedPaymentIntent!.clientSecret,
        PaymentMethodParams.cardFromMethodId(
          paymentMethodData: PaymentMethodDataCardFromMethod(
              paymentMethodId: _retrievedPaymentIntent!.paymentMethodId!),
        ),
      );
    }
    widget.onSuccess?.call();
  }
}
