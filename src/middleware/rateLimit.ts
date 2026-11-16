import rateLimit from "express-rate-limit";

export const authLimiter = rateLimit({
  windowMs: 60 * 1000,        // 1 минут
  limit: 5,                   // 5 сұраныс
  standardHeaders: "draft-7", // RateLimit-* header-лер
  legacyHeaders: false,       // X-RateLimit-* өшіру
  message: { error: "Too many attempts, try again in a minute" },
});
