const { Router } = require("express");
const Comment = require("../models/comment.model");
const { TokenParser, verifyToken } = require("../middlewares/auth.middleware");
const router = Router();

router.get("/comments", verifyToken, TokenParser, async (req, res) => {
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

router.get("/comments/user", verifyToken, TokenParser, async (req, res) => {
  const userId = req.userId;
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

router.get(
  "/comments/:id/replies",
  verifyToken,
  TokenParser,
  async (req, res) => {
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

      const totalReplies = await Comment.countDocuments({
        parent_id: parentId,
      });

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
  }
);

router.post("/comments", verifyToken, TokenParser, async (req, res) => {
  const userId = req.userId;
  const { parent_id, content } = req.body;

  try {
    const comment = new Comment({ userId, parent_id, content });
    await comment.save();
    res.status(200).json(comment);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

router.delete(
  "/delete-comment/:commentId",
  verifyToken,
  TokenParser,
  async (req, res) => {
    const { commentId } = req.params;
    const BATCH_SIZE = 100;

    try {
      let commentIdsToDelete = [commentId];
      let queue = [commentId];

      const findDescendants = async (parentId) => {
        const descendants = await Comment.find({ parent_id: parentId }, "_id");
        return descendants.map((descendant) => descendant._id.toString());
      };

      while (queue.length > 0) {
        const currentBatch = queue.splice(0, BATCH_SIZE);
        let newDescendants = [];

        for (const currentId of currentBatch) {
          const descendants = await findDescendants(currentId);
          newDescendants.push(...descendants);
        }

        queue.push(...newDescendants);
        commentIdsToDelete.push(...newDescendants);

        if (commentIdsToDelete.length >= BATCH_SIZE) {
          await Comment.deleteMany({
            _id: { $in: commentIdsToDelete.splice(0, BATCH_SIZE) },
          });
        }
      }

      if (commentIdsToDelete.length > 0) {
        await Comment.deleteMany({ _id: { $in: commentIdsToDelete } });
      }

      res.status(200).json({ message: "Comment thread deleted successfully" });
    } catch (error) {
      res.status(500).json({ error: error.message });
    }
  }
);

module.exports = router;
