import { NextFunction, Request, Response } from 'express';
import ExerciseService from '../services/exercie.services';

export default class ExerciseController {
  static async getAllExercises(req: Request, res: Response, next: NextFunction) {
    try {
      res.status(200).json(ExerciseService.getAllExercises());
    } catch (error: unknown) {
      next(error);
    }
  }
}
