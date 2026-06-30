-- Mostrar todos los usuarios
SELECT * FROM customer_user;

-- Mostrar todos los clientes
SELECT * FROM cliente;

-- Mostrar todos los productos
SELECT * FROM producto;

-- Mostrar solo el nombre y precio de los productos
SELECT nombre_producto, precio
FROM producto;

-- Mostrar los productos ordenados por precio de mayor a menor
SELECT * FROM producto
ORDER BY precio DESC;

-- Mostrar las categorías
SELECT * FROM categoria;

-- ostrar los empleados activos
SELECT * FROM empleado
WHERE estado = 'Activo';

-- Mostrar las facturas registradas
SELECT * FROM factura;

-- Mostrar los pagos realizados con tarjeta
SELECT * FROM pago
WHERE metodo_pago = 'Tarjeta';

-- Mostrar las entregas pendientes
SELECT * FROM entrega
WHERE estado = 'Pendiente';

-- Mostrar el inventario disponible
SELECT * FROM inventario;

-- Mostrar el nombre del producto y su categoría
SELECT p.nombre_producto, c.nombre_categoria
FROM producto p
INNER JOIN categoria c
ON p.id_categoria = c.id;

-- Mostrar el nombre del cliente y su correo electrónico
SELECT c.primer_nombre, c.primer_apellido, u.email
FROM cliente c
INNER JOIN customer_user u
ON c.id_customer_user = u.id;

-- Mostrar las facturas con el nombre del cliente
SELECT f.id_factura, f.fecha, f.total,
       c.primer_nombre, c.primer_apellido
FROM factura f
INNER JOIN cliente c
ON f.id_cliente = c.id;

-- Mostrar el detalle de cada factura con el producto comprado
SELECT dp.id_factura,
       p.nombre_producto,
       dp.cantidad,
       dp.precio_unitario,
       dp.subtotal
FROM detalle_pedido dp
INNER JOIN producto p
ON dp.id_producto = p.id;

-- Mostrar los productos con stock menor o igual al mínimo
SELECT *
FROM inventario
WHERE cantidad_disponible <= cantidad_minima;

-- Contar cuántos productos hay registrados
SELECT COUNT(*) AS total_productos
FROM producto;

-- Calcular el precio promedio de los productos
SELECT AVG(precio) AS promedio_precio
FROM producto;

--  Mostrar el producto más costoso
SELECT *
FROM producto
ORDER BY precio DESC
LIMIT 1;

-- Mostrar el total vendido en todas las facturas
SELECT SUM(total) AS total_ventas
FROM factura;