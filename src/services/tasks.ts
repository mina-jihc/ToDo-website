import type { ToDo } from "../types.js";
import { taskService } from '../services/taskService'

export const readDB = async (): Promise<ToDo[]> => {
  try {
    const result = await taskService.getAll();
    return result;
  } catch {
    return [];
  }
};

export const createTask = async (
  title: string,
  user_id: number,
): Promise<ToDo> => {
  const result = await taskService.create(user_id, title)
  return result;
};

export const createTaskWithTag = async (
  title: string,
  user_id: number,
  tag_id: number,
): Promise<ToDo> => {
  return taskService.createWithTag(user_id, title, tag_id)
};