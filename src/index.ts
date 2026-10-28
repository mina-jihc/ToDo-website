import express from "express";
import  router  from './routes/tasks.js';
// import { logger } from './middleware/logger.js';
import { errorHandler } from './middleware/errorHandler.js';
import morgan from 'morgan';
import 'dotenv/config';
const app = express();
app.use(express.json());
// app.use(logger);    // OLD CODE
app.use(morgan('dev'));
app.use('/tasks', router);
app.use(errorHandler);
const port = Number(process.env.PORT) || 3000;
app.listen(port);