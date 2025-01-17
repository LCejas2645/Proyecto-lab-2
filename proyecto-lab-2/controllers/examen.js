const examen = require("../models").examen;
const determinacion = require("../models").Determinacion;
const valorReferencia = require("../models").ValorReferencia;

exports.listar = async function (req, res, next) {
    try {
        const examenes = await examen.findAll();
        if (examenes) {
            const mensaje = false;
            console.log("mensaje: " + mensaje);
            res.render('examen/examenes', {
                mensaje,
                title: 'Exámenes',
                examenes: examenes
            });
        } else {
            res.render('examen/examenes', {
                mostrarMensaje: false,
                title: 'Exámenes',
                examenes: []
            });
        }
    } catch (error) {
        next(error);
        console.log("error 1" + error); // Para manejar errores de manera adecuada
    }
}

exports.verExamen = async function (req, res, next) {
    const examenId = req.params.id;
    
    try {
        console.log(examenId);
        const examenDetalle = await examen.findByPk(examenId, {
            include: [
                {
                    model: determinacion,
                    as: 'determinaciones',
                    include: [
                        {
                            model: valorReferencia,
                            as: 'valoresReferencia'
                        }
                    ]
                }
            ]
        });

        if (examenDetalle) {
            //console.log(examenDetalle)
            res.render('examen/detalle', { examenDetalle });
        } else {
            // res.status(404).render('404', { message: 'Examen no encontrado' });
            console.log("Examen no encontrado 11")
        }
    } catch (error) {
        // res.status(500).render('error2', { message: 'Error al obtener el examen', error });
        console.log("Examen no encontrado2"+error);
    }
}

exports.agregar = async function(req, res, next) {
    try {
        res.render('examen/agregar', {}); // Asegúrate de que esta ruta sea correcta y que la vista exista
    } catch (error) {
        console.log("Error al renderizar la página de agregar: " + error);
        next(error);
    }
}

exports.guardarExamen = async function (req, res, next) {
    const { descripcion, tiempoPromedio, activo } = req.body;

    try {
        const nuevoExamen = await examen.create({
            descripcion,
            tiempoPromedio,
            activo: activo === 'on'
        });

        res.redirect(`/examenes/${nuevoExamen.id}/determinaciones/agregar`);
    } catch (error) {
        console.log("Error al guardar el examen: " + error);
        next(error);
    }
};

exports.verFormularioDeterminaciones = async function (req, res, next) {
    const examenId = req.params.id;

    try {
        const examenN = await examen.findByPk(examenId);

        if (examenN) {
            res.render('examen/agregarDeterminacion', { examenN });
        } else {
            console.log("Examen no encontrado");
        }
    } catch (error) {
        console.log("Formulario determiaciones Error: " + error);
        next(error);
    }
};

exports.guardarDeterminaciones = async function (req, res, next) {
    const examenId = req.params.id;
    const { descripcion, unidadMedida, valorMin, valorMax, activo, valoresReferencia } = req.body;

    try {
        const nuevaDeterminacion = await determinacion.create({
            descripcion,
            unidadMedida,
            valorMin,
            valorMax,
            activo: activo === 'on',
            examenId
        });

        if (valoresReferencia && Array.isArray(valoresReferencia)) {
            for (const val of valoresReferencia) {
                await valorReferencia.create({
                    categoria: val.categoria,
                    valorMin: val.valorMin,
                    valorMax: val.valorMax,
                    activo: true,
                    determinacionId: nuevaDeterminacion.id
                });
            }
        }

        res.redirect(`/examenes/${examenId}/determinaciones/agregar`);
    } catch (error) {
        console.log("Error al guardar la determinación: " + error);
        next(error);
    }
};

exports.editarExamen = async function(req,res,next){
    const examenId = req.params.id;
    try {
        const examenDetalle = await examen.findByPk(examenId);
        if (examenDetalle) {
            res.render('examen/editar', { examenDetalle });
        } else {
            console.log("Examen no encontrado");
        }
    } catch (error) {
        console.log("Error al obtener el examen: " + error);
    }
}

exports.actualizarExamen = async function(req, res, next) {
    const examenId = req.params.id;
    const { descripcion, tiempoPromedio, activo } = req.body;
    try {
        await examen.update({ descripcion, tiempoPromedio, activo: activo === 'on' }, { where: { id: examenId } });
        res.redirect(`/examenes/${examenId}`);
    } catch (error) {
        console.log("Error al actualizar el examen: " + error);
        res.redirect(`/examenes/${examenId}/editar`);
    }
}


exports.editarDeterminacion = async function(req, res, next) {
    const { id, determinacionId } = req.params;
    try {
        const determinacionDetalle = await determinacion.findByPk(determinacionId);
        if (determinacionDetalle) {
            res.render('determinacion/editar', { examenId: id, determinacion: determinacionDetalle });
        } else {
            console.log("Determinación no encontrada");
            res.redirect(`/examenes/${id}`);
        }
    } catch (error) {
        console.log("Error al obtener la determinación: " + error);
        res.redirect(`/examenes/${id}`);
    }
}

exports.actualizarDeterminacion = async function(req, res, next) {
    const { id, determinacionId } = req.params;
    const { descripcion, unidadMedida, valorMin, valorMax, activo } = req.body;
    try {
        await determinacion.update(
            { descripcion, unidadMedida, valorMin, valorMax, activo: activo === 'on' },
            { where: { id: determinacionId } }
        );
        res.redirect(`/examenes/${id}`);
    } catch (error) {
        console.log("Error al actualizar la determinación: " + error);
        res.redirect(`/examenes/${id}/determinaciones/${determinacionId}/editar`);
    }
}


exports.editarValorReferencia = async function(req, res, next) {
    const { id, determinacionId, valorId } = req.params;
    try {
        const valorDetalle = await valorReferencia.findByPk(valorId);
        if (valorDetalle) {
            res.render('valorReferencia/editar', { examenId: id, determinacionId, valorReferencia: valorDetalle });
        } else {
            console.log("Valor de referencia no encontrado");
            res.redirect(`/examenes/${id}/determinaciones/${determinacionId}`);
        }
    } catch (error) {
        console.log("Error al obtener el valor de referencia: " + error);
        res.redirect(`/examenes/${id}/determinaciones/${determinacionId}`);
    }
}

exports.actualizarValorReferencia = async function(req, res, next) {
    const { id, determinacionId, valorId } = req.params;
    const { categoria, valorMin, valorMax } = req.body;
    try {
        await valorReferencia.update(
            { categoria, valorMin, valorMax },
            { where: { id: valorId } }
        );
        res.redirect(`/examenes/${id}`);
    } catch (error) {
        console.log("Error al actualizar el valor de referencia: " + error);
        res.redirect(`/examenes/${id}/determinaciones/${determinacionId}/valoresReferencia/${valorId}/editar`);
    }
}
