const { default: mongoose } = require("mongoose");

const SensorDataSchema = new mongoose.Schema(
  {
    email: String,
    step: Number,
    distance: Number,
    calories: Number,
    heartRate: Number,
    sleep: Number,
  },
  { timestamps: true }
);

const SensorData = mongoose.model("SensorData", SensorDataSchema);
module.exports = SensorData;
