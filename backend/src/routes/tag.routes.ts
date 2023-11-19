import { Router } from 'express';
import TagController from '../controllers/tag.controller';

const tagRouter = Router();

tagRouter.get('/', TagController.getAllTags);
export default tagRouter;
