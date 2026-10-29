import type { NextFunction, Request, Response } from "express";
import { readDB, writeDB } from "../services/tasks.js";
import type { ToDo } from "../types.js";
import { AppError } from "../utils/AppError.js";
import { createTaskSchema } from "../utils/taskSchema.js";
import { updateTaskSchema } from "../utils/updateTaskSchema.js";
import { querySchema } from "../utils/querySchema.js";

export const getTasks = async (
  req: Request,
  res: Response,
  next: NextFunction,
) => {
  // GET
  const result = querySchema.safeParse(req.query);
  const tasks = await readDB();

  if (!result.success) {
    return next(
      new AppError(result.error.issues[0]?.message ?? "Invalid data", 400),
    );
  }
  const { data } = result;

  let result2 = tasks;
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

    let start = (page - 1) * limit;  //page=1 limit=2  start=0,end   slice(0,2)
    let end = start + limit;
    result2 = result2.slice(start, end);
  }
  
  res.status(200).json(result2);
  return;
};

export const postTask = async (
  req: Request,
  res: Response,
  next: NextFunction,
) => {
  // POST
  const result = createTaskSchema.safeParse(req.body);

  if (!result.success) {
    return next(
      new AppError(result.error.issues[0]?.message ?? "Invalid data", 400),
    );
  }
  const { title } = result.data; // Shorter-destructurization
  // const title = result.data.title;

  const body = req.body;
  const tasks = await readDB();
  const newTodo: ToDo = {
    id: Date.now(),
    title,
    completed: false,
  };

  tasks.push(newTodo);
  await writeDB(tasks);
  res.status(201).json(newTodo);
  return;
};

export const editTask = async (      // EDIT
  req: Request,
  res: Response,
  next: NextFunction,
) => {
  const result = updateTaskSchema.safeParse(req.body);

  if (!result.success) {
    return next(
      new AppError(result.error.issues[0]?.message ?? "Invalid data", 400),
    );
  }
  const id = Number(req.params.id); 
  const tasks = await readDB();
  const index = tasks.findIndex((task) => task.id === id);
  if (index === -1) {
    return next(new AppError("Task not found", 404));
  }

  const { data } = result;
  tasks[index] = { ...tasks[index], ...data } as ToDo;
  await writeDB(tasks);
  res.status(200).json(tasks[index]);
};

export const deleteTask = async (req: Request, res: Response) => {
  // DELETE
  const body = req.body;
  const id = Number(req.params.id);
  const tasks = await readDB();

  const filtered = tasks.filter((task) => task.id !== id);

  if (tasks.length > filtered.length) {
    await writeDB(filtered);
    res.status(200).json(filtered);
    // res.status(200).json({message: "Task succesfully deleted"});
    return;
  } else {
    throw new AppError("Task not found", 404);
  }
};
