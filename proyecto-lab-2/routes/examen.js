var express = require('express');
const examenController = require("../controllers/examen");
var router = express.Router();


router.get('/',examenController.listar);
router.get("/agregar",examenController.agregar);
router.post('/agregar', examenController.guardarExamen);
router.get('/:id/determinaciones/agregar', examenController.verFormularioDeterminaciones);
router.post('/:id/determinaciones/agregar', examenController.guardarDeterminaciones);
router.get('/:id', examenController.verExamen);
//editar examenes
router.get('/:id/editar', examenController.editarExamen);
router.post('/:id/editar', examenController.actualizarExamen);
//editar determinaciones
router.get('/:id/determinaciones/:determinacionId/editar', examenController.editarDeterminacion);
router.post('/:id/determinaciones/:determinacionId/editar', examenController.actualizarDeterminacion);
//editar valores de referencia

router.get('/:id/determinaciones/:determinacionId/valoresReferencia/:valorId/editar', examenController.editarValorReferencia);
router.post('/:id/determinaciones/:determinacionId/valoresReferencia/:valorId/editar', examenController.actualizarValorReferencia);


  

module.exports = router;

