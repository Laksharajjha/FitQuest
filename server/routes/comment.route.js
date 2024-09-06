const { Router } = require("express");
const Comment = require("../models/comment.model");
const router = Router();

// Fetch top-level comments with pagination
router.get("/comments", async (req, res) => {
  const { page = 1, limit = 10 } = req.query;
  const pageNumber = parseInt(page, 10);
  const pageSize = parseInt(limit, 10);

  try {
    const skip = (pageNumber - 1) * pageSize;
    console.log("1");
    const comments = await Comment.find({ parent_id: null })
      .sort({ created_at: -1 })
      .skip(skip)
      .limit(pageSize);

    console.log("2");
    const totalComments = await Comment.countDocuments({ parent_id: null });
    console.log("3");
    console.log("4");

    res.json({
      comments,
      totalComments,
      pagination: {
        page: pageNumber,
        limit: pageSize,
        totalPages: Math.ceil(totalComments / pageSize),
      },
    });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

// Fetch comments by userId with pagination
router.get("/comments/user/:usrId", async (req, res) => {
  const userId = req.params.usrId;
  const { page = 1, limit = 10 } = req.query;
  const pageNumber = parseInt(page, 10);
  const pageSize = parseInt(limit, 10);

  try {
    const skip = (pageNumber - 1) * pageSize;
    const comments = await Comment.find({ userId })
      .sort({ created_at: -1 })
      .skip(skip)
      .limit(pageSize);

    const totalComments = await Comment.countDocuments({ userId });

    res.status(200).json({
      comments,
      pagination: {
        total: totalComments,
        page: pageNumber,
        limit: pageSize,
        totalPages: Math.ceil(totalComments / pageSize),
      },
    });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// Fetch replies for a specific comment with pagination
router.get("/comments/:id/replies", async (req, res) => {
  const parentId = req.params.id;
  const { page = 1, limit = 10 } = req.query;
  const pageNumber = parseInt(page, 10);
  const pageSize = parseInt(limit, 10);

  try {
    const skip = (pageNumber - 1) * pageSize;
    const replies = await Comment.find({ parent_id: parentId })
      .sort({ created_at: -1 })
      .skip(skip)
      .limit(pageSize);

    const totalReplies = await Comment.countDocuments({ parent_id: parentId });

    res.json({
      replies,
      pagination: {
        total: totalReplies,
        page: pageNumber,
        limit: pageSize,
        totalPages: Math.ceil(totalReplies / pageSize),
      },
    });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

// Post a new comment or reply
router.post("/comments/:usrId", async (req, res) => {
  const userId = req.params.usrId;
  const { parent_id, content } = req.body;

  try {
    const comment = new Comment({ userId, parent_id, content });
    await comment.save();
    res.status(200).json(comment);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

module.exports = router;
