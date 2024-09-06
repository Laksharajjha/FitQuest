const { Router } = require("express");
const { getUser, deleteUser } = require("../controllers/user.controller");
const {
  verifyToken,
  TokenParser,
} = require("../middlewares/auth.middleware.js");
const router = Router();

router.get("/get-user/:email", verifyToken, TokenParser, getUser);
router.delete("/delete-account", verifyToken, TokenParser, deleteUser);

module.exports = router;
