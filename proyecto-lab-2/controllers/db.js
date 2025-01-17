import { Sequelize } from "sequelize";
export const  sequelize = new Sequelize('proyectolab2', 'root', '', {
    host: 'localhost',
    dialect: 'mysql',
    logging: false,
  });

  