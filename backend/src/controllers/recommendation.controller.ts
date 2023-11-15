import { NextFunction, Request, Response } from 'express';
import RecommendationService from '../services/recommendation.services';

export default class RecommendationController {
  static async getAllRecommendations(req: Request, res: Response, next: NextFunction) {
    try {
      res.status(200).json(await RecommendationService.getAllRecommendations());
    } catch (error: unknown) {
      next(error);
    }
  }
}
