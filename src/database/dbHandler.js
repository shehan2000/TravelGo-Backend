import pg from 'pg';
import dotenv from 'dotenv';
dotenv.config();


class DbHandler {

    static pool = null;

    static getPool() {
      if (this.pool === null) {
        this.pool = new pg.Pool({
          host: process.env.POSTGRESQL_HOST,
          user: process.env.POSTGRESQL_USER,
          database: process.env.POSTGRESQL_DATABASE,
          password: process.env.POSTGRESQL_PASSWORD,
          port: process.env.POSTGRESQL_PORT,
          max: 10,
        });
      }
      return this.pool;
    }
  
    static executeSingleQuery = async (query, args) => {
      const pool = this.getPool();
      const result = await pool.query(query, args);
      console.log("DB QUERY: ", query, args);
      return result.rows;
    };

};
export default DbHandler;