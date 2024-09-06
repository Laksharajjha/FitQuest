const jwt = require("jsonwebtoken");
const { JWT_SECRET } = process.env;

exports.verifyToken = (req, res, next) => {
  const { authorization } = req.headers;

  if (!authorization || !authorization.startsWith("Bearer ")) {
    return res.status(401).json({ message: "Authentication required" });
  }

  const token = authorization.split(" ")[1];

  try {
    const decoded = jwt.verify(token, JWT_SECRET);
    req.userId = decoded.id;
    req.email = decoded.email;
    next();
  } catch (error) {
    return res.status(401).json({ message: "Invalid token" });
  }
};

// Middleware for logging or parsing
exports.TokenParser = (req, res, next) => {
  console.log("Inside Token Parser");
  // Example: You could log or manipulate the token if needed
  if (req.headers.authorization) {
    console.log("Token is present");
  }
  console.log("Outside Token Parser");
  next();
};
