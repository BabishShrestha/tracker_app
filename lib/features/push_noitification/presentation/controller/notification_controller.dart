import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracker_app/src/core/routes/app_router.dart';
import 'package:tracker_app/src/features/push_noitification/data/repository/notification_repo.dart';
import 'package:tracker_app/src/features/push_noitification/domain/model/app_state.dart';

//! not working . state updates but doesnt show in app router. returns false.
// final isAuthenticated = StateProvider<bool>((ref) => false);
final notificationController =
    StateNotifierProvider<NotificationNotifier, AppState>(
  (ref) => NotificationNotifier(
    notificationRepository: ref.read(notificationRepoProvider),
    ref: ref,
    // settingsRepo: ref.read(settingsRepoProvider)
  ),
);

class NotificationNotifier extends StateNotifier<AppState> {
  NotificationNotifier(
      {required NotificationRepo notificationRepository,
      // required SettingsRepo settingsRepo,
      required Ref ref})
      : _notificationRepository = notificationRepository,
        // _settingsRepo = settingsRepo,
        _ref = ref,
        super(const AppState.initial());

  final NotificationRepo _notificationRepository;
  // final SettingsRepo _settingsRepo;
  final Ref _ref;

  get buildContext => NavigationService.navigatorKey.currentContext;

  void sendNotification(
      {required String title,
      required String body,
      required List<String>? token}) async {
    state = const AppState.loading();
    final successOrFailure = await _notificationRepository.sendNotification(
      tokenList: token,
      title: title,
      body: body,
    );
    successOrFailure.fold((r) {
      // Handle successful authentication
      state = const AppState.success(null);
    }, (l) {
      // Handle authentication failure
      state = AppState.failure(l);
    });
  }

  void sendNotificationToAll(
      {required String title, required String body}) async {
    state = const AppState.loading();
    final successOrFailure =
        await _notificationRepository.sendNotificationToAll(
      title: title,
      body: body,
    );
    // successOrFailure.fold((r) {
    //   // Handle successful authentication
    //   state = const AsyncValue.data(null);
    // }, (l) {
    //   // Handle authentication failure
    //   state = AsyncValue.error(l);
    // });
  }

  Future<void> getNotifications() async {
    final successOrFailure = await _notificationRepository.getNotifications();
    state = const AppState.loading();
    successOrFailure.fold((r) {
      // Handle successful authentication
      r.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      state = AppState.success(r);
    }, (l) {
      // Handle authentication failure
      state = AppState.failure(l, status: AppStatus.failure);
    });
  }
}
