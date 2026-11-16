import { Router } from "express";
import {
  registerHandler,
  loginHandler,
  refreshHandler,
  logoutHandler,
} from "../controllers/auth.controller";
import { authLimiter } from "../middleware/rateLimit";

const authRouter = Router();

authRouter.post("/register", authLimiter, registerHandler);
authRouter.post("/login", authLimiter, loginHandler);
authRouter.post("/refresh", authLimiter, refreshHandler);
authRouter.post("/logout", logoutHandler);

export default authRouter;
