DROP TABLE IF EXISTS pedidos;
DROP TABLE IF EXISTS platos;

CREATE TABLE platos (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT,
    precio NUMERIC(10, 2) NOT NULL CHECK (precio > 0),
    imagen_url TEXT,
    disponible BOOLEAN NOT NULL DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE pedidos (
    id SERIAL PRIMARY KEY,
    cliente VARCHAR(100) NOT NULL,
    fecha TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    cantidad INTEGER NOT NULL CHECK (cantidad > 0),
    total NUMERIC(10, 2) NOT NULL CHECK (total >= 0),
    plato_id INTEGER NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_plato
        FOREIGN KEY (plato_id)
        REFERENCES platos(id)
        ON DELETE RESTRICT
);

INSERT INTO platos (nombre, descripcion, precio, imagen_url, disponible)
VALUES
('Hamburguesa clásica', 'Hamburguesa con carne, queso, lechuga y tomate', 3.50, 'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=900', TRUE),
('Pizza personal', 'Pizza pequeña con queso y pepperoni', 4.25, 'https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?w=900', TRUE),
('Ensalada César', 'Ensalada con pollo, lechuga, crutones y aderezo César', 3.00, 'https://images.unsplash.com/photo-1546793665-c74683f339c1?w=900', TRUE),
('Jugo natural', 'Jugo de fruta natural del día', 1.50, 'https://images.unsplash.com/photo-1622597467836-f3285f2131b8?w=900', TRUE),
('Lasagna', 'Porción de lasagna de carne con queso', 4.75, 'https://images.unsplash.com/photo-1574894709920-11b28e7367e3?w=900', FALSE);
