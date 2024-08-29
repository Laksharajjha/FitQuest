const { Router } = require("express");
const { auth } = require("../controllers/auth.controller.js");

const router = Router();

router.post("/auth", auth);

module.exports = router;
