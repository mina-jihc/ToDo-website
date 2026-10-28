// import { Router } from 'express';
import express from 'express';
import { deleteTask, editTask, getTasks, postTask } from '../controllers/tasks.js';
import { asyncHandler } from '../utils/asyncHandler.js';


const router = express.Router();

router.get('/', asyncHandler(getTasks));
router.post('/', asyncHandler(postTask));
router.put('/:id', asyncHandler(editTask));
router.delete('/:id', asyncHandler(deleteTask));

export default router;