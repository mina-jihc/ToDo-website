import rateLimit from "express-rate-limit";

export const authLimiter = rateLimit({
  windowMs: 60 * 1000,        
  limit: 5,                   
  standardHeaders: "draft-7", 
  legacyHeaders: false,       
  message: { error: "Too many attempts, try again in a minute" },
});
