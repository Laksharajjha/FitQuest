const SensorDataSchema = new mongoose.Schema(
  {
    user: { type: mongoose.Schema.Types.ObjectId, ref: "User" },
    timestamp: { type: Date, default: Date.now },
    distance: Number,
    calories: Number,
    heartRate: Number,
    bodyStress: Number,
    sleepPatterns: {
      duration: Number,
      deepSleep: Number,
      lightSleep: Number,
      remSleep: Number,
    },
    workoutDetails: {
      type: String,
      duration: Number,
      caloriesBurned: Number,
    },
  },
  { timestamps: true }
);

const SensorData = mongoose.model("SensorData", SensorDataSchema);
module.exports = SensorData;
