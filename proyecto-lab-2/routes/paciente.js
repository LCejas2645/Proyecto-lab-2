var express = require('express');
const pacienteController = require("../controllers/paciente");
var router = express.Router();


/* GET users listing. */
router.get('/',pacienteController.listar);
router.get("/agregar",pacienteController.agregar);
router.post("/agregar",pacienteController.agregar);
router.get("/actualizar/:id",pacienteController.actualizar);
router.post("/actualizar/:id",pacienteController.actualizar);
router.post("/eliminar",pacienteController.eliminar);
  

module.exports = router;

