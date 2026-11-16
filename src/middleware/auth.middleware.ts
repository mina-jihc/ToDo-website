import { verifyAccessToken } from "../utils/jwt";
import type { Request, Response, NextFunction } from "express";
import { AuthError } from "../utils/errors";

export function authMiddleware(req: Request, res: Response, next: NextFunction) {
    try {
        const token = req.headers.authorization?.split(' ')[1];
        if (!token) throw new AuthError('No token provided');
        const verified = verifyAccessToken(token);
        req.user = verified;
        next();
    }
    catch (err) {
        if (err instanceof Error && err.name === "TokenExpiredError") {
    return next(new AuthError("Token expired"));;
  }
  return next(new AuthError("Invalid token"));
    }
}