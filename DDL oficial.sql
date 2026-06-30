CREATE DATABASE happykids;
USE happykids;

-- Tabla de roles
CREATE TABLE authority (
    name VARCHAR(50) PRIMARY KEY
);

-- Tabla de usuarios
CREATE TABLE customer_user (
    id INT AUTO_INCREMENT PRIMARY KEY,
    login VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    activated BOOLEAN DEFAULT TRUE,
    lang_key VARCHAR(10) DEFAULT 'es'
);

-- Tipos de documento
CREATE TABLE tipo_documento (
    id INT AUTO_INCREMENT PRIMARY KEY,
    sigla VARCHAR(10) NOT NULL UNIQUE,
    nombre_documento VARCHAR(100) NOT NULL,
    estado ENUM('Activo', 'Inactivo') DEFAULT 'Activo'
);

-- Categorías
CREATE TABLE categoria (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre_categoria VARCHAR(100) NOT NULL UNIQUE,
    descripcion VARCHAR(100)
);

-- Productos
CREATE TABLE producto (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre_producto VARCHAR(100) NOT NULL UNIQUE,
    descripcion VARCHAR(200),
    precio DECIMAL(10,2) NOT NULL CHECK (precio > 0),
    talla VARCHAR(10) NOT NULL,
    color VARCHAR(30) NOT NULL,
    id_categoria INT NOT NULL,
    FOREIGN KEY (id_categoria)
        REFERENCES categoria(id)
);

-- Clientes
CREATE TABLE cliente (
    id INT AUTO_INCREMENT PRIMARY KEY,
    primer_nombre VARCHAR(50) NOT NULL,
    primer_apellido VARCHAR(50) NOT NULL,
    numero_documento BIGINT NOT NULL UNIQUE,
    fecha_registro DATE DEFAULT (CURDATE()),
    id_customer_user INT NOT NULL,
    id_tipo_documento INT NOT NULL,
    FOREIGN KEY (id_customer_user)
        REFERENCES customer_user(id),
    FOREIGN KEY (id_tipo_documento)
        REFERENCES tipo_documento(id)

);

-- Relación usuario - rol
CREATE TABLE user_authority (
    name VARCHAR(50),
    id_customer_user INT,
    PRIMARY KEY (name, id_customer_user),
    FOREIGN KEY (name)
        REFERENCES authority(name),
    FOREIGN KEY (id_customer_user)
        REFERENCES customer_user(id)
        
);

-- Carrito
CREATE TABLE carrito (
    id_carrito INT AUTO_INCREMENT PRIMARY KEY,
    fecha_creacion DATE DEFAULT (CURDATE()),
    estado ENUM('Activo', 'Finalizado', 'Cancelado') DEFAULT 'Activo',
    id_cliente INT NOT NULL,
    FOREIGN KEY (id_cliente)
        REFERENCES cliente(id)
);

-- Detalle del carrito
CREATE TABLE detalle_carrito (
    id_detalle INT AUTO_INCREMENT PRIMARY KEY,
    cantidad INT NOT NULL CHECK (cantidad > 0),
    precio DECIMAL(10,2) NOT NULL CHECK (precio > 0),
    subtotal DECIMAL(10,2) NOT NULL CHECK (subtotal >= 0),
    id_carrito INT NOT NULL,
    id_producto INT NOT NULL,
    FOREIGN KEY (id_carrito)
        REFERENCES carrito(id_carrito),
    FOREIGN KEY (id_producto)
        REFERENCES producto(id)
);

-- Empleados
CREATE TABLE empleado (
    id_empleado INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    cargo VARCHAR(50) NOT NULL,
    salario DECIMAL(10,2) NOT NULL CHECK (salario >= 0),
    estado ENUM('Activo', 'Inactivo') DEFAULT 'Activo'
);

-- Facturas
CREATE TABLE factura (
    id_factura INT AUTO_INCREMENT PRIMARY KEY,
    fecha DATE DEFAULT (CURDATE()),
    id_cliente INT NOT NULL,
    id_empleado INT NOT NULL,
    total DECIMAL(10,2) NOT NULL CHECK (total >= 0),
    FOREIGN KEY (id_cliente)
        REFERENCES cliente(id),
    FOREIGN KEY (id_empleado)
        REFERENCES empleado(id_empleado)
);

-- Detalle del pedido
CREATE TABLE detalle_pedido (
    id_factura INT,
    id_producto INT,
    cantidad INT NOT NULL CHECK (cantidad > 0),
    precio_unitario DECIMAL(10,2) NOT NULL CHECK (precio_unitario > 0),
    subtotal DECIMAL(10,2) NOT NULL CHECK (subtotal >= 0),
    PRIMARY KEY (id_factura, id_producto),
    FOREIGN KEY (id_factura)
        REFERENCES factura(id_factura),
    FOREIGN KEY (id_producto)
        REFERENCES producto(id)
);

-- Inventario
CREATE TABLE inventario (
    id_inventario INT AUTO_INCREMENT PRIMARY KEY,
    cantidad_disponible INT NOT NULL CHECK (cantidad_disponible >= 0),
    cantidad_minima INT NOT NULL CHECK (cantidad_minima >= 0),
    id_producto INT NOT NULL,
    FOREIGN KEY (id_producto)
        REFERENCES producto(id)
);

-- Proveedores
CREATE TABLE proveedor (
    id_proveedor INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    correo VARCHAR(100) NOT NULL UNIQUE,
    telefono VARCHAR(20)
);

-- Compras
CREATE TABLE compra (
    id_compra INT AUTO_INCREMENT PRIMARY KEY,
    fecha_compra DATE DEFAULT (CURDATE()),
    total DECIMAL(10,2) NOT NULL CHECK (total >= 0),
    id_proveedor INT NOT NULL,
    FOREIGN KEY (id_proveedor)
        REFERENCES proveedor(id_proveedor)
);

-- Detalle de compras
CREATE TABLE detalle_compra (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_compra INT NOT NULL,
    id_producto INT NOT NULL,
    cantidad INT NOT NULL CHECK (cantidad > 0),
    precio DECIMAL(10,2) NOT NULL CHECK (precio > 0),
    subtotal DECIMAL(10,2) NOT NULL CHECK (subtotal >= 0),
    FOREIGN KEY (id_compra)
        REFERENCES compra(id_compra),
    FOREIGN KEY (id_producto)
        REFERENCES producto(id)
);

-- Pagos
CREATE TABLE pago (
    id_pago INT AUTO_INCREMENT PRIMARY KEY,
    metodo_pago ENUM(
        'Efectivo',
        'Tarjeta',
        'Transferencia',
        'Nequi',
        'Daviplata'
    ) NOT NULL,
    fecha_pago DATE DEFAULT (CURDATE()),
    total DECIMAL(10,2) NOT NULL CHECK (total >= 0),
    id_factura INT NOT NULL,
    FOREIGN KEY (id_factura)
        REFERENCES factura(id_factura)
);

-- Entregas
CREATE TABLE entrega (
    id_entrega INT AUTO_INCREMENT PRIMARY KEY,
    fecha_entrega DATE,
    estado ENUM(
        'Pendiente',
        'En camino',
        'Entregado',
        'Cancelado'
    ) DEFAULT 'Pendiente',
    id_factura INT NOT NULL,
    FOREIGN KEY (id_factura)
        REFERENCES factura(id_factura)
);
