const { Router } = require("express");
const { getUser } = require("../controllers/user.controller");
const router = Router();

router.get("/get-user", getUser);

module.exports = router;
