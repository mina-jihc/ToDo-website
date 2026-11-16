import express from 'express';
import { deleteTask, editTask, getTasks, postTask, getTask } from '../controllers/tasks.js';
import { taskService } from '../services/taskService.js';
import { asyncHandler } from '../utils/asyncHandler.js';
import { refreshHandler } from '../controllers/auth.controller.js';
import { authMiddleware } from '../middleware/auth.middleware.js';


const router = express.Router();
router.use(authMiddleware);

router.get('/', asyncHandler(getTasks));
router.post('/', asyncHandler(postTask));
router.put('/:id', asyncHandler(editTask));
router.delete('/:id', asyncHandler(deleteTask));
router.post("/refresh", refreshHandler);
router.get('/:id', asyncHandler(getTask));

export default router;