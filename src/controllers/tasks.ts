import type { NextFunction, Request, Response } from "express";
import { AppError } from "../utils/AppError.js";
import { createTaskSchema } from "../utils/taskSchema.js";
import { updateTaskSchema } from "../utils/updateTaskSchema.js";
import { querySchema } from "../utils/querySchema.js";
import { taskService } from "../services/taskService.js";

export const getTasks = async ( req: Request, res: Response, next: NextFunction ) => {
   try {
    const result = querySchema.safeParse(req.query);
   
  if (!result.success) {
    return next(
      new AppError(result.error.issues[0]?.message ?? "Invalid data", 400),
    );
  }
  const { data } = result;
  let result2 = await taskService.getAll();
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

  if (data.page) {
    const limit = data.limit ?? 10; 
    const page = data.page ?? 1;

    let start = (page - 1) * limit;  
    let end = start + limit;
    result2 = result2.slice(start, end);
  }
  
  res.status(200).json(result2);
  } catch (error) {
  next(error)
}
};

export const postTask = async (          // POST
  req: Request,
  res: Response,
  next: NextFunction,
) => {
  const result = createTaskSchema.safeParse(req.body);

  if (!result.success) {
    return next(
      new AppError(result.error.issues[0]?.message ?? "Invalid data", 400),
    );
  }
  const { title, user_id } = result.data; 

  try {
    const db_result = await taskService.create(user_id, title);
    const newTodo = db_result;
    res.status(201).json(newTodo);
  } catch (err) {
     next(err)
  }
};

export const editTask = async (req: Request, res: Response, next: NextFunction) => {
  try {
    const result = updateTaskSchema.safeParse(req.body);
    if (!result.success) {
      return next(new AppError(result.error.issues[0]?.message ?? "Invalid data", 400));
    }
    const id = Number(req.params.id);
    if (!Number.isInteger(id) || id <= 0) {
      return next(new AppError("Invalid id", 400));
    }
    const update = await taskService.update(id, result.data);
    res.status(200).json(update);
  } catch (err) {
    next(err);
  }
};


export const deleteTask = async (req: Request, res: Response, next: NextFunction) => {
  try {
    const id = Number(req.params.id);
    if (!Number.isInteger(id) || id <= 0) {
      return next(new AppError("Invalid id", 400));
    }
    const result = await taskService.remove(id);
    if (!result) {
      return next(new AppError("Task not found", 404));
    }
    res.status(200).json(result);
  } catch (err) {
    next(err);
  }
};

