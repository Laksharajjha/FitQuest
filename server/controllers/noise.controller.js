const SensorData = require("../models/sensor.model");
exports.getData = async (req, res, next) => {
  const email = req.email;
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
exports.getUserDataToday = async (req, res, next) => {
  const id = req.userId;
  const start = new Date();
  start.setHours(0, 0, 0, 0);

  const end = new Date();
  end.setHours(23, 59, 59, 999);
  try {
    const data = await SensorData.find({
      userId: id,
      createdAt: { $gte: start, $lt: end },
    });
    res.status(200).json({ data });
  } catch (error) {
    next(error);
  }
};
