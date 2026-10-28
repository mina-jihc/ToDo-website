import http from "node:http";
import fs from "node:fs/promises";
import parse from "co-body";
import { error } from "node:console";

interface Todo {
  id: number;
  title: string;
  completed: boolean;
}

const read = async () => {
  try {
    const data = await fs.readFile("./data.json", "utf-8");
    return JSON.parse(data);
  } catch {
    return [];
  }
};

const write = async (data: Todo[]) => {
  await fs.writeFile("./data.json", JSON.stringify(data, null, 2));
};

const server = http.createServer(async (req, res) => {
  res.setHeader("Access-Control-Allow-Origin", "*");
  res.setHeader("Access-Control-Allow-Headers", "Content-Type");
  res.setHeader(
    "Access-Control-Allow-Methods",
    "OPTIONS, GET, POST, PUT, DELETE",
  );
  res.setHeader("Content-Type", "application/json");

  if (req.method === "OPTIONS") {
    res.statusCode = 200;
    return res.end();
  }

  if (req.url === "/tasks" && req.method === "GET") {
    return res.end(JSON.stringify(await read()));
  }

  if (req.url === "/post" && req.method === "POST") {
    try {
      const body = await parse.json(req);
      const tasks = await read();

      if (!body.title) {
        res.statusCode = 400;
        return res.end(JSON.stringify({ error: "Please write ur task!" }));
      }

      const newTodo: Todo = {
            id: Date.now(),
            title: body.title,
            completed: false
        };


      tasks.push(newTodo);
      await write(tasks);

      res.statusCode = 201;
      return res.end(JSON.stringify({ message: "Successfully created!", todo: newTodo}));
    } catch (err) {
      res.statusCode = 500;
      return res.end(JSON.stringify("Internal server error"));
    }
  }

  if (req.url === "/delete" && req.method === "DELETE") {
    try {
      const body = await parse.json(req);
      const tasks = await read();

      const filtered = tasks.filter((t: any) => t.id !== body.id);
      await write(filtered);

      if (tasks.length > filtered.length) {
        res.statusCode = 200;
        return res.end(JSON.stringify({ message: "Deleted" }));
      } else {
        res.statusCode = 500;
        return res.end(JSON.stringify({ err: "Couldn't delete" }));
      }
    } catch (error) {
      console.error(error);
    }
  }

  if (req.url === "/edit" && req.method === "PUT") {
    try {
      const body = await parse.json(req);
      const tasks = await read();

      const index = tasks.findIndex((t: any) => t.id === body.id);

      if (index === -1) {
        res.statusCode = 404;
        return res.end(JSON.stringify({ err: "Task not found" }));
      }

      tasks[index] = { ...tasks[index], ...body };

      //THE LONGER BUT MORE UNDERSTANDABLE WAY

       // Find the task we want to edit
      // const taskToEdit = tasks[index];

      // // Update its properties one by one
      // taskToEdit.title = body.title;
      // taskToEdit.completed = body.completed;

      // // Put it back into the array
      // tasks[index] = taskToEdit;

      await write(tasks);
      res.statusCode = 200;
        return res.end(JSON.stringify({ message: "Changes saved", todo: tasks[index] }));
    } catch (err) {
      console.error(err);
    }
  }

  res.statusCode = 404;
  return res.end(JSON.stringify({ err: "Server error!" }));
});

server.listen(3004, () => {
  console.log("Server is running on port 3004 to you!");
});
