const express = require("express");
const app = express();
const cors = require("cors");
const { default: mongoose } = require("mongoose");
const cookieParser = require("cookie-parser");
const morgan = require("morgan");
require("dotenv").config();

const authRouter = require("./routes/auth.route.js");
const noiseRouter = require("./routes/noise.route.js");
const userRouter = require("./routes/user.route.js");
const commentRouter = require("./routes/comment.route.js");

// Mongo DB Connections
mongoose
  .connect(process.env.MONGO_DB_URL)
  .then((response) => {
    console.log("MongoDB Connection Succeeded.");
  })
  .catch((error) => {
    console.log("Error in DB connection: " + error);
  });

app.use(cors());
app.use(express.json());
app.use(cookieParser());
app.use(morgan("dev"));

app.use("/v1/api/auth", authRouter);
app.use("v1/api/user", userRouter);
app.use("/v1/api/comments", commentRouter);
app.use("/v1/api/health", noiseRouter);

const PORT = process.env.PORT || 5000;
app.listen(PORT, () => {
  console.log("App running in port: " + PORT);
});

app.use((err, req, res, next) => {
  console.error(err.stack);

  const statusCode = err.statusCode || 500;
  const message = err.message || "Internal Server Error";

  res.status(statusCode).json({
    success: false,
    message: message,
    ...(process.env.NODE_ENV === "development" && { stack: err.stack }),
  });
});
