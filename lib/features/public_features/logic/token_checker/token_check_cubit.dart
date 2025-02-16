import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:real_state/features/public_features/functions/secure_storage/secure_storage.dart';

part 'token_check_state.dart';

class TokenCheckCubit extends Cubit<TokenCheckState> {
  TokenCheckCubit() : super(TokenCheckInitial());

  tokenChecker() async {
    final status = await SecureStorage().getUserToken();
    if (status != null) {
      emit(TokenCheckIsLogedState());
    } else {
      emit(TokenCheckIsNotLogedState());
    }
  }
}
