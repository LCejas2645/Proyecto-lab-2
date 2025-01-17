'use strict';
const {
  Model
} = require('sequelize');
module.exports = (sequelize, DataTypes) => {
  class paciente extends Model {
    static associate(models) {
      //paciente.belongsTo(models.orden, {
        //foreignKey: "id_Paciente"
      //})
    }
  }
  paciente.init({

    nombreCompleto: DataTypes.STRING,
    edad: DataTypes.INTEGER,
    mail: DataTypes.STRING,
    sexo: DataTypes.ENUM('Masculino', 'Femenino', 'Otro'),
    embarazo: DataTypes.BOOLEAN,
    patologiaPre: DataTypes.STRING,
    dni: DataTypes.INTEGER
  }, {
    sequelize,
    modelName: 'paciente',
    tableName: 'paciente',
    timestamps: false
  });
  return paciente;
}
