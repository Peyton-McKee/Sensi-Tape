import { Router } from 'express';
import UserController from '../controllers/user.controller';

const userRouter = Router();

userRouter.get('/', UserController.getAllUsers);

userRouter.get('/:userId', UserController.getSingleUser);

export default userRouter;
