const { Router } = require("express");
const {
  getUserDataToday,
  getData,
} = require("../controllers/noise.controller.js");
const {
  verifyToken,
  TokenParser,
} = require("../middlewares/auth.middleware.js");

const router = Router();

router.put("/user-data/", verifyToken, TokenParser, getData);
router.get("/user-data/today", verifyToken, TokenParser, getUserDataToday);

module.exports = router;
