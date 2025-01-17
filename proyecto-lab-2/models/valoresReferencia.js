'use strict';
const { Model } = require('sequelize');

module.exports = (sequelize, DataTypes) => {
  class ValorReferencia extends Model {
    static associate(models) {
      // Un valor de referencia pertenece a una determinación
      ValorReferencia.belongsTo(models.Determinacion, {
        foreignKey: 'determinacionId',
        as: 'determinacion'
      });
    }
  }

  ValorReferencia.init({
    categoria: {
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
    determinacionId: {
      type: DataTypes.INTEGER,
      allowNull: false,
      references: {
        model: 'Determinacion',
        key: 'id'
      }
    }
  }, {
    sequelize,
    modelName: 'ValorReferencia',
    tableName: 'valoresreferencia',
    timestamps: true
  });

  return ValorReferencia;
};
