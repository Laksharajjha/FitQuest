const mongoose = require("mongoose");

const UserSchema = new mongoose.Schema(
  {
    email: { type: String, unique: true },
    password: String,
    achievements: [
      { type: mongoose.Schema.Types.ObjectId, ref: "Achievement" },
    ],
    data: [
      {
        type: mongoose.Types.ObjectId,
        ref: "SensorData",
      },
    ],
    ecommerceLink: {
      type: String,
      optional: true,
      default: "",
    },
  },
  { timestamps: true }
);

const User = mongoose.model("User", UserSchema);
module.exports = User;
