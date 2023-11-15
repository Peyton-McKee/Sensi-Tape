import express from 'express';
import userRouter from './routes/user.routes';
import exerciseRouter from './routes/recommendation.routes';
import cors from 'cors';
import recommendationRouter from './routes/recommendation.routes';
import activityRouter from './routes/activity.routes';

const app = express();

app.get('/', (req, res) => {
  res.send('Welcome to SensiTape API');
});

app.use(express.json());
app.use(cors());

app.use('/users', userRouter);
app.use('/recommendations', recommendationRouter);
app.use('/activities', activityRouter);

// Error handling middleware
app.use((err, _req, res, _next) => {
  const status = err.status || 500;
  const message = err.message || 'Internal Server Error';

  // Send the error response as a JSON object
  res.status(status).json({ status, message });
});

const port = process.env.PORT || 8080;
app.listen(port, () => {
  console.log(`Server is listening on port ${port}`);
});
