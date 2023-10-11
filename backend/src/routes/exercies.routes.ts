import { Router } from 'express';
import ExerciseController from '../controllers/exercise.controller';

const exerciseRouter = Router();

exerciseRouter.get('/', ExerciseController.getAllExercises);

export default exerciseRouter;
