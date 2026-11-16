import express from "express";
import router from "./routes/tasks.js";
import { errorHandler } from "./middleware/errorHandler.js";
import morgan from "morgan";
import helmet from "helmet";
import cors from "cors";
import rateLimit from "express-rate-limit";
import { prisma } from "./prisma.js";
import "dotenv/config";
import { AppError } from "./utils/AppError.js";
import tagsRouter from "./routes/tags.js";
import authRouter  from "./routes/auth.routes.js";
import { authErrorHandler } from "./utils/authErrorHandler.js";
import { authMiddleware } from "./middleware/auth.middleware.js";
import cookieParser from "cookie-parser";

const app = express();

app.use(helmet());
app.use(cors({ origin: process.env.CLIENT_URL || "http://localhost:5173" }));
app.use(express.json({ limit: "10kb" }));
app.use(morgan("dev"));

const limiter = rateLimit({ windowMs: 15 * 60 * 1000, max: 100 });
app.use(limiter);

app.use("/tasks", router);
app.use("/tags", tagsRouter);
app.use("/auth", authRouter);
app.use(authErrorHandler);
router.get('/tasks', authMiddleware);
app.use(cookieParser());
app.set("trust proxy", 1);
app.use(authErrorHandler);


app.use("/health", async (req, res) => {
  try {
    await prisma.$connect();  // $queryRaw`select 1`  OR
    res.status(200).json({ 
      status: "ok",
      uptime: process.uptime(),
    date: new Date()})
  } catch {
    res.status(500).json({ status: "db unavailable" });
  }
})

app.use((req, res, next) => {
  next(new AppError(`Route ${req.originalUrl} not found`, 404));
});

app.use(errorHandler);

const port = Number(process.env.PORT) || 3000;
const server = app.listen(port, () => console.log(`Server on ${port}`));

const shutdown = async () => {
  console.log("Shutting down gracefully...");
  server.close(async () => {
    await prisma.$disconnect();
    process.exit(0);
  });
};

process.on("SIGTERM", shutdown);
process.on("SIGINT", shutdown);
