import type { ToDo } from "../types.js";
import { pool } from "../db.js";

export const readDB = async (): Promise<ToDo[]> => {
  try {
    const result = await pool.query("select * from tasks");
    return result.rows;
  } catch {
    return [];
  }
};

export const createTask = async (
  title: string,
  user_id: number,
): Promise<ToDo> => {
  const result = await pool.query(
    "insert into tasks (title, user_id) values ($1, $2) returning *",
    [title, user_id],
  );
  return result.rows[0];
};

export const createTaskWithTag = async (
  title: string,
  user_id: number,
  tag_id: number,
): Promise<ToDo> => {
  const client = await pool.connect();
  try {
    await client.query("BEGIN");
    const task = await client.query(
      "insert into tasks (title, user_id) values ($1, $2) returning *",
      [title, user_id],
    );
    await client.query(
      "insert into task_tags (task_id, tag_id) values ($1, $2)",
      [task.rows[0].id, tag_id],
    );
    await client.query("COMMIT");
    return task.rows[0];
  } catch (e) {
    await client.query("ROLLBACK");
    throw e;
  } finally {
    client.release();
  }
};

export const updateTask = async (
  id: number,
  data: { title?: string | undefined; completed?: boolean | undefined },
): Promise<ToDo> => {
  const result = await pool.query(
    "update tasks set title = coalesce($1, title), completed = coalesce($2, completed) where id = $3 returning *",
    [data.title ?? null, data.completed ?? null, id],
  );
  return result.rows[0];
};

export const dbeleteTask = async (id: number): Promise<ToDo> => {
  const result = await pool.query(
    "delete from tasks where id = $1 returning *",
    [id],
  );
  return result.rows[0];
};