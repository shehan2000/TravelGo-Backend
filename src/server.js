import app from "./index.js";
const port = process.env.port || 5000;

app.listen(port, () => console.log(`Server started on port ${port}`));