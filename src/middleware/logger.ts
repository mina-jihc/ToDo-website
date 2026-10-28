import type { Request, Response, NextFunction } from "express";

export const logger = async (req: Request, res: Response, next: NextFunction) => {
    console.log(`${req.method} ${req.url} - ${new Date().toISOString()}`);
    next();
}