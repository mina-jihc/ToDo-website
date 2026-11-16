import type { Request, Response, NextFunction } from "express";
import { AppError } from "../utils/AppError.js";
import { handlePrismaError } from "../utils/prismaError.js";
import { AuthError } from "../utils/errors";

export const errorHandler = async (err: any, req: Request, res: Response, next: NextFunction) => {
    const { status, message } = handlePrismaError(err);
    if (status !== 500) {
        return res.status(status).json({ error: message });
    }
    if (err instanceof AppError) {
        return res.status(err.statusCode).json({ error: err.message });
    }
    if (err instanceof AuthError) {
        return res.status(err.status).json({ error: err.message });
    }
    console.error(err);
    return res.status(500).json({ error: { message: `Internal server error` } });
};