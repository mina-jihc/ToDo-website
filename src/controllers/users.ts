import type { Request, Response } from "express";
import { prisma } from "../prisma.js";

export async function getUsers(req: Request, res: Response) {
  const users = await prisma.app_users.findMany({
    select: {
      id: true,
      name: true,
      email: true,
      role: true,
    },
  });

  res.status(200).json(users);
}