const jwt = require("jsonwebtoken");
const bcrypt = require("bcryptjs");
const User = require("../models/user.model");
const SensorData = require("../models/sensor.model");
const { JWT_SECRET, JWT_EXPIRATION } = process.env;

exports.auth = async (req, res, next) => {
  const { email, password } = req.body;
  const { type } = req.query;

  try {
    if (type === "login") {
      const user = await User.findOne({ email });

      if (!user) {
        return res.status(404).json({ message: "User not found" });
      }

      const isMatch = bcrypt.compareSync(password, user.password);
      if (!isMatch) {
        return res.status(400).json({ message: "Invalid credentials" });
      }

      const token = jwt.sign({ id: user._id, email: user.email }, JWT_SECRET, {
        expiresIn: JWT_EXPIRATION,
      });
      return res.status(200).json({ message: "Login successful", token });
    } else if (type === "register") {
      const hashedPassword = await bcrypt.hash(password, 10);

      const newUser = new User({
        email,
        password: hashedPassword,
      });
      const data = new SensorData({
        calories: 0,
        distance: 0,
        email: req.email,
        heartRate: 0,
        sleep: 0,
        step: 0,
        userId: req.userId,
      });
      await data.save();
      await newUser.save();

      const token = jwt.sign(
        { id: newUser._id, email: newUser.email },
        JWT_SECRET,
        { expiresIn: JWT_EXPIRATION }
      );
      return res
        .status(200)
        .json({ message: "Registration successful", token });
    } else {
      return res.status(400).json({ message: "Invalid type specified" });
    }
  } catch (error) {
    next(error);
  }
};

exports.logout = (req, res) => {
  return res.status(200).json({ message: "Logout successful" });
};
