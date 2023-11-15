import { Router } from 'express';
import RecommendationController from '../controllers/recommendation.controller';

const recommendationRouter = Router();

recommendationRouter.get('/', RecommendationController.getAllRecommendations);

export default recommendationRouter;
