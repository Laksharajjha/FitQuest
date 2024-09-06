const User = require("../models/user.model");

exports.getUser = async (req, res, next) => {
  const x = req.email;
  console.log(email);
  try {
    const user = await User.findOne({ email }).populate("data");
    if (!user) return next(new Error("user not found"));
    return res.status(200).json({ user });
  } catch (error) {
    next(error);
  }
};

exports.deleteUser = async (req, res, next) => {};
