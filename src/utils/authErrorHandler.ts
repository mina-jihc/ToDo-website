import { AuthError } from "./errors";
import { AppError } from "./AppError";
import type { Request, Response, NextFunction } from "express";

export function authErrorHandler(err: unknown, req: Request, res: Response, next: NextFunction) {
    console.error('❌ REAL ERROR:', err);
    if (err instanceof AuthError) {
        return res.status(err.status).json({error: err.message})
    }
    if (err instanceof AppError) {
    return res.status(err.statusCode).json({ error: err.message });
  }
    return res.status(500).json({ error: `Something went wrong`})
}