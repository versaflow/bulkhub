part of 'cart_cubit.dart';

abstract class CartState extends Equatable {
  const CartState();

  @override
  List<Object> get props => [];
}

class CartStateInitial extends CartState {
  const CartStateInitial();
}

class CartStateLoading extends CartState {
  const CartStateLoading();
}

class CartStateDecIncrementLoading extends CartState {
  const CartStateDecIncrementLoading();
}

class CartStateError extends CartState {
  final String message;
  final int statusCode;

  const CartStateError(this.message, this.statusCode);

  @override
  List<Object> get props => [message, statusCode];
}

class CartStateDecIncretError extends CartState {
  final String message;
  final int statusCode;

  const CartStateDecIncretError(this.message, this.statusCode);

  @override
  List<Object> get props => [message, statusCode];
}

class CartStateLoaded extends CartState {
  final CartResponseModel cartResponseModel;
  const CartStateLoaded(this.cartResponseModel);

  @override
  List<Object> get props => [cartResponseModel];
}
