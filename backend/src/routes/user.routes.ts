import { Router } from 'express';
import UserController from '../controllers/user.controller';
import { body } from 'express-validator';
import { intMinZero, nonEmptyString, validateInputs } from '../utils/validation.utils';

const userRouter = Router();

userRouter.get('/', UserController.getAllUsers);

userRouter.get('/:userId', UserController.getSingleUser);

userRouter.get('/:userId/recommendations', UserController.getUserRecommendations);

userRouter.post(
  '/:userId/update-settings',
  intMinZero(body('weight')),
  nonEmptyString(body('gender')),
  nonEmptyString(body('activityLevel')),
  intMinZero(body('height')),
  intMinZero(body('age')),
  validateInputs,
  UserController.upsertUserSettings
);

export default userRouter;
