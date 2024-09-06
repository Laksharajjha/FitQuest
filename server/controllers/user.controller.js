const User = require("../models/user.model");

exports.getUser = async (req, res, next) => {
  console.log("x");
  const x = req.params.email;
  console.log(x);
  try {
    const user = await User.findOne({ email: x }).populate("data");
    if (!user) return next(new Error("user not found"));
    return res.status(200).json({ user });
  } catch (error) {
    next(error);
  }
};
