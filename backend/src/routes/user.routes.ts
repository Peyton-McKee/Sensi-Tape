import { Router } from 'express';
import UserController from '../controllers/user.controller';

const userRouter = Router();

userRouter.get('/', UserController.getAllUsers);

userRouter.get('/:userId', UserController.getSingleUser);

userRouter.get('/:userId/recommendations', UserController.getUserRecommendations);

export default userRouter;
