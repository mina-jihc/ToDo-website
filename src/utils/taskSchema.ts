import { z } from 'zod';

export const createTaskSchema = z.object ({
    title: z.string().min(1, "Title is required"),
    user_id: z.number().int().positive()
})