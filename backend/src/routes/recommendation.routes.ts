import { Router } from 'express';
import RecommendationController from '../controllers/recommendation.controller';
import { nonEmptyString, validateInputs } from '../utils/validation.utils';
import { body } from 'express-validator';

const recommendationRouter = Router();

recommendationRouter.get('/', RecommendationController.getAllRecommendations);
recommendationRouter.post(
  '/create',
  nonEmptyString(body('name')),
  body('tags').isArray().withMessage('tags must be an array'),
  nonEmptyString(body('tags.*')),
  nonEmptyString(body('link')),
  validateInputs,
  RecommendationController.createRecommendation
);
export default recommendationRouter;
