import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracker_app/src/core/extension/validators.dart';
import 'package:tracker_app/src/core/widgets/custom_textfield.dart';
import 'package:tracker_app/src/core/widgets/spacer.dart';
import 'package:tracker_app/src/features/push_noitification/presentation/controller/notification_controller.dart';

class NotificationAdminView extends StatefulWidget {
  static const routeName = '/notification_admin';

  const NotificationAdminView({super.key});

  @override
  State<NotificationAdminView> createState() => _NotificationAdminViewState();
}

class _NotificationAdminViewState extends State<NotificationAdminView> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    String title = '';
    String body = '';
    // final message = GoRouterState.of(context).extra as RemoteMessage?;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notification'),
      ),
      body: SafeArea(
        minimum: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              // Text('Last message from Firebase Messaging:',
              //     style: Theme.of(context).textTheme.titleLarge),
              // Text(
              //     "${message?.notification?.title} -  ${message?.notification?.body} - ${message?.data}",
              //     style: Theme.of(context).textTheme.bodyLarge),
              CustomTextFormField(
                labelText: 'Notification Title',
                onChanged: (value) {
                  title = value;
                },
                validator: Validators.requiredValidator,
              ),
              const HeightSpacer(spaceHeight: 20),
              CustomTextFormField(
                  labelText: 'Notification Body',
                  // maxlines: null,
                  validator: Validators.requiredValidator,
                  keyboardType: TextInputType.text,
                  style: const TextStyle(
                      // wordSpacing: 22,

                      // i increased the height but the text is shown in center. i want it where the cursor is
                      ),
                  onChanged: (value) {
                    body = value;
                  }),
              const HeightSpacer(spaceHeight: 20),

              Consumer(builder: (context, ref, child) {
                return Column(
                  children: [
                    // ElevatedButton(
                    //   onPressed: () async {
                    //     final notificationRepo =
                    //         ref.read(notificationRepoProvider);
                    //     await notificationRepo.sendNotification(
                    //         topic: 'user',
                    //         title: title,
                    //         body: body,
                    //         token: await FirebaseMessaging.instance.getToken());
                    //   },
                    //   child: const Text('Notify to all users'),
                    // ),
                    Consumer(
                      builder: (context, ref, child) {
                        return ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              ref
                                  .read(notificationController.notifier)
                                  .sendNotification(
                                      title: title,
                                      body: body,
                                      token: [
                                    //! error
                                  ]);
                            }
                          },
                          // style: ElevatedButton.styleFrom(
                          //   minimumSize: const Size(double.infinity, 30),
                          //   backgroundColor: Colors.blueAccent,
                          //   padding: const EdgeInsets.symmetric(
                          //     vertical: 8,
                          //   ),
                          //   shape: RoundedRectangleBorder(
                          //     borderRadius: BorderRadius.circular(8),
                          //   ),
                          // ),
                          child: ref.watch(notificationController).maybeWhen(
                              initial: (status) => const Text(
                                    "Notify to all users",
                                    style: TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                              loading: (_) {
                                return const SizedBox(
                                  height: 30,
                                  width: 30,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2.5,
                                  ),
                                );
                              },
                              success: (_, __) {
                                log('success $_');
                                return const Text(
                                  "Notify to all users",
                                  style: TextStyle(
                                    fontSize: 14,
                                  ),
                                );
                              },
                              failure: (error, stackTrace) {
                                log('error $error');
                                return const Text(
                                  "Notify to all users",
                                  style: TextStyle(
                                    fontSize: 14,
                                  ),
                                );
                              },
                              orElse: () {
                                return const Text(
                                  "Notify to all users",
                                  style: TextStyle(
                                    fontSize: 14,
                                  ),
                                );
                              }),
                        );
                      },
                    ),
                  ],
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
