const User = require("../models/user.model");

exports.getUser = async (req, res, next) => {
  const email = req.query;
  try {
    const user = await User.findOne({ email });
    if (!user) return next(new Error("user not found"));
    return res.status(200).json({ user });
  } catch (error) {
    next(error);
  }
};
