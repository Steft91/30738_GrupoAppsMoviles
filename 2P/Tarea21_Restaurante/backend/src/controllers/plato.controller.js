const PlatoModel = require('../models/plato.model');

const PlatoController = {
  async obtenerPlatos(req, res) {
    try {
      const platos = await PlatoModel.obtenerTodos();
      res.json(platos);
    } catch (error) {
      res.status(500).json({
        mensaje: 'Error al obtener los platos',
        error: error.message
      });
    }
  },

  async obtenerPlatoPorId(req, res) {
    try {
      const { id } = req.params;
      const plato = await PlatoModel.obtenerPorId(id);

      if (!plato) {
        return res.status(404).json({
          mensaje: 'Plato no encontrado'
        });
      }

      res.json(plato);
    } catch (error) {
      res.status(500).json({
        mensaje: 'Error al obtener el plato',
        error: error.message
      });
    }
  },

  async crearPlato(req, res) {
    try {
      const { nombre, descripcion, precio, imagen_url, imagenUrl, disponible } =
        req.body;

      if (!nombre || precio === undefined) {
        return res.status(400).json({
          mensaje: 'El nombre y el precio son obligatorios'
        });
      }

      if (precio <= 0) {
        return res.status(400).json({
          mensaje: 'El precio debe ser mayor a 0'
        });
      }

      const nuevoPlato = await PlatoModel.crear({
        nombre,
        descripcion,
        precio,
        imagen_url: imagen_url ?? imagenUrl ?? null,
        disponible: disponible ?? true
      });

      res.status(201).json({
        mensaje: 'Plato creado correctamente',
        plato: nuevoPlato
      });
    } catch (error) {
      res.status(500).json({
        mensaje: 'Error al crear el plato',
        error: error.message
      });
    }
  },

  async actualizarPlato(req, res) {
    try {
      const { id } = req.params;
      const { nombre, descripcion, precio, imagen_url, imagenUrl, disponible } =
        req.body;

      if (!nombre || precio === undefined) {
        return res.status(400).json({
          mensaje: 'El nombre y el precio son obligatorios'
        });
      }

      if (precio <= 0) {
        return res.status(400).json({
          mensaje: 'El precio debe ser mayor a 0'
        });
      }

      const platoActualizado = await PlatoModel.actualizar(id, {
        nombre,
        descripcion,
        precio,
        imagen_url: imagen_url ?? imagenUrl ?? null,
        disponible
      });

      if (!platoActualizado) {
        return res.status(404).json({
          mensaje: 'Plato no encontrado'
        });
      }

      res.json({
        mensaje: 'Plato actualizado correctamente',
        plato: platoActualizado
      });
    } catch (error) {
      res.status(500).json({
        mensaje: 'Error al actualizar el plato',
        error: error.message
      });
    }
  },

  async eliminarPlato(req, res) {
    try {
      const { id } = req.params;
      const platoEliminado = await PlatoModel.eliminar(id);

      if (!platoEliminado) {
        return res.status(404).json({
          mensaje: 'Plato no encontrado'
        });
      }

      res.json({
        mensaje: 'Plato eliminado correctamente',
        plato: platoEliminado
      });
    } catch (error) {
      res.status(500).json({
        mensaje: 'Error al eliminar el plato',
        error: error.message
      });
    }
  }
};

module.exports = PlatoController;
