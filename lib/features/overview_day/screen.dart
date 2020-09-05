import 'package:app/core/utils/logger.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import 'screen.controller.dart';

final logger = initLogger('OverviewDayScreen');

class OverviewDayScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _uiController = Get.put(OverviewDayScreenController());

    final _content = Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Obx(
                () => IconButton(
                  icon: Icon(Icons.arrow_back_ios),
                  onPressed: _uiController.canGoPrevious && _uiController.busy
                      ? null
                      : _uiController.fetchPrevious,
                ),
              ),
              Obx(
                () => FlatButton.icon(
                  onPressed: () => _uiController.selectDate(context),
                  icon: Icon(Icons.date_range, size: 20),
                  label: Text(
                    _uiController.selectedDate,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Obx(
                () => IconButton(
                  icon: Icon(Icons.arrow_forward_ios),
                  onPressed: _uiController.canGoNext && !_uiController.busy
                      ? _uiController.fetchNext
                      : null,
                ),
              ),
            ],
          ),
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.attach_money),
          title: Text('Revenue'),
          subtitle: Obx(
            () => OverviewSubtitle(
              text: 'Last: ' +
                  _uiController.lastPurchaseDetails +
                  '\nPurchases: ' +
                  _uiController.purchasesCount.toString(),
              androidText: _uiController.revenueAndroidString +
                  ' - ' +
                  _uiController.purchasesAndroid.value.toString(),
              iosText: _uiController.revenueIOSString +
                  ' - ' +
                  _uiController.purchasesIOS.value.toString(),
            ),
          ),
          trailing: Obx(
            () => TrailingWidget(
              text: _uiController.revenueTotal,
              textColor: Colors.lightGreen,
            ),
          ),
        ),
        SizedBox(height: 10),
        ListTile(
          leading: Icon(Icons.refresh),
          title: Text('Renewals'),
          subtitle: Obx(
            () => OverviewSubtitle(
              text: 'Last: ' + _uiController.lastRenewalDate,
              androidText: _uiController.renewalsAndroid.value.toString(),
              iosText: _uiController.renewalsIOS.value.toString(),
            ),
          ),
          trailing: Obx(
            () => TrailingWidget(
              text: _uiController.renewalsCount.toString(),
              textColor: _uiController.renewalsCount > 0
                  ? Colors.lightBlue
                  : Colors.grey,
            ),
          ),
        ),
        SizedBox(height: 10),
        ListTile(
          leading: Icon(Icons.open_in_new),
          title: Text('Trial Conversions'),
          subtitle: Obx(
            () => OverviewSubtitle(
              text: 'Last: ' + _uiController.lastConversionDate,
              androidText:
                  _uiController.trialConversionsAndroid.value.toString(),
              iosText: _uiController.trialConversionsIOS.value.toString(),
            ),
          ),
          trailing: Obx(
            () => TrailingWidget(
              text: _uiController.trialConversionsCount.toString(),
              textColor: _uiController.trialConversionsCount > 0
                  ? Colors.yellow
                  : Colors.grey,
            ),
          ),
        ),
        ListTile(
          leading: Icon(Icons.person_add),
          title: Text('Subscribers'),
          subtitle: Obx(
            () => OverviewSubtitle(
              // text: 'Last: ' + _uiController.lastConversionDate ?? '',
              androidText: _uiController.subscribersAndroid.value.toString(),
              iosText: _uiController.subscribersIOS.value.toString(),
            ),
          ),
          trailing: Obx(
            () => TrailingWidget(
              text: _uiController.subscribersCount.toString(),
              textColor: Colors.white,
            ),
          ),
        ),
        ListTile(
          leading: Icon(Icons.access_alarm),
          title: Text('Trials'),
          subtitle: Obx(
            () => OverviewSubtitle(
              // text: 'Last: ' + _uiController.lastConversionDate ?? '',
              androidText: _uiController.trialsAndroid.value.toString(),
              iosText: _uiController.trialsIOS.value.toString(),
            ),
          ),
          trailing: Obx(
            () => TrailingWidget(
              text: _uiController.trialsCount.toString(),
              textColor: Colors.white,
              // androidText:
              //     _uiController.trialsAndroid.value.toString(),
              // iosText: _uiController.trialsIOS.value.toString(),
            ),
          ),
        ),
        ListTile(
          leading: Icon(Icons.money_off),
          title: Text('Refunds'),
          subtitle: Obx(
            () => OverviewSubtitle(
              // text: 'Last: ' + _uiController.lastConversionDate ?? '',
              androidText: _uiController.refundsAndroid.value.toString(),
              iosText: _uiController.refundsIOS.value.toString(),
            ),
          ),
          trailing: Obx(
            () => TrailingWidget(
              text: _uiController.refundsCount.toString(),
              textColor:
                  _uiController.refundsCount > 0 ? Colors.red : Colors.grey,
            ),
          ),
        ),
        ListTile(
          leading: Icon(Icons.payment),
          title: Text('Transactions'),
          subtitle: Obx(
            () => OverviewSubtitle(
              // text: 'Last: ' + _uiController.lastConversionDate ?? '',
              androidText: _uiController.transactionsAndroid.value.toString(),
              iosText: _uiController.transactionsIOS.value.toString(),
            ),
          ),
          trailing: Obx(
            () => TrailingWidget(
              text: _uiController.transactionsCount.toString(),
              textColor: Colors.white,
            ),
          ),
        ),
      ],
    );

    return SizedBox(
      height: Get.mediaQuery.size.height,
      width: Get.mediaQuery.size.height,
      child: Obx(
        () => Visibility(
          visible: _uiController.busy,
          replacement: _content,
          child: kIsWeb
              ? Center(child: CircularProgressIndicator())
              : Shimmer.fromColors(
                  child: _content,
                  baseColor: Colors.grey.withOpacity(0.5),
                  highlightColor: Colors.white,
                ),
        ),
      ),
    );
  }
}

class OverviewSubtitle extends StatelessWidget {
  final String text;
  final String androidText;
  final String iosText;
  const OverviewSubtitle({Key key, this.text, this.androidText, this.iosText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (text != null) ...[
          SizedBox(height: 5),
          Text(
            text,
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          ),
        ],
        SizedBox(height: 3),
        PlatformComparison(androidText: androidText, iosText: iosText),
      ],
    );
  }
}

class PlatformComparison extends StatelessWidget {
  final String androidText;
  final String iosText;

  const PlatformComparison({Key key, this.androidText, this.iosText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.android, size: 12, color: Colors.grey),
            SizedBox(width: 2),
            Text(androidText,
                style: TextStyle(color: Colors.grey, fontSize: 12)),
            SizedBox(width: 5),
          ],
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Entypo.app_store, size: 12, color: Colors.grey),
            SizedBox(width: 2),
            Text(iosText, style: TextStyle(color: Colors.grey, fontSize: 12)),
          ],
        ),
      ],
    );
  }
}

class TrailingWidget extends StatelessWidget {
  final String text;
  final Color textColor;

  const TrailingWidget({Key key, this.text, this.textColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          text,
          style: TextStyle(
              fontSize: 17, fontWeight: FontWeight.bold, color: textColor),
        ),
      ],
    );
  }
}
