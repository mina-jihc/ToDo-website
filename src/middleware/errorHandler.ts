import type { Request, Response, NextFunction } from "express";
import { AppError } from "../utils/AppError.js";

export const errorHandler = async (err: any, req: Request, res: Response, next: NextFunction) => {
    if (err instanceof AppError) {
        return res.status(err.statusCode).json({ error: { message: err.message } });
    }
    console.error(err);
    res.status(500).json({ error: {message: `Internal server error` } });
};
