import { NextFunction, Request, Response } from 'express';
import UserService from '../services/user.services';

export default class UserController {
  static async getAllUsers(_req: Request, res: Response, next: NextFunction) {
    try {
      const allUsers = await UserService.getAllUsers();

      res.status(200).json(allUsers);
    } catch (error) {
      if (error instanceof Error) {
        next(error);
      }
    }
  }

  static async getSingleUser(req: Request, res: Response, next: NextFunction) {
    try {
      const { userId } = req.params;
      const user = await UserService.getSingleUser(userId);
      res.status(200).json(user);
    } catch (error: unknown) {
      if (error instanceof Error) {
        next(error);
      }
    }
  }
}
