import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yo_gift/common/app.dart';
import 'package:yo_gift/common/logger.dart';
import 'package:yo_gift/services/verification.dart';
import 'package:yo_gift/src/user/account_setting/account_setting_controller.dart';
import 'package:yo_gift/widgets/app_button.dart';
import 'package:yo_gift/widgets/form_item.dart';

class RemoveAccount extends StatefulWidget {
  const RemoveAccount({Key? key}) : super(key: key);

  @override
  _RemoveAccount createState() => _RemoveAccount();
}

class _RemoveAccount extends State<RemoveAccount> {
  final controller = Get.put(AccountSettingController());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 239, 234, 234),
        appBar: AppBar(
          title: const Text('刪除賬號'),
        ),
        extendBody: true,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20.w),
            child: Column(
              children: [
                Container(
                  height: 80.w,
                  margin: EdgeInsets.only(bottom: 15.w),
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                          'lib/assets/images/remove_account_img.png'),
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ),
                Text(
                  '很遺憾聽到你要離開YO!GIFT的消息，在你離開之前，請閱讀以下事項:',
                  style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      height: 1.5.w),
                ),
                buildTextCard('重要須知',
                    children: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        buildText('•刪除賬號后，你將無法再查看願望清單數據、捐贈記錄，也無法查看過往的訂單記錄'),
                        buildText('•刪除賬號后,需要等待90天，才能使用相同的手機號再度註冊會員'),
                        buildText('•刪除賬號的行為無法復原')
                      ],
                    )),
                buildTextCard(
                  '若有以下情況，則需要處理完畢后，才能刪除賬號',
                  children: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildText('•仍有未完成的購買訂單'),
                      buildText('•正在等待退款'),
                      Container(
                        margin: EdgeInsets.only(top: 30.w),
                        padding: EdgeInsets.only(bottom: 10.w),
                        alignment: Alignment.center,
                        child: const Text(
                          '若對以上情況有問題，請聯繫客服了解更多',
                          style: TextStyle(
                              color: Color.fromRGBO(163, 163, 163, 1)),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 70.w),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Container(
          margin: EdgeInsets.symmetric(horizontal: 30.w, vertical: 10.w),
          child: AppButton(
            borderColor: const Color(0xffff3b30),
            backgroundColor: const Color(0xffff3b30),
            shadow: false,
            onPressed: () async {
              controller.verifyCode = '';
              final result = await app.confirm(
                height: 240.w,
                title: '刪除賬號',
                content: Container(
                    padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 0),
                    margin: EdgeInsets.only(bottom: 30.w),
                    child: GetBuilder<AccountSettingController>(
                      id: 'accountVerifyCode',
                      builder: (c2) {
                        return FormItem(
                          label: '驗證碼',
                          hintText: '請輸入驗證碼',
                          padding: EdgeInsets.only(left: 10.w),
                          keyboardType: TextInputType.number,
                          actions: [
                            Container(
                              margin: EdgeInsets.all(6.w),
                              child: AppButton(
                                round: false,
                                fixedSize: Size(84.w, 32.w),
                                fontSize: 12.sp,
                                text: c2.countdown > 0
                                    ? '${c2.countdown}s'
                                    : '獲取驗證碼',
                                onPressed: () async {
                                  await VerificationService.verifySend();
                                  c2.runTimer();
                                },
                              ),
                            ),
                          ],
                          onChanged: (value) {
                            c2.verifyCode = value!;
                            c2.update(['accountVerifyCode']);
                          },
                        );
                      },
                    )),
              );

              if (result == true) {
                if (controller.verifyCode == '') {
                  app.showToast('請輸入驗證碼！');
                  return;
                }
                final res =
                    await controller.deleteAccount(controller.verifyCode);
                if (res != null && res?.isSuccess) {
                  app.removeAccount(success: () {
                    Get.offAllNamed('/login');
                  });
                }
              }
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  '刪除賬號',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}

buildText(text) {
  return Container(
    margin: EdgeInsets.only(top: 10.w),
    child: Text(text,
        style: TextStyle(
          height: 1.5.w,
        )),
  );
}

buildTextCard(title, {children}) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(12.w),
    margin: EdgeInsets.only(top: 15.w),
    decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(6.w))),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          '$title',
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14.sp),
        ),
        children
      ],
    ),
  );
}
