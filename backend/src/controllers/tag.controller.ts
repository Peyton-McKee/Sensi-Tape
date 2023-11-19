import { NextFunction, Request, Response } from 'express';
import TagService from '../services/tag.services';

export default class TagController {
  static async getAllTags(_req: Request, res: Response, next: NextFunction) {
    try {
      res.status(200).json(await TagService.getAllTags());
    } catch (error: unknown) {
      next(error);
    }
  }
}
