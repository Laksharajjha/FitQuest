const cron = require("node-cron");
const User = require("./models/user.model");
const SensorData = require("./models/sensorData.model");

async function createSensorDataEveryday() {
  const currDate = new Date();
  try {
    const users = await User.find({});
    for (const user of users) {
      const newSensorData = new SensorData({
        email: user.email,
        userId: user._id,
        step: 0,
        distance: 0,
        calories: 0,
        heartRate: 0,
        sleep: 0,
      });

      await newSensorData.save();
    }

    console.log("Sensor data created for all users:", currDate);
  } catch (error) {
    console.error("Error creating sensor data:", error);
  }
}

cron.schedule("0 0 * * *", async () => {
  console.log("Running cron job for creating sensor data");
  await createSensorDataEveryday();
});
