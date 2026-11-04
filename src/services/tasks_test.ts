import { createTaskWithTag } from "./tasks.js";
import type { ToDo } from "../types.js";

const run = async () => {
  const task = await createTaskWithTag("Test task", 4, 1);
  console.log("Created:", task);

  try {
    await createTaskWithTag("Broken task", 4, 999);
    console.log("Should not reach here!");
  } catch (e) {
    console.log("Error caught (correct!):", e instanceof Error ? e.message : e);
  }
};

run();
