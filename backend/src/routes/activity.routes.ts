import { Router } from 'express';
import ActivityController from '../controllers/activity.controller';
import { body } from 'express-validator';
import { validateInputs } from '../utils/error.utils';

const activityRouter = Router();

activityRouter.get('/levels', ActivityController.getAllActivityLevels);
activityRouter.get('/types', ActivityController.getAllActivityTypes);
activityRouter.post(
  '/:userId/create',
  body('title').isString().isLength({ min: 1, max: 255 }),
  body('type').isString(),
  body('time').isInt({ min: 0 }),
  body('duration').isInt({ min: 0 }),
  body('distance').isInt({ min: 0 }),
  validateInputs,
  ActivityController.createActivity
);
export default activityRouter;
