import type { Request, Response, NextFunction } from "express";
import { login, register } from "../services/auth.service";
import { AuthError } from "../utils/errors";
import { refreshTokens } from "../services/auth.service";
import { logout } from "../services/auth.service";

const REFRESH_COOKIE = {
  httpOnly: true,
  secure: process.env.NODE_ENV === "production",
  sameSite: "strict" as const,
  maxAge: 7 * 24 * 60 * 60 * 1000,
};

export async function registerHandler(req: Request, res: Response, next: NextFunction) {
  try {
    const { name, email, password } = req.body;
    const result = await register(name, email, password);

    res.cookie("refreshToken", result.refreshToken, REFRESH_COOKIE);
    res.status(201).json({ user: result.user, accessToken: result.accessToken });
  } catch (err) {
    next(err);
  }
}

export async function loginHandler(req: Request, res: Response, next: NextFunction) {
  try {
    const { email, password } = req.body;
    const result = await login(email, password);

    res.cookie("refreshToken", result.refreshToken, REFRESH_COOKIE);
    res.status(200).json({ user: result.user, accessToken: result.accessToken });
  } catch (err) {
    next(err);
  }
}


export async function refreshHandler(req: Request, res: Response, next: NextFunction) {
  try {
    const oldToken = req.cookies?.refreshToken;
    if (!oldToken) throw new AuthError("No refresh token");

    const result = await refreshTokens(oldToken);

    res.cookie("refreshToken", result.refreshToken, REFRESH_COOKIE);
    res.status(200).json({ user: result.user, accessToken: result.accessToken });
  } catch (err) {
    next(err);
  }
}


export async function logoutHandler(req: Request, res: Response, next: NextFunction) {
  try {
    await logout(req.cookies?.refreshToken);
    res.clearCookie("refreshToken", REFRESH_COOKIE);
    res.status(204).send();
  } catch (err) {
    next(err);
  }
}
