import { Router } from "express";
import { taskService } from "../services/taskService.js";
import { handlePrismaError } from "../utils/prismaError.js";

const router = Router();

router.post("/", async (req, res, next) => {
  try {
    const tag = await taskService.createTag(req.body.name);
    res.status(201).json(tag);
  } catch (err) {
    const { status, message } = handlePrismaError(err);
    res.status(status).json({ error: message });
  }
});

export default router;