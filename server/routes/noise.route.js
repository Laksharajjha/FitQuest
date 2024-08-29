const { Router } = require("express");
const { heart } = require("../controllers/noise.controller.js");
const { verifyToken } = require("../middlewares/auth.middleware.js");

const router = Router();

router.post("/noise", verifyToken, heart);

module.exports = router;
