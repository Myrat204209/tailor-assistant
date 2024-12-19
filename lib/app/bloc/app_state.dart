// part of 'app_bloc.dart';

// enum AppStatus { initial, loading, success, offline, failure }

// final class AppState extends Equatable {
//   const AppState({
//     this.status = AppStatus.initial,
//     this.isLoading = false,
//     this.isOffline = false,
//   });
//   const AppState.initial() : this(status: AppStatus.initial);
//   final AppStatus status;
//   final bool isLoading;
//   final bool isOffline;
//   @override
//   List<Object> get props => [status, isLoading, isOffline];

//   AppState copyWith({
//     AppStatus? status,
//     bool? isLoading,
//     bool? isOffline,
//   }) {
//     return AppState(
//       status: status ?? this.status,
//       isLoading: isLoading ?? this.isLoading,
//       isOffline: isOffline ?? this.isOffline,
//     );
//   }
// }
