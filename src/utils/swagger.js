import swaggerJsDoc from "swagger-jsdoc";

// Extended: https://swagger.io/specification/#infoObject
const swaggerOptions = {
    swaggerDefinition: {
      info: {
        version: "1.0.0",
        title: "Travel Go API",
        description: "Train Booking System API Information",
        contact: {
          name: "Movin Silva"
        },
        servers: ["http://localhost:5000"]
      }
    },
    // ['.routes/*.js']
    apis: [
      "./src/index.js",
      "./src/controllers/userController.js"
    ]
  };
  
  const swaggerDocs = swaggerJsDoc(swaggerOptions);

  export default swaggerDocs;