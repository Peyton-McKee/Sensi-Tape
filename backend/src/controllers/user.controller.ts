import { NextFunction, Request, Response } from 'express';
import UserService from '../services/user.services';
import { PublicUser } from '../public-types/public-user';

export default class UserController {
  static async getAllUsers(_req: Request, res: Response, next: NextFunction) {
    try {
      const allUsers = await UserService.getAllUsers();

      res.status(200).json(allUsers);
    } catch (error) {
      next(error);
    }
  }

  static async getSingleUser(req: Request, res: Response, next: NextFunction) {
    try {
      const { userId } = req.params;
      const user: PublicUser = await UserService.getSingleUser(userId);
      res.status(200).json(user);
    } catch (error: unknown) {
      next(error);
    }
  }

  static async getUserRecommendations(req: Request, res: Response, next: NextFunction) {
    try {
      const { userId } = req.params;
      const recommendations = await UserService.getUserRecommendations(userId);
      res.status(200).json(recommendations);
    } catch (error: unknown) {
      next(error);
    }
  }
}
