const SensorData = require("../models/sensor.model");

exports.heart = async (req, res, next) => {
  const { email } = req.query;
  try {
    const ste = Math.floor(Math.random() * 1000);
    const data = new SensorData({
      step: ste,
      distance: (ste * 0.762) / 1000,
      calories: Math.round(ste * 0.04 * 100) / 100,
      email: email,
      sleep: (Math.random() * (9 - 4) + 4).toFixed(2),
      heartRate: Math.floor(Math.random() * (120 - 80 + 1)) + 80,
    });
    await data.save();
    return res.status(200).json({ data });
  } catch (error) {
    console.log(error);
    next(error);
  }
};
exports.steps = async (req, res, next) => {};
exports.oxygen = async (req, res, next) => {};
exports.getData = async (req, res, next) => {
  const { email } = req.params;
  try {
    const data = await SensorData.findOneAndUpdate(
      { email },
      {
        $inc: {
          step: 5,
          distance: 0.00381,
          calories: 0.2,
          sleep: 0,
        },
      },
      {
        new: true,
      }
    );
    console.log(data);
    if (!data) return res.status(404).json({ message: "data not found" });

    return res.status(200).json({ data });
  } catch (error) {
    next(error);
  }
};
