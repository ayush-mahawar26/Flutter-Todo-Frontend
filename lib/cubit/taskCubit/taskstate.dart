abstract class TaskState {}

class InitialTaskState extends TaskState {}

class TaskLoading extends TaskState {}

class TaskUploadingError extends TaskState {
  String err;
  TaskUploadingError(this.err);
}

class TaskDeleting extends TaskState {}

class TaskDeleted extends TaskState {}

class TaskDeletionFailed extends TaskState {
  String err;
  TaskDeletionFailed(this.err);
}

class TaskGettingError extends TaskState {
  String err;
  TaskGettingError(this.err);
}

class TaskGet extends TaskState {}

class TaskUploaded extends TaskState {}

class TaskUpdating extends TaskState {}

class TaskUpdated extends TaskState {}

class TaskUpdateError extends TaskState {
  String err;
  TaskUpdateError(this.err);
}
