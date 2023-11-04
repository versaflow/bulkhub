part of "review_cubit.dart";

abstract class ReviewSubmitState extends Equatable {
  const ReviewSubmitState();

  @override
  List<Object> get props => [];
}

class SubmitReviewStateLoading extends ReviewSubmitState {}

class SubmitReviewStateError extends ReviewSubmitState {
  final String errorMessage;
  const SubmitReviewStateError(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}

class SubmitReviewStateLoaded extends ReviewSubmitState {
  final SubmitReviewResponseModel submitReviewResponseModel;
  const SubmitReviewStateLoaded(this.submitReviewResponseModel);

  @override
  List<Object> get props => [submitReviewResponseModel];
}
