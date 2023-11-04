import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../authentication/controller/login/login_bloc.dart';
import '../../model/cart_response_model.dart';
import '../cart_repository.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  final CartRepository _cartRepository;

  final LoginBloc _loginBloc;

  CartCubit({
    required LoginBloc loginBloc,
    required CartRepository cartRepository,
  })  : _cartRepository = cartRepository,
        _loginBloc = loginBloc,
        super(const CartStateInitial());

  CartResponseModel? cartResponseModel;

  Future<void> getCartProducts() async {
    if (_loginBloc.userInfo == null) {
      emit(const CartStateLoading());
      emit(const CartStateError("Please login first", 401));
      return;
    }

    emit(const CartStateLoading());

    final result =
        await _cartRepository.getCartProducts(_loginBloc.userInfo!.accessToken);

    result.fold(
      (failure) {
        emit(CartStateError(failure.message, failure.statusCode));
      },
      (successData) {
        cartResponseModel = successData;
        emit(CartStateLoaded(successData));
      },
    );
  }

  Future<void> removerCartItem(String productId) async {
    if (_loginBloc.userInfo == null) {
      emit(const CartStateLoading());
      emit(const CartStateError("Please login first", 401));
      return;
    }

    emit(const CartStateDecIncrementLoading());

    final result = await _cartRepository.removerCartItem(
        productId, _loginBloc.userInfo!.accessToken);

    result.fold(
      (failure) {
        emit(CartStateDecIncretError(failure.message, failure.statusCode));
      },
      (successData) {
        cartResponseModel = successData;
        emit(CartStateLoaded(successData));
      },
    );
  }

  Future<void> incrementQuantity(String productId) async {
    if (_loginBloc.userInfo == null) {
      emit(const CartStateLoading());
      emit(const CartStateDecIncretError("Please login first", 401));
      return;
    }
    emit(const CartStateDecIncrementLoading());

    final result = await _cartRepository.incrementQuantity(
        productId, _loginBloc.userInfo!.accessToken);

    result.fold(
      (failure) {
        emit(CartStateDecIncretError(failure.message, failure.statusCode));
      },
      (successData) {
        cartResponseModel = successData;
        emit(CartStateLoaded(successData));
      },
    );
  }

  Future<void> decrementQuantity(String productId) async {
    if (_loginBloc.userInfo == null) {
      emit(const CartStateLoading());
      emit(const CartStateDecIncretError("Please login first", 401));
      return;
    }
    emit(const CartStateDecIncrementLoading());

    final result = await _cartRepository.decrementQuantity(
        productId, _loginBloc.userInfo!.accessToken);

    result.fold(
      (failure) {
        emit(CartStateDecIncretError(failure.message, failure.statusCode));
      },
      (successData) {
        cartResponseModel = successData;
        emit(CartStateLoaded(successData));
      },
    );
  }

  Future<void> applyCoupon(String coupon) async {
    if (_loginBloc.userInfo == null) {
      emit(const CartStateLoading());
      emit(const CartStateDecIncretError("Please login first", 401));
      return;
    }
    emit(const CartStateDecIncrementLoading());

    final result = await _cartRepository.applyCoupon(
        coupon, _loginBloc.userInfo!.accessToken);

    result.fold(
      (failure) {
        emit(CartStateDecIncretError(failure.message, failure.statusCode));
      },
      (successData) {
        cartResponseModel = successData;
        emit(CartStateLoaded(successData));
      },
    );
  }
}
