import { NextFunction, Request, Response } from 'express';
import { validationResult } from 'express-validator';

/**
 * Custom Error type that has a status code and a message (from the default Error class)
 */
export class HttpException extends Error {
  public status: number;

  /**
   * Constructs an error with a status and message.
   * @param status the status code of the error (e.g., 400, 404, 403)
   * @param message the message to send with the error
   */
  constructor(status: number, message: string) {
    super(message);
    this.status = status;
  }
}

export const validateInputs = (req: Request, res: Response, next: NextFunction): Response | void => {
  const errors = validationResult(req);
  if (!errors.isEmpty()) {
    return res.status(400).json({ errors: errors.array() });
  }
  next();
};
