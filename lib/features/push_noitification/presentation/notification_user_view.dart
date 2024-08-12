import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:tracker_app/src/core/routes/app_router.dart';
import 'package:tracker_app/src/core/theme/theme.dart';
import 'package:tracker_app/src/core/widgets/widgets.dart';
import 'package:tracker_app/src/features/orders/data/order_repo.dart';
import 'package:tracker_app/src/features/orders/domain/order_model.dart';
import 'package:tracker_app/src/features/orders/presentation/order_history/widgets/reusable_order_history_widget.dart';
import 'package:tracker_app/src/features/push_noitification/domain/model/notification_model.dart';
import 'package:tracker_app/src/features/push_noitification/presentation/controller/notification_controller.dart';

class NotificationUserView extends ConsumerStatefulWidget {
  static const routeName = '/notification_user';

  const NotificationUserView({super.key});

  @override
  ConsumerState<NotificationUserView> createState() =>
      _NotificationUserViewState();
}

class _NotificationUserViewState extends ConsumerState<NotificationUserView> {
  List<NotificationModel>? messageList;

  @override
  void initState() {
    super.initState();
    ref.read(notificationController.notifier).getNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AuthenticatedAppBar(
        title: 'Notifications',
        actions: [],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await ref.read(notificationController.notifier).getNotifications();
        },
        notificationPredicate: (notification) {
          return true;
        },
        child: ListView(
          padding: const EdgeInsets.all(8),
          children: <Widget>[
            // case for notification
            ref.watch(notificationController).maybeWhen(
                  loading: (_) =>
                      const Center(child: CircularProgressIndicator()),
                  failure: (error, stackTrace) => Center(
                    child: Text('Error: $error'),
                  ),
                  success: (value, _) {
                    messageList = value;
                    return messageList != null && messageList!.isNotEmpty
                        ? SizedBox(
                            height: MediaQuery.of(context).size.height * 0.9,
                            child: ListView.separated(
                              separatorBuilder: (context, index) =>
                                  const Divider(
                                color: UIColors.kPrimaryColor,
                              ),
                              itemCount: messageList!.length,
                              itemBuilder: (context, index) {
                                ref.invalidate(getItemOrderProvider(
                                    messageList![index].message.orderId!));
                                return NotificationItemWidget(
                                    notificationModel: messageList![index]);
                              },
                            ),
                          )
                        :
                        // case for no notification
                        const Center(
                            child: Text('No Notifications'),
                          );
                  },
                  orElse: () =>
                      const Center(child: CircularProgressIndicator()),
                )
          ],
        ),
      ),
    );
  }
}

final getItemOrderProvider =
    FutureProvider.family.autoDispose<ItemOrder, String>((ref, orderId) async {
  return await ref.read(orderRepositoryProvider).getOrderByOrderId(orderId);
});

class NotificationItemWidget extends ConsumerStatefulWidget {
  const NotificationItemWidget({
    super.key,
    required this.notificationModel,
  });

  final NotificationModel? notificationModel;

  @override
  ConsumerState<NotificationItemWidget> createState() =>
      _NotificationItemWidgetState();
}

class _NotificationItemWidgetState
    extends ConsumerState<NotificationItemWidget> {
  @override
  void initState() {
    super.initState();

    ref.read(getItemOrderProvider(widget.notificationModel!.message.orderId!));
  }

  @override
  Widget build(BuildContext context) {
    log('${widget.notificationModel?.createdAt}');
    var date = widget.notificationModel?.createdAt;
    var formattedDate = formatTimeDifference(date!);

    return ref
        .watch(getItemOrderProvider(widget.notificationModel!.message.orderId!))
        .when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stackTrace) {
            log('Error fetching order in notification: $error');
            return const Center(
              child: Text('Error fetching order in notification.'),
            );
          },
          data: (data) {
            final order = data;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${order.sellerBusinessName}',
                    style: AppTextStyle(
                        fontSize: 14,
                        color: UIColors.grey,
                        fontWeight: FontWeight.bold)),
                ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 6),
                  title: Text(
                    '${widget.notificationModel?.message.notification.title}',
                    style:
                        AppTextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${widget.notificationModel?.message.notification.body}',
                        // 'Requested Products -3 \nModified Products - 2',
                        style: AppTextStyle(fontSize: 12, color: UIColors.grey),
                      ),
                      // const SizedBox(height: 5),
                      FittedBox(
                        child: CustomButton.text(
                            buttonHeight: 20.h,
                            alignment: Alignment.centerLeft,
                            style: AppTextStyle(
                                    fontSize: 12, color: UIColors.kPrimaryColor)
                                .copyWith(
                              decoration: TextDecoration.underline,
                              decorationColor: UIColors.kPrimaryColor,
                            ),
                            padding: EdgeInsets.zero,
                            name: 'See Product Detail',
                            onPressed: () {
                              context.push(
                                  '/${RoutePath.getOrderHistoryItemDetails}',
                                  extra: order);
                            }),
                      ),
                    ],
                  ),
                  trailing: Text(formattedDate),
                  onTap: null,
                  // () {
                  //   // context.replace("/${RoutePath.viewOrderHistory}");
                  //   // Navigator.pushNamed(context, NotificationDetail.routeName,
                  //   //     arguments: message);
                  // },
                ),
                RemoveEditConfirmWidget(order: order),
              ],
            );
          },
          // orElse: () => const Center(child: Text('Loading...')),
        );
  }

  String formatTimeDifference(DateTime timestamp) {
    DateTime now = DateTime.now();
    Duration difference = now.difference(timestamp);

    if (difference.inSeconds < 60) {
      return '${difference.inSeconds} sec ago';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes} min ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} hrs ago';
    } else if (difference.inDays < 30) {
      return '${difference.inDays} days ago';
    } else {
      return DateFormat('dd MMMM ' 'at' ' hh:mm a').format(timestamp);
    }
  }
}
