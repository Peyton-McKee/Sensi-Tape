import express from "express";
import userRouter from "./routes/user.routes";

const app = express();

app.get("/", (req, res) => {
   res.send("Welcome to SensiTape API");
});

app.use('/users', userRouter)

app.listen(8080, () => {
   console.log("Server is listening on port 8000");
});