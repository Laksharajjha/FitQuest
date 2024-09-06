const { default: mongoose } = require("mongoose");

const AchievementSchema = new mongoose.Schema(
  {
    user: { type: mongoose.Types.ObjectId, ref: "User" },
    title: String,
    description: String,
  },
  { timestamps: true }
);

const Achievement = mongoose.model("Achievement", AchievementSchema);
module.exports = Achievement;
