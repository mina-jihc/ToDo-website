import express from "express";
import { authMiddleware } from "../middleware/auth.middleware.js";
import { adminMiddleware } from "../middleware/admin.middleware.js";
import { getUsers } from "../controllers/users.js";
import { asyncHandler } from "../utils/asyncHandler.js";

const router = express.Router();

router.get("/", authMiddleware, adminMiddleware, asyncHandler(getUsers));

export default router;