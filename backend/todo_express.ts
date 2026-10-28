// import express from "express";
// import fs from "fs/promises";

// const app = express();
// app.use(express.json());

// const port = 3000;

// interface ToDo {
//   id: number,
//   title: string,
//   completed: boolean
// }

// const readDB = async (): Promise<ToDo[]> => {
//   try {
//     const data = await fs.readFile("./data.json", "utf-8");
//     return await JSON.parse(data);
//   } catch { return []}
// }
// const writeDB = async (data: ToDo[]) => {
//   await fs.writeFile("./data.json", JSON.stringify(data, null, 2))
// }
// app.get("/", (req, res) => {
//   res.json({ message: "Welcome to the webpage!" });
// });

// app.get("/tasks", async (req, res) => {
//   res.json(await readDB())
// })

// app.put("/tasks/:id", async (req, res) => {  // EDIT
//   const id = Number(req.params.id);
//   const body = req.body;
//   const tasks = await readDB();

//   const index = tasks.findIndex((task) => id === task.id);
//   if (index === -1) {
//     res.status(404).json({error: "Task not found"});
//     return;
//   }

//   tasks[index] = {...tasks[index], ...body};

//   await writeDB(tasks);
//   res.status(200).json(tasks[index]);
// })

// app.delete("/tasks/:id", async (req, res) => {   // DELETE
//   const id = Number(req.params.id);
//   // const body = req.body;
//   const tasks = await readDB();

//   const filtered = tasks.filter((task) => task.id !== id);

//   if (tasks.length > filtered.length) {
//     await writeDB(filtered);
//     res.status(200).json(filtered);
//   } else {
//     res.status(404).json({error: "Task not found"});
//   }
// })

// app.post("/tasks", async (req, res) => {   // POST
//   const body = req.body;
//   const tasks = await readDB();
//   const newTodo: ToDo = { id: Date.now(), title: body.title, completed: false }
//   tasks.push(newTodo);
//   await writeDB(tasks);
//   res.status(201).json(newTodo);
// })

// app.listen(port, () => console.log(`Server on port ${port}`));
