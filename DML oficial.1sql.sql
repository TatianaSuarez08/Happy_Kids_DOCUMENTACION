-- Inserción de roles
INSERT INTO authority (name)
VALUES
('ROLE_ADMIN'),
('ROLE_USER');

-- Inserción de usuarios
INSERT INTO customer_user
(login, password, email, activated, lang_key)
VALUES
('admin', SHA2('1234', 256), 'admin@gmail.com', 1, 'es'),
('user1', SHA2('1234', 256), 'user1@gmail.com', 1, 'es'),
('user2', SHA2('1234', 256), 'user2@gmail.com', 1, 'es');

INSERT INTO customer_user
(login, password, email, activated, lang_key)
VALUES
('admin', SHA2('1234', 256), 'admin@gmail.com', 1, 'es'),
('user1', SHA2('1234', 256), 'user1@gmail.com', 1, 'es'),
('user2', SHA2('1234', 256), 'user2@gmail.com', 1, 'es');

-- Tipos de documento
INSERT INTO tipo_documento
(sigla, nombre_documento)
VALUES
('CC', 'Cédula de Ciudadanía');

-- Categorías
INSERT INTO categoria
(nombre_categoria, descripcion)
VALUES
('Conjuntos', 'Conjuntos infantiles'),
('Bermudas', 'Bermudas para niños'),
('Sudaderas', 'Sudaderas infantiles');

-- Productos
INSERT INTO producto
(nombre_producto, descripcion, precio, talla, color, id_categoria)
VALUES
('Conjunto Elegante', 'Ropa formal', 80000, 'M', 'Negro', 1),
('Pantaloneta y Camisa', 'Conjunto casual', 70000, 'L', 'Azul', 2),
('Sudadera Deportiva', 'Sudadera cómoda', 90000, 'S', 'Rojo', 3);

-- Clientes
INSERT INTO cliente
(primer_nombre, primer_apellido, numero_documento,
id_customer_user, id_tipo_documento)
VALUES
('Juan', 'Pérez', 123456, 1, 1),
('María', 'López', 222222, 2, 1),
('Carlos', 'Ramírez', 333333, 3, 1);

-- Relación usuario - rol
INSERT INTO user_authority
VALUES
('ROLE_ADMIN', 1),
('ROLE_USER', 2),
('ROLE_USER', 3);

-- Empleados
INSERT INTO empleado
(nombre, apellido, cargo, salario, estado)
VALUES
('Carlos', 'Lopez', 'Vendedor', 1200000, 'Activo'),
('Ana', 'Martinez', 'Cajera', 1100000, 'Activo');

-- Carritos
INSERT INTO carrito
(fecha_creacion, estado, id_cliente)
VALUES
(CURDATE(), 'Activo', 1),
(CURDATE(), 'Activo', 2),
(CURDATE(), 'Activo', 3);

-- Detalle del carrito
INSERT INTO detalle_carrito
(cantidad, precio, subtotal, id_carrito, id_producto)
VALUES
(2, 80000, 160000, 1, 1),
(1, 70000, 70000, 2, 2),
(4, 90000, 360000, 3, 3);

-- Facturas
INSERT INTO factura
(fecha, id_cliente, id_empleado, total)
VALUES
(CURDATE(), 1, 1, 160000),
(CURDATE(), 2, 2, 70000),
(CURDATE(), 3, 2, 360000);

-- Detalle del pedido
INSERT INTO detalle_pedido
(id_factura, id_producto, cantidad, precio_unitario, subtotal)
VALUES
(1, 1, 2, 80000, 160000),
(2, 2, 1, 70000, 70000),
(3, 3, 4, 90000, 360000);

-- Inventario
INSERT INTO inventario
(cantidad_disponible, cantidad_minima, id_producto)
VALUES
(10, 2, 1),
(15, 3, 2),
(8, 2, 3);

-- Proveedores
INSERT INTO proveedor
(nombre, correo, telefono)
VALUES
('Proveedor 1', 'proveedor1@gmail.com', '3001234567');

-- Compras
INSERT INTO compra
(fecha_compra, id_proveedor, total)
VALUES
(CURDATE(), 1, 200000),
(CURDATE(), 1, 300000);

-- Detalle de compras
INSERT INTO detalle_compra
(id_compra, id_producto, cantidad, precio, subtotal)
VALUES
(1, 1, 2, 80000, 160000),
(2, 2, 3, 70000, 210000);

-- Pagos
INSERT INTO pago
(metodo_pago, fecha_pago, total, id_factura)
VALUES
('Tarjeta', CURDATE(), 160000, 1),
('Efectivo', CURDATE(), 70000, 2),
('Transferencia', CURDATE(), 360000, 3);

-- Entregas
INSERT INTO entrega
(fecha_entrega, estado, id_factura)
VALUES
(CURDATE(), 'Entregado', 1),
(CURDATE(), 'Pendiente', 2),
(CURDATE(), 'Entregado', 3);