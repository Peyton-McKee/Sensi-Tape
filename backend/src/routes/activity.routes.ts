import { Router } from 'express';
import ActivityController from '../controllers/activity.controller';
import { body } from 'express-validator';
import { intMinZero, nonEmptyString, validateInputs } from '../utils/validation.utils';

const activityRouter = Router();

activityRouter.get('/levels', ActivityController.getAllActivityLevels);
activityRouter.get('/types', ActivityController.getAllActivityTypes);
activityRouter.post(
  '/:userId/create',
  nonEmptyString(body('title')),
  nonEmptyString(body('type')),
  intMinZero(body('time')),
  intMinZero(body('duration')),
  intMinZero(body('distance')),
  validateInputs,
  ActivityController.createActivity
);
export default activityRouter;
