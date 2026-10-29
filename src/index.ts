import express from "express";
import  router  from './routes/tasks.js';
import { errorHandler } from './middleware/errorHandler.js';
import morgan from 'morgan';
import helmet from 'helmet';
import cors from 'cors';
import rateLimit from 'express-rate-limit';
import 'dotenv/config';

const app = express();
app.use(express.json());
app.use(helmet());
app.use(cors());
app.use(morgan('dev'));
const limiter = rateLimit({
    windowMs: 15 * 60 * 1000,
    max: 100
});
app.use(limiter);
app.use('/tasks', router);
app.get('/health', async (req, res) => {
    const data = {
        uptime: process.uptime(),
        message: 'Ok',
        date: new Date()
    }
    res.status(200).json(data);
})
app.use(errorHandler);
const port = Number(process.env.PORT) || 3000;
const server = app.listen(port);
process.on('SIGTERM', () => {
    console.log("SIGTERM received, shutting down gracefully...");
    server.close(() => {
        console.log("All connections stopped. Server is closing...");
        process.exit(0);
    })
})