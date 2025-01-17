'use strict';
const {
  Model
} = require('sequelize');

module.exports = (sequelize, DataTypes) => {
  class Determinacion extends Model {
    static associate(models) {
      // Una determinación pertenece a un examen
      Determinacion.belongsTo(models.examen, {
        foreignKey: 'examenId',
        as: 'examen'
      });
      
      // Una determinación tiene muchas valores de referencia
      Determinacion.hasMany(models.ValorReferencia, {
        foreignKey: 'determinacionId',
        as: 'valoresReferencia'
      });
    }
  }

  Determinacion.init({
    descripcion: {
      type: DataTypes.STRING,
      allowNull: false
    },
    unidadMedida: {
      type: DataTypes.STRING,
      allowNull: false
    },
    valorMin: {
      type: DataTypes.DOUBLE,
      allowNull: false
    },
    valorMax: {
      type: DataTypes.DOUBLE,
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
    modelName: 'Determinacion',
    tableName: 'determinacion',
    timestamps: true 
  });

  return Determinacion;
};
