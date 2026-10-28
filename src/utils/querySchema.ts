import { z } from "zod";

export const querySchema = z.object({
  status: z.enum(["completed", "active"]).optional(),
  page: z.string().transform(Number).optional(),
  limit: z.string().transform(Number).optional(),
  sort: z.enum(["title", "id", "completed"]).optional(),
});
