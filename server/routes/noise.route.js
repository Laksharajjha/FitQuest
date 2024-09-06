const { Router } = require("express");
const { heart, getData } = require("../controllers/noise.controller.js");
const { verifyToken } = require("../middlewares/auth.middleware.js");

const router = Router();

router.post("/noise", heart);
router.put("/user-data/:email", getData);

module.exports = router;
