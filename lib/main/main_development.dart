import 'package:auth_repository/auth_repository.dart';
import 'package:dap_foreman_assis/app/app.dart';
import 'package:dap_foreman_assis/main/bootstrap/bootstrap.dart';
import 'package:user_repository/user_repository.dart';

void main() {
  bootstrap(() {
    final authRepository = AuthRepository();
    final userRepository = UserRepository();
    return App(
      authRepository: authRepository,
      userRepository: userRepository,
    );
  });
}
