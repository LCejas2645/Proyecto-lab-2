'use strict';
const { Model } = require('sequelize');

module.exports = (sequelize, DataTypes) => {
  class Examen extends Model {
    static associate(models) {
      // Un examen tiene muchas determinaciones
      Examen.hasMany(models.Determinacion, {
        foreignKey: 'examenId',
        as: 'determinaciones'
      });

      // Un examen puede tener muchas muestras
      Examen.hasMany(models.Muestra, {
        foreignKey: 'examenId',
        as: 'muestras'
      });
    }
  }

  Examen.init({
    descripcion: {
      type: DataTypes.STRING,
      allowNull: false
    },
    tiempoPromedio: {
      type: DataTypes.INTEGER,
      allowNull: false
    },
    activo: {
      type: DataTypes.BOOLEAN,
      defaultValue: true
    }
  }, {
    sequelize,
    modelName: 'examen',
    tableName: 'examen',
    timestamps: true
  });

  return Examen;
};
