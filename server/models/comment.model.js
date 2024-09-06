const mongoose = require("mongoose");

const commentSchema = new mongoose.Schema(
  {
    userId: {
      type: mongoose.Types.ObjectId,
      ref: "User",
    },
    email: {
      type: String,
    },
    parent_id: {
      type: mongoose.Schema.Types.ObjectId,
      ref: "Comment",
      default: null,
    },
    content: { type: String, required: true },
  },
  { timestamps: true }
);

const Comments = mongoose.model("Comment", commentSchema);
module.exports = Comments;
