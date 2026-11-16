export class AuthError extends Error {
  status = 401;

  constructor(message: string) {
    super(message);
    this.name = 'AuthError';
  }
}
export class ConflictError extends AuthError {
  status = 409;
  constructor(message: string) {
    super(message);
  }
}