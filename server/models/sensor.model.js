const SensorDataSchema = new mongoose.Schema(
  {
    user: { type: mongoose.Schema.Types.ObjectId, ref: "User" },
    distance: Number,
    calories: Number,
    heartRate: Number,
    bodyStress: Number,
  },
  { timestamps: true }
);

const SensorData = mongoose.model("SensorData", SensorDataSchema);
module.exports = SensorData;
