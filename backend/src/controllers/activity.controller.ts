import { NextFunction, Request, Response } from 'express';
import ActivityService from '../services/activity.services';

export default class ActivityController {
  static async getAllActivityLevels(req: Request, res: Response, next: NextFunction) {
    try {
      res.status(200).json(await ActivityService.getAllActivityLevels());
    } catch (error: unknown) {
      next(error);
    }
  }

  static async getAllActivityTypes(req: Request, res: Response, next: NextFunction) {
    try {
      res.status(200).json(await ActivityService.getAllActivityTypes());
    } catch (error: unknown) {
      next(error);
    }
  }

  static async createActivity(req: Request, res: Response, next: NextFunction) {
    try {
      const { userId } = req.params;
      const { title, type, time, duration, distance } = req.body;
      const activity = await ActivityService.createActivity(userId, title, type, time, duration, distance);
      res.status(200).json(activity);
    } catch (error: unknown) {
      next(error);
    }
  }
}
