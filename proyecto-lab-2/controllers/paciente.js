const paciente = require("../models").paciente;


exports.listar = async function (req, res, next) {
    try {
        const pacientes = await paciente.findAll();
        if (pacientes) {
            const mensaje = false;
            console.log("mensaje: " + mensaje);
            res.render('paciente/pacientes', {
                mensaje,
                title: 'Pacientes',
                pacientes: pacientes
            });
        } else {
            res.render('paciente/pacientes', {
                mostrarMensaje: false,
                title: 'Pacientes',
                pacientes: []
            });
        }
    } catch (error) {
        next(error);
        console.log("error" + error); // Para manejar errores de manera adecuada
    }
}

exports.agregar = async function (req, res, next) {
    try {
        if (req.method === "GET") {
            // Renderizar la vista para agregar un paciente
            return res.render('paciente/agregar', { isEdit: false, patient: null });
        }

        if (req.method === "POST") {
            try {
                const { nombreCompleto, dni, sexo, mail, edad, patologiaPre } = req.body;
                const embarazo = req.body.embarazo !== undefined;

                const pacienteN = {
                    nombreCompleto,
                    dni,
                    sexo,
                    mail,
                    edad,
                    patologiaPre,
                    embarazo
                };

                const nuevoPaciente = await paciente.create(pacienteN);
                console.log(nuevoPaciente.toJSON());

                const pacientes = await paciente.findAll(); // Asegúrate de usar el método correcto para obtener todos los pacientes

                // Renderizar la vista del nuevo paciente con la lista de pacientes
                return res.render("paciente/pacientes", { mensaje: "paciente agregado con exito", pacientes });
            } catch (err) {
                console.error("Error al crear el paciente:", err);
                // Renderizar la vista de error
                return res.redirect('/pacientes');
            }
        }
    } catch (error) {
        // Manejo de errores generales
        console.error("Error al manejar la solicitud de agregar paciente:", error);
        next(error); // Pasar el error al middleware de manejo de errores
    }
};

exports.actualizar = async function (req, res, next) {
    try {
        if (req.method === "GET") {
            const pacienteId = req.params.id;
            try {
                const pacienteA = await paciente.findByPk(pacienteId);
                if (pacienteA) {
                    res.render('paciente/agregar', { isEdit: true, pacienteA });
                } else {
                    res.status(404).send('Paciente no encontrado');
                }
            } catch (error) {
                res.status(500).send('Error al obtener el paciente' + error);
            }
        }

        if (req.method === "POST") {
            const patientId = req.params.id;
            try {
                const [updated] = await paciente.update(req.body, {
                    where: { id: patientId }
                });

                if (updated) {
                    const pacientes = await paciente.findAll(); 
                    
                    return res.render("paciente/pacientes", { mensaje: "paciente actualizado con exito", pacientes });
                } else {
                    res.status(404).send('Paciente no encontrado');
                }
            } catch (error) {
                res.status(500).send('Error al actualizar el paciente');
            }
        }
    } catch (error) {
        // Manejo de errores generales
        console.error("Error al manejar la solicitud de actualizar paciente:", error);
        next(error); // Pasar el error al middleware de manejo de errores
    }
};

exports.eliminar = async function (req, res, nex) {
    const patientId = req.body.id;
    try {
        await paciente.destroy({
            where: { id: patientId }
        });
        const mensaje = "paciente eliminado con exito"
        const pacientes = await paciente.findAll();
        res.render('paciente/pacientes', { mensaje, pacientes });
    } catch (error) {
        res.status(500).send('Error al eliminar el paciente');
    }
};


