import type { NextFunction, Request, Response } from "express";
import { AppError } from "../utils/AppError.js";
import { createTaskSchema } from "../utils/taskSchema.js";
import { updateTaskSchema } from "../utils/updateTaskSchema.js";
import { querySchema } from "../utils/querySchema.js";
import { taskService } from "../services/taskService.js";

export const getTasks = async (req: Request, res: Response) => {
  const result = querySchema.safeParse(req.query);
  if (!result.success) {
    throw new AppError(result.error.issues[0]?.message ?? "Invalid data", 400);
  }
  const { data } = result;

  let result2 = await taskService.getAll(req.user!.id, req.user!.role, data.page ?? 1, data.limit ?? 10);

  if (data.status === "completed") {
    result2 = result2.filter((task) => task.completed === true);
  } else if (data.status === "active") {
    result2 = result2.filter((task) => task.completed === false);
  }

  if (data.sort === "title") {
    result2 = result2.sort((a, b) => a.title.localeCompare(b.title));
  } else if (data.sort === "id") {
    result2 = result2.sort((a, b) => a.id - b.id);
  } else if (data.sort === "completed") {
    result2 = result2.sort((a, b) => Number(a.completed) - Number(b.completed));
  }

  res.status(200).json(result2);
};

export const getTask = async (req: Request, res: Response) => {
  const id = Number(req.params.id);

  if (!Number.isInteger(id) || id <= 0) {
    throw new AppError("Invalid id", 400);
  }

  const task = await taskService.getById(id, req.user!.id);
  res.status(200).json(task);
};


export const postTask = async (req: Request, res: Response) => {
  const result = createTaskSchema.safeParse(req.body);
  if (!result.success) {
    throw new AppError(result.error.issues[0]?.message ?? "Invalid data", 400);
  }

  const { title } = result.data;
  const user_id = req.user!.id;

  const newTodo = await taskService.create(user_id, title);
  res.status(201).json(newTodo);
};


export const editTask = async (req: Request, res: Response) => {
    const result = updateTaskSchema.safeParse(req.body);
    if (!result.success) {
      throw new AppError(result.error.issues[0]?.message ?? "Invalid data", 400);
    }
    const id = Number(req.params.id);
    if (!Number.isInteger(id) || id <= 0) {
      throw new AppError("Invalid id", 400);
    }
    const userId = req.user!.id;
    const update = await taskService.update(id, userId, result.data);
    res.status(200).json(update);
};


export const deleteTask = async (req: Request, res: Response) => {
    const id = Number(req.params.id);
    if (!Number.isInteger(id) || id <= 0) {
      throw new AppError("Invalid id", 400);
    }
    const userId = req.user!.id;
    const result = await taskService.remove(id);
    if (!result) {
      throw new AppError("Task not found", 404);
    }
    res.status(200).json(result);
};

