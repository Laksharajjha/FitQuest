const AchievementSchema = new mongoose.Schema(
  {
    user: { type: mongoose.Schema.Types.ObjectId, ref: "User" },
    title: String,
    description: String,
    dateEarned: { type: Date, default: Date.now },
  },
  { timestamps: true }
);

const Achievement = mongoose.model("Achievement", AchievementSchema);
module.exports = Achievement;
