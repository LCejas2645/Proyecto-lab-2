'use strict';
const { Model } = require('sequelize');

module.exports = (sequelize, DataTypes) => {
  class Muestra extends Model {
    static associate(models) {
      Muestra.belongsTo(models.examen, {
        foreignKey: 'examenId',
        as: 'examen'
      });
    }
  }

  Muestra.init({
    descripcion: {
      type: DataTypes.STRING,
      allowNull: false
    },
    detalles: {
        type: DataTypes.STRING,
        allowNull: false
      },
    activo: {
      type: DataTypes.BOOLEAN,
      defaultValue: true
    },
    examenId: {
      type: DataTypes.INTEGER,
      allowNull: false,
      references: {
        model: 'Examen',
        key: 'id'
      }
    }
  }, {
    sequelize,
    modelName: 'Muestra',
    tableName: 'muestra',
    timestamps: true
  });

  return Muestra;
};
