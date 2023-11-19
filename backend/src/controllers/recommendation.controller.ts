import { NextFunction, Request, Response } from 'express';
import RecommendationService from '../services/recommendation.services';

export default class RecommendationController {
  static async getAllRecommendations(_req: Request, res: Response, next: NextFunction) {
    try {
      res.status(200).json(await RecommendationService.getAllRecommendations());
    } catch (error: unknown) {
      next(error);
    }
  }

  static async createRecommendation(req: Request, res: Response, next: NextFunction) {
    try {
      const { name, tags, link } = req.body;
      res.status(201).json(await RecommendationService.createRecommendation(name, tags, link));
    } catch (error: unknown) {
      next(error);
    }
  }
}
