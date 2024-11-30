create database MesaB_Rico
use MesaB_Rico

create table Panaderia (
    id_panaderia int primary key, 
    nombre varchar(30) NOT NULL, 
    direccion varchar(50) NOT NULL 
);

exec sp_rename 'Panaderia.nombre', 'nombre_panaderia', 'column';
exec sp_rename 'Panaderia.direccion', 'direccion_panaderia', 'column';

insert into Panaderia values (
001, 'Mesa B Rico', 'Cl 39 # 36s-05 Envigado, Antioquia, Medellín');

create table Empleados (
    id_empleado int primary key identity (1,1),
	id_panaderia int NOT NULL,              
    constraint FK_Productos_Panaderia foreign key (id_panaderia)
    references Panaderia (id_panaderia),
    nombres varchar(30) NOT NULL,
    cargo varchar(30) NOT NULL,
    telefono numeric(10),
    correo varchar(50) 
);

exec sp_rename 'Empleados.nombres', 'nombre_empleado', 'column';
exec sp_rename 'Empleados.cargo', 'cargo_empleado', 'column';
exec sp_rename 'Empleados.telefono', 'telefono_empleado', 'column';
exec sp_rename 'Empleados.correo', 'correo_empleado', 'column';

insert into Empleados (id_panaderia, nombres, cargo, telefono, correo) values
(001, 'Juan Pérez', 'Panadero', 5551234567, 'juan.perez@example.com'),
(001, 'María López', 'Cajera', 5559876543, 'maria.lopez@example.com'),
(001, 'Carlos Sánchez', 'Gerente', 5556543210, 'carlos.sanchez@example.com'),
(001, 'Ana Gómez', 'Repostera', 5554321567, 'ana.gomez@example.com'),
(001, 'Luis Martínez', 'Ayudante', 5558765432, 'luis.martinez@example.com'),
(001, 'Sofía Hernández', 'Panadera', 5553456789, 'sofia.hernandez@example.com'),
(001, 'Diego Fernández', 'Repartidor', 5555678901, 'diego.fernandez@example.com'),
(001, 'Laura Ramírez', 'Cajera', 5559080706, 'laura.ramirez@example.com'),
(001, 'Pedro Morales', 'Panadero', 5554012020, 'pedro.morales@example.com'),
(001, 'Carla Torres', 'Repostera', 5553425345, 'carla.torres@example.com'),
(001, 'Fernando Vázquez', 'Repartidor', 5558761209, 'fernando.vazquez@example.com'),
(001, 'Andrea Ríos', 'Gerente', 5559091122, 'andrea.rios@example.com'),
(001, 'Miguel Castillo', 'Ayudante', 5552344567, 'miguel.castillo@example.com'),
(001, 'Patricia Delgado', 'Cajera', 5557643221, 'patricia.delgado@example.com'),
(001, 'Ricardo Medina', 'Panadero', 5553334445, 'ricardo.medina@example.com'),
(001, 'Valeria Núñez', 'Repostera', 5559988877, 'valeria.nunez@example.com'),
(001, 'Emilio Ortega', 'Repartidor', 5551122334, 'emilio.ortega@example.com'),
(001, 'Rosa Vargas', 'Ayudante', 5556677889, 'rosa.vargas@example.com'),
(001, 'Javier Reyes', 'Panadero', 5558877665, 'javier.reyes@example.com'),
(001, 'Elena Soto', 'Cajera', 5554433221, 'elena.soto@example.com');

alter table Empleados
drop constraint FK_Productos_Panaderia;

alter table Empleados
add constraint FK_Empleados_Panaderia foreign key (id_panaderia) references Panaderia (id_panaderia);

select * from Productos

create table Productos (
    id_producto int primary key,             
    nombre_producto varchar(50) NOT NULL,  
    exp_date date NOT NULL,                  
    made_date int NOT NULL,              
    id_panaderia int NOT NULL,               
    constraint FK_Productos_Panaderia foreign key (id_panaderia) references Panaderia (id_panaderia)
);

alter table Productos
drop column made_date 

alter table Productos
add made_date date

create table Proveedor (
    id_proveedor int primary key,         
    nombre varchar(50) NOT NULL,       
    telefono numeric(10) NULL,          
    direccion varchar(100) NOT NULL
	);

exec sp_rename 'Proveedor.nombre', 'nombre_proveedor', 'column';
exec sp_rename 'Proveedor.telefono', 'telefono_proveedor', 'column';
exec sp_rename 'Proveedor.direccion', 'direccion_proveedor', 'column';


create table MateriaPrima (
    cod_materiap int primary key,           
    id_panaderia int NOT NULL,              
    id_proveedor int NOT NULL,              
    fecha_entrega date NOT NULL,            
    fecha_vence date NOT NULL,              
    constraint FK_MateriaPrima_Panaderia foreign key (id_panaderia) references Panaderia (id_panaderia),
    constraint FK_MateriaPrima_Proveedor foreign key (id_proveedor) references Proveedor (id_proveedor)
	);

alter table MateriaPrima
add nombre_MatPrim varchar(50)

create table Clientes (
    id_cliente int primary key,              
    nombre_cliente varchar(30) NOT NULL,   
    telefono_cliente numeric(10) NOT NULL,  
    correo_cliente varchar(50) NOT NULL    
);

create table Compra (
    cod_compra int primary key,              
    id_panaderia int NOT NULL,               
    id_cliente int NOT NULL,
	id_producto int NOT NULL,
    fecha_compra date NOT NULL,              
    valor_compra decimal(10, 2) NOT NULL,     
    constraint FK_Compra_Panaderia foreign key (id_panaderia) references Panaderia (id_panaderia),
	constraint FK_Compra_Producto foreign key (id_producto) references Productos (id_producto),
    constraint FK_Compra_Cliente foreign key (id_cliente) references Clientes (id_cliente)
);

alter table Compra
drop constraint FK_Compra_Producto;

alter table Compra
drop column id_producto;

insert into Productos (id_producto, nombre_producto, exp_date, made_date, id_panaderia) values 
(1000, 'Pan de Avena', '2024-12-10', '2024-11-28', 1),
(1001, 'Pan Integral', '2024-12-12', '2024-11-29', 1),
(1002, 'Croissant', '2024-12-05', '2024-11-27', 1),
(1003, 'Baguette', '2024-12-09', '2024-11-26', 1),
(1004, 'Pan de Chocolate', '2024-12-15', '2024-11-30', 1),
(1005, 'Pastel de Manzana', '2024-12-20', '2024-11-25', 1),
(1006, 'Galletas de Vainilla', '2024-12-03', '2024-11-24', 1),
(1007, 'Tarta de Fresas', '2024-12-18', '2024-11-23', 1),
(1008, 'Muffin de Arándano', '2024-12-10', '2024-11-22', 1),
(1009, 'Pan de Molde', '2024-12-22', '2024-11-21', 1),
(1010, 'Galletas de Chips de Chocolate', '2024-12-04', '2024-11-20', 1),
(1011, 'Pan de Leche', '2024-12-11', '2024-11-19', 1),
(1012, 'Bocadillos de Jamón', '2024-12-17', '2024-11-18', 1),
(1013, 'Pan de Manteca', '2024-12-06', '2024-11-17', 1),
(1014, 'Tarta de Limón', '2024-12-14', '2024-11-16', 1),
(1015, 'Rosquillas', '2024-12-13', '2024-11-15', 1),
(1016, 'Pastel de Zanahoria', '2024-12-08', '2024-11-14', 1),
(1017, 'Pan de Aceitunas', '2024-12-07', '2024-11-13', 1),
(1018, 'Galletas de Jengibre', '2024-12-01', '2024-11-12', 1),
(1019, 'Bizcocho de Chocolate', '2024-12-21', '2024-11-11', 1),
(1020, 'Bollos de Canela', '2024-12-19', '2024-11-10', 1),
(1021, 'Panecillos de Ajo', '2024-12-02', '2024-11-09', 1),
(1022, 'Tarta de Durazno', '2024-12-16', '2024-11-08', 1),
(1023, 'Galletas de Coco', '2024-12-23', '2024-11-07', 1),
(1024, 'Pastel de Pera', '2024-12-25', '2024-11-06', 1),
(1025, 'Pan de Nuez', '2024-12-30', '2024-11-05', 1),
(1026, 'Pan de Frutas', '2024-12-04', '2024-11-04', 1),
(1027, 'Empanadas de Carne', '2024-12-28', '2024-11-03', 1),
(1028, 'Bocadillos de Pollo', '2024-12-10', '2024-11-02', 1),
(1029, 'Pan de Miel', '2024-12-12', '2024-11-01', 1),
(1030, 'Muffin de Plátano', '2024-12-11', '2024-10-30', 1),
(1031, 'Tarta de Chocolate', '2024-12-23', '2024-10-29', 1),
(1032, 'Pan de Tomate y Albahaca', '2024-12-25', '2024-10-28', 1),
(1033, 'Galletas de Mantequilla', '2024-12-18', '2024-10-27', 1),
(1034, 'Pastel de Crema', '2024-12-14', '2024-10-26', 1),
(1035, 'Tarta de Caramelo', '2024-12-05', '2024-10-25', 1),
(1036, 'Bollos de Frambuesa', '2024-12-17', '2024-10-24', 1),
(1037, 'Pan de Almejas', '2024-12-22', '2024-10-23', 1),
(1038, 'Galletas de Cacao', '2024-12-09', '2024-10-22', 1),
(1039, 'Muffin de Mango', '2024-12-28', '2024-10-21', 1),
(1040, 'Pan de Pasa', '2024-12-06', '2024-10-20', 1),
(1041, 'Pastel de Chocolate Blanco', '2024-12-30', '2024-10-19', 1),
(1042, 'Pan de Pistacho', '2024-12-07', '2024-10-18', 1),
(1043, 'Galletas de Almendra', '2024-12-04', '2024-10-17', 1),
(1044, 'Tarta de Chocolate con Fresas', '2024-12-16', '2024-10-16', 1),
(1045, 'Pan de Jengibre', '2024-12-14', '2024-10-15', 1),
(1046, 'Bocadillos de Verduras', '2024-12-12', '2024-10-14', 1),
(1047, 'Tarta de Mandarina', '2024-12-13', '2024-10-13', 1),
(1048, 'Galletas de Frambuesa', '2024-12-11', '2024-10-12', 1),
(1049, 'Pastel de Café', '2024-12-22', '2024-10-11', 1);

insert into Proveedor (id_proveedor, nombre_proveedor, telefono_proveedor, direccion_proveedor) values
(2000, 'Proveedor A', 123456789, 'Calle Ficticia 123, Medellin'),
(2001, 'Proveedor B', 234567890, 'Avenida Real 456, Envigado'),
(2002, 'Proveedor C', 345678901, 'Calle del Sol 789, Sabaneta'),
(2003, 'Proveedor D', 456789012, 'Calle Luna 321, Sabaneta'),
(2004, 'Proveedor E', 567890123, 'Calle de la Paz 654, Medellin'),
(2005, 'Proveedor F', 678901234, 'Avenida de la Libertad 987, Sabaneta'),
(2006, 'Proveedor G', 789012345, 'Calle Norte 123, Medellin'),
(2007, 'Proveedor H', 890123456, 'Calle del Mar 456, Medellin');

insert into MateriaPrima (cod_materiap, id_panaderia, id_proveedor, nombre_MatPrim, fecha_entrega, fecha_vence) values
(10000, 1, 2000, 'Harina', '2024-11-28', '2025-01-15'),
(10001, 1, 2001, 'Levadura', '2024-11-30', '2025-02-01'),
(10002, 1, 2002, 'Azúcar', '2024-12-02', '2025-02-10'),
(10003, 1, 2003, 'Sal', '2024-12-05', '2025-01-20'),
(10004, 1, 2004, 'Aceite', '2024-12-07', '2025-02-05'),
(10005, 1, 2005, 'Manteca', '2024-12-08', '2025-02-15'),
(10006, 1, 2006, 'Leche', '2024-12-09', '2025-01-18'),
(10007, 1, 2007, 'Huevos', '2024-12-10', '2025-01-30'),
(10008, 1, 2000, 'Chocolate', '2024-12-12', '2025-02-20'),
(10009, 1, 2001, 'Vainilla', '2024-12-13', '2025-03-01'),
(10010, 1, 2002, 'Cocoa', '2024-12-15', '2025-03-10'),
(10011, 1, 2003, 'Frutos secos', '2024-12-16', '2025-03-20'),
(10012, 1, 2004, 'Frambuesas', '2024-12-17', '2025-04-01'),
(10013, 1, 2005, 'Arándanos', '2024-12-18', '2025-04-10'),
(10014, 1, 2006, 'Azúcar glas', '2024-12-19', '2025-04-15'),
(10015, 1, 2007, 'Polvo para hornear', '2024-12-20', '2025-05-01'),
(10016, 1, 2000, 'Glaseado', '2024-12-22', '2025-05-05'),
(10017, 1, 2001, 'Crema pastelera', '2024-12-23', '2025-05-10'),
(10018, 1, 2002, 'Pistachos', '2024-12-25', '2025-05-20'),
(10019, 1, 2003, 'Miel', '2024-12-26', '2025-06-01'),
(10020, 1, 2004, 'Leche condensada', '2024-12-27', '2025-06-10'),
(10021, 1, 2005, 'Frutos secos', '2024-12-28', '2025-06-15'),
(10022, 1, 2006, 'Jalea', '2024-12-29', '2025-07-01'),
(10023, 1, 2007, 'Azúcar moreno', '2024-12-30', '2025-07-10'),
(10024, 1, 2000, 'Gelatina', '2025-01-01', '2025-07-15'),
(10025, 1, 2001, 'Frambuesas', '2025-01-02', '2025-07-20'),
(10026, 1, 2002, 'Té', '2025-01-03', '2025-08-01'),
(10027, 1, 2003, 'Canela', '2025-01-05', '2025-08-10'),
(10028, 1, 2004, 'Nuez moscada', '2025-01-06', '2025-08-15'),
(10029, 1, 2005, 'Mantequilla', '2025-01-08', '2025-09-01'),
(10030, 1, 2006, 'Galletas', '2025-01-09', '2025-09-05'),
(10031, 1, 2007, 'Coco rallado', '2025-01-10', '2025-09-15'),
(10032, 1, 2000, 'Tarta de manzana', '2025-01-12', '2025-10-01'),
(10033, 1, 2001, 'Arándano seco', '2025-01-13', '2025-10-05'),
(10034, 1, 2002, 'Crema de cacahuate', '2025-01-14', '2025-10-15'),
(10035, 1, 2003, 'Especias para pan', '2025-01-16', '2025-10-20'),
(10036, 1, 2004, 'Nuez', '2025-01-17', '2025-11-01'),
(10037, 1, 2005, 'Puré de manzana', '2025-01-18', '2025-11-10'),
(10038, 1, 2006, 'Plátano', '2025-01-19', '2025-11-15'),
(10039, 1, 2007, 'Leche de almendra', '2025-01-20', '2025-12-01'),
(10040, 1, 2000, 'Naranja', '2025-01-21', '2025-12-05'),
(10041, 1, 2001, 'Cereza', '2025-01-22', '2025-12-15'),
(10042, 1, 2002, 'Acelga', '2025-01-23', '2025-12-20'),
(10043, 1, 2003, 'Mermelada de fresa', '2025-01-25', '2026-01-01'),
(10044, 1, 2004, 'Acelga', '2025-01-26', '2026-01-10'),
(10045, 1, 2005, 'Puré de durazno', '2025-01-27', '2026-01-15'),
(10046, 1, 2006, 'Té verde', '2025-01-28', '2026-02-01'),
(10047, 1, 2007, 'Frutos rojos', '2025-01-29', '2026-02-10'),
(10048, 1, 2000, 'Galletas de chocolate', '2025-01-31', '2026-02-15'),
(10049, 1, 2001, 'Café', '2025-02-01', '2026-02-20'),
(10050, 1, 2002, 'Frutos rojos', '2025-02-02', '2026-03-01'),
(10051, 1, 2003, 'Azúcar moreno', '2025-02-03', '2026-03-10'),
(10052, 1, 2004, 'Pistachos', '2025-02-04', '2026-03-20'),
(10053, 1, 2005, 'Levadura seca', '2025-02-05', '2026-04-01'),
(10054, 1, 2006, 'Semillas de chía', '2025-02-06', '2026-04-10'),
(10055, 1, 2007, 'Aceite de oliva', '2025-02-07', '2026-04-15'),
(10056, 1, 2000, 'Harina de almendra', '2025-02-08', '2026-05-01'),
(10057, 1, 2001, 'Mantequilla', '2025-02-09', '2026-05-05'),
(10058, 1, 2002, 'Frambuesas', '2025-02-10', '2026-05-10'),
(10059, 1, 2003, 'Leche evaporada', '2025-02-11', '2026-05-20'),
(10060, 1, 2004, 'Especias', '2025-02-12', '2026-06-01'),
(10061, 1, 2005, 'Aceite de coco', '2025-02-13', '2026-06-10'),
(10062, 1, 2006, 'Sirope de arce', '2025-02-14', '2026-06-15'),
(10063, 1, 2007, 'Coco fresco', '2025-02-15', '2026-07-01'),
(10064, 1, 2000, 'Caramelo', '2025-02-16', '2026-07-05'),
(10065, 1, 2001, 'Harina de trigo', '2025-02-17', '2026-07-10'),
(10066, 1, 2002, 'Manteca de cerdo', '2025-02-18', '2026-07-15'),
(10067, 1, 2003, 'Levadura fresca', '2025-02-19', '2026-08-01'),
(10068, 1, 2004, 'Mantequilla clarificada', '2025-02-20', '2026-08-10'),
(10069, 1, 2005, 'Jarabe de maíz', '2025-02-21', '2026-08-15'),
(10070, 1, 2006, 'Salmón ahumado', '2025-02-22', '2026-09-01'),
(10071, 1, 2007, 'Almendras', '2025-02-23', '2026-09-10');

insert into Clientes (id_cliente, nombre_cliente, telefono_cliente, correo_cliente) values
(3001, 'Ana García', 123456789, 'ana.garcia@email.com'),
(3002, 'Luis Pérez', 123456780, 'luis.perez@email.com'),
(3003, 'Carlos Martínez', 123456781, 'carlos.martinez@email.com'),
(3004, 'Maria López', 123456782, 'maria.lopez@email.com'),
(3005, 'Jose Rodríguez', 123456783, 'jose.rodriguez@email.com'),
(3006, 'Sofia Fernández', 123456784, 'sofia.fernandez@email.com'),
(3007, 'Juan García', 123456785, 'juan.garcia@email.com'),
(3008, 'Marta Sánchez', 123456786, 'marta.sanchez@email.com'),
(3009, 'Pedro Díaz', 123456787, 'pedro.diaz@email.com'),
(3010, 'Laura Gómez', 123456788, 'laura.gomez@email.com'),
(3011, 'Ricardo Romero', 123456789, 'ricardo.romero@email.com'),
(3012, 'Eva Torres', 123456780, 'eva.torres@email.com'),
(3013, 'Francisco Díaz', 123456781, 'francisco.diaz@email.com'),
(3014, 'Carmen Pérez', 123456782, 'carmen.perez@email.com'),
(3015, 'David González', 123456783, 'david.gonzalez@email.com'),
(3016, 'Sara García', 123456784, 'sara.garcia@email.com'),
(3017, 'Antonio Jiménez', 123456785, 'antonio.jimenez@email.com'),
(3018, 'Paula Martínez', 123456786, 'paula.martinez@email.com'),
(3019, 'Jorge Ruiz', 123456787, 'jorge.ruiz@email.com'),
(3020, 'Isabel Romero', 123456788, 'isabel.romero@email.com'),
(3021, 'Alejandro Martínez', 123456789, 'alejandro.martinez@email.com'),
(3022, 'Fernando Pérez', 123456780, 'fernando.perez@email.com'),
(3023, 'Sofía González', 123456781, 'sofia.gonzalez@email.com'),
(3024, 'Rafael Torres', 123456782, 'rafael.torres@email.com'),
(3025, 'Martín García', 123456783, 'martin.garcia@email.com'),
(3026, 'Berta López', 123456784, 'berta.lopez@email.com'),
(3027, 'Javier Sánchez', 123456785, 'javier.sanchez@email.com'),
(3028, 'Joaquín Pérez', 123456786, 'joaquin.perez@email.com'),
(3029, 'Mónica García', 123456787, 'monica.garcia@email.com'),
(3030, 'Luis González', 123456788, 'luis.gonzalez@email.com'),
(3031, 'Pablo Ruiz', 123456789, 'pablo.ruiz@email.com'),
(3032, 'Verónica Romero', 123456780, 'veronica.romero@email.com'),
(3033, 'Natalia Torres', 123456781, 'natalia.torres@email.com'),
(3034, 'Guillermo Martínez', 123456782, 'guillermo.martinez@email.com'),
(3035, 'Raúl Pérez', 123456783, 'raul.perez@email.com'),
(3036, 'Claudia Gómez', 123456784, 'claudia.gomez@email.com'),
(3037, 'José Sánchez', 123456785, 'jose.sanchez@email.com'),
(3038, 'Sandra Díaz', 123456786, 'sandra.diaz@email.com'),
(3039, 'Tomás Fernández', 123456787, 'tomas.fernandez@email.com'),
(3040, 'Patricia Romero', 123456788, 'patricia.romero@email.com'),
(3041, 'Luis Hernández', 123456789, 'luis.hernandez@email.com'),
(3042, 'Alicia Sánchez', 123456780, 'alicia.sanchez@email.com'),
(3043, 'Álvaro Martínez', 123456781, 'alvaro.martinez@email.com'),
(3044, 'Fernando López', 123456782, 'fernando.lopez@email.com'),
(3045, 'Raquel Pérez', 123456783, 'raquel.perez@email.com'),
(3046, 'Enrique Torres', 123456784, 'enrique.torres@email.com'),
(3047, 'Leticia Díaz', 123456785, 'leticia.diaz@email.com'),
(3048, 'Ángel Ruiz', 123456786, 'angel.ruiz@email.com'),
(3049, 'Marta Romero', 123456787, 'marta.romero@email.com'),
(3050, 'Fernando González', 123456788, 'fernando.gonzalez@email.com'),
(3051, 'Celia Fernández', 123456789, 'celia.fernandez@email.com'),
(3052, 'Raúl González', 123456780, 'raul.gonzalez@email.com'),
(3053, 'Susana Romero', 123456781, 'susana.romero@email.com'),
(3054, 'Julio Sánchez', 123456782, 'julio.sanchez@email.com'),
(3055, 'Fabiola Martínez', 123456783, 'fabiola.martinez@email.com'),
(3056, 'Eduardo López', 123456784, 'eduardo.lopez@email.com'),
(3057, 'Claudia Ruiz', 123456785, 'claudia.ruiz@email.com'),
(3058, 'Luis Torres', 123456786, 'luis.torres@email.com'),
(3059, 'Marta Gómez', 123456787, 'marta.gomez@email.com'),
(3060, 'Ricardo Sánchez', 123456788, 'ricardo.sanchez@email.com'),
(3061, 'Olga Díaz', 123456789, 'olga.diaz@email.com'),
(3062, 'César Fernández', 123456780, 'cesar.fernandez@email.com'),
(3063, 'Verónica Pérez', 123456781, 'veronica.perez@email.com'),
(3064, 'Gonzalo Martínez', 123456782, 'gonzalo.martinez@email.com'),
(3065, 'María Ruiz', 123456783, 'maria.ruiz@email.com'),
(3066, 'Joaquín Sánchez', 123456784, 'joaquin.sanchez@email.com'),
(3067, 'Lidia Romero', 123456785, 'lidia.romero@email.com'),
(3068, 'Simón Gómez', 123456786, 'simon.gomez@email.com'),
(3069, 'Carlos Hernández', 123456787, 'carlos.hernandez@email.com'),
(3070, 'Patricia Pérez', 123456788, 'patricia.perez@email.com'),
(3071, 'Juliana Ruiz', 123456789, 'juliana.ruiz@email.com'),
(3072, 'Ignacio Martínez', 123456780, 'ignacio.martinez@email.com'),
(3073, 'Tania González', 123456781, 'tania.gonzalez@email.com'),
(3074, 'Marcos Sánchez', 123456782, 'marcos.sanchez@email.com'),
(3075, 'Beatriz Torres', 123456783, 'beatriz.torres@email.com'),
(3076, 'Antonio Pérez', 123456784, 'antonio.perez@email.com'),
(3077, 'Vanessa Romero', 123456785, 'vanessa.romero@email.com'),
(3078, 'Sergio Díaz', 123456786, 'sergio.diaz@email.com'),
(3079, 'Fernando Fernández', 123456787, 'fernando.fernandez@email.com'),
(3080, 'Margarita García', 123456788, 'margarita.garcia@email.com'),
(3081, 'Rocío Martínez', 123456789, 'rocio.martinez@email.com'),
(3082, 'Ricardo Pérez', 123456780, 'ricardo.perez@email.com'),
(3083, 'Raquel Sánchez', 123456781, 'raquel.sanchez@email.com'),
(3084, 'Raúl Díaz', 123456782, 'raul.diaz@email.com'),
(3085, 'Mónica González', 123456783, 'monica.gonzalez@email.com'),
(3086, 'Paula Hernández', 123456784, 'paula.hernandez@email.com'),
(3087, 'Eugenio Ruiz', 123456785, 'eugenio.ruiz@email.com'),
(3088, 'Cristina Gómez', 123456786, 'cristina.gomez@email.com'),
(3089, 'Manuel Martínez', 123456787, 'manuel.martinez@email.com'),
(3090, 'Adriana Pérez', 123456788, 'adriana.perez@email.com'),
(3091, 'Felipe Sánchez', 123456789, 'felipe.sanchez@email.com'),
(3092, 'Alfonso Díaz', 123456780, 'alfonso.diaz@email.com'),
(3093, 'Alba Ruiz', 123456781, 'alba.ruiz@email.com'),
(3094, 'Isabel González', 123456782, 'isabel.gonzalez@email.com'),
(3095, 'Eva Hernández', 123456783, 'eva.hernandez@email.com'),
(3096, 'Nadia Martínez', 123456784, 'nadia.martinez@email.com'),
(3097, 'Tomás Sánchez', 123456785, 'tomas.sanchez@email.com'),
(3098, 'Felipe Romero', 123456786, 'felipe.romero@email.com'),
(3099, 'Raquel Gómez', 123456787, 'raquel.gomez@email.com'),
(3100, 'Sandra Díaz', 123456788, 'sandra.diaz@email.com'),
(3101, 'Juan Romero', 123456789, 'juan.romero@email.com'),
(3102, 'María Sánchez', 123456780, 'maria.sanchez@email.com'),
(3103, 'David Torres', 123456781, 'david.torres@email.com'),
(3104, 'Cristina Fernández', 123456782, 'cristina.fernandez@email.com'),
(3105, 'José Romero', 123456783, 'jose.romero@email.com');

insert into Compra (cod_compra, id_panaderia, id_cliente, fecha_compra, valor_compra) values
(7521, '001', 3001, '2024-11-01', 550000),
(7522, '001', 3002, '2024-11-02', 800000),
(7523, '001', 3003, '2024-11-03', 450000),
(7524, '001', 3004, '2024-11-04', 675000),
(7525, '001', 3005, '2024-11-05', 400000),
(7526, '001', 3006, '2024-11-06', 540000),
(7527, '001', 3007, '2024-11-07', 600000),
(7528, '001', 3008, '2024-11-08', 740000),
(7529, '001', 3009, '2024-11-09', 495000),
(7530, '001', 3010, '2024-11-10', 875000),
(7531, '001', 3011, '2024-11-11', 525000),
(7532, '001', 3012, '2024-11-12', 670000),
(7533, '001', 3013, '2024-11-13', 585000),
(7534, '001', 3014, '2024-11-14', 620000),
(7535, '001', 3015, '2024-11-15', 740000),
(7536, '001', 3016, '2024-11-16', 635000),
(7537, '001', 3017, '2024-11-17', 580000),
(7538, '001', 3018, '2024-11-18', 620000),
(7539, '001', 3019, '2024-11-19', 765000),
(7540, '001', 3020, '2024-11-20', 540000),
(7541, '001', 3021, '2024-11-21', 875000),
(7542, '001', 3022, '2024-11-22', 730000),
(7543, '001', 3023, '2024-11-23', 670000),
(7544, '001', 3024, '2024-11-24', 590000),
(7545, '001', 3025, '2024-11-25', 625000),
(7546, '001', 3026, '2024-11-26', 730000),
(7547, '001', 3027, '2024-11-27', 655000),
(7548, '001', 3028, '2024-11-28', 530000),
(7549, '001', 3029, '2024-11-29', 485000),
(7550, '001', 3030, '2024-11-30', 830000),
(7551, '001', 3031, '2024-12-01', 950000),
(7552, '001', 3032, '2024-12-02', 760000),
(7553, '001', 3033, '2024-12-03', 625000),
(7554, '001', 3034, '2024-12-04', 590000),
(7555, '001', 3035, '2024-12-05', 675000),
(7556, '001', 3036, '2024-12-06', 580000),
(7557, '001', 3037, '2024-12-07', 700000),
(7558, '001', 3038, '2024-12-08', 585000),
(7559, '001', 3039, '2024-12-09', 750000),
(7560, '001', 3040, '2024-12-10', 680000),
(7561, '001', 3041, '2024-12-11', 760000),
(7562, '001', 3042, '2024-12-12', 825000),
(7563, '001', 3043, '2024-12-13', 650000),
(7564, '001', 3044, '2024-12-14', 580000),
(7565, '001', 3045, '2024-12-15', 530000),
(7566, '001', 3046, '2024-12-16', 660000),
(7567, '001', 3047, '2024-12-17', 650000),
(7568, '001', 3048, '2024-12-18', 720000),
(7569, '001', 3049, '2024-12-19', 615000),
(7570, '001', 3050, '2024-12-20', 780000),
(7591, '001', 3051, '2025-01-01', 850000),
(7592, '001', 3052, '2025-01-02', 720000),
(7593, '001', 3053, '2025-01-03', 680000),
(7594, '001', 3054, '2025-01-04', 750000),
(7595, '001', 3055, '2025-01-05', 800000),
(7596, '001', 3056, '2025-01-06', 740000),
(7597, '001', 3057, '2025-01-07', 720000),
(7598, '001', 3058, '2025-01-08', 850000),
(7599, '001', 3059, '2025-01-09', 780000),
(7600, '001', 3060, '2025-01-10', 695000),
(7601, '001', 3061, '2025-01-11', 630000),
(7602, '001', 3062, '2025-01-12', 710000),
(7603, '001', 3063, '2025-01-13', 755000),
(7604, '001', 3064, '2025-01-14', 720000),
(7605, '001', 3065, '2025-01-15', 670000),
(7606, '001', 3066, '2025-01-16', 675000),
(7607, '001', 3067, '2025-01-17', 780000),
(7608, '001', 3068, '2025-01-18', 740000),
(7609, '001', 3069, '2025-01-19', 830000),
(7610, '001', 3070, '2025-01-20', 800000),
(7611, '001', 3071, '2025-01-21', 725000),
(7612, '001', 3072, '2025-01-22', 695000),
(7613, '001', 3073, '2025-01-23', 755000),
(7614, '001', 3074, '2025-01-24', 765000),
(7615, '001', 3075, '2025-01-25', 720000),
(7616, '001', 3076, '2025-01-26', 740000),
(7617, '001', 3077, '2025-01-27', 710000),
(7618, '001', 3078, '2025-01-28', 675000),
(7619, '001', 3079, '2025-01-29', 690000),
(7620, '001', 3080, '2025-01-30', 780000),
(7621, '001', 3081, '2025-02-01', 750000),
(7622, '001', 3082, '2025-02-02', 680000),
(7623, '001', 3083, '2025-02-03', 710000),
(7624, '001', 3084, '2025-02-04', 740000);

create table Auditoria_General (
    id_auditoria int identity(1,1) PRIMARY KEY,
    tabla varchar(100),
    evento varchar(10),
    fecha datetime default GETDATE(),
    usuario varchar(100),
    datos_anteriores varchar(MAX), 
    datos_nuevos varchar(MAX)      
);

create trigger Trigger_Compra_Insert
on Compra
after insert
as
begin
    insert into Auditoria_General (tabla, evento, usuario, datos_nuevos)
    select 
        'Compra' as tabla,
        'Insert' as evento,
        SYSTEM_USER as usuario,
        concat('cod_compra: ', i.cod_compra, ', id_panaderia: ', i.id_panaderia, ', id_cliente: ', i.id_cliente, 
               ', fecha_compra: ', i.fecha_compra, ', valor_compra: ', i.valor_compra)
    from inserted i;
end;

select * from Auditoria_General

create trigger Trigger_Compra_Update
on Compra
after UPDATE
as
begin
    insert into Auditoria_General (tabla, evento, usuario, datos_anteriores, datos_nuevos)
    select 
        'Compra' as tabla,
        'Update' as evento,
        SYSTEM_USER as usuario,
        concat('cod_compra: ', d.cod_compra, ', id_panaderia: ', d.id_panaderia, ', id_cliente: ', d.id_cliente, 
               ', fecha_compra: ', d.fecha_compra, ', valor_compra: ', d.valor_compra) as datos_anteriores,
        concat('cod_compra: ', i.cod_compra, ', id_panaderia: ', i.id_panaderia, ', id_cliente: ', i.id_cliente, 
               ', fecha_compra: ', i.fecha_compra, ', valor_compra: ', i.valor_compra) as datos_nuevos
    from deleted d
    INNER JOIN inserted i on d.cod_compra = i.cod_compra;
end;

create trigger Trigger_Compra_Delete
on Compra
after delete
as
begin
    insert into Auditoria_General (tabla, evento, usuario, datos_anteriores)
    select 
        'Compra' as tabla,
        'Delete' as evento,
        SYSTEM_USER as usuario,
        concat('cod_compra: ', d.cod_compra, ', id_panaderia: ', d.id_panaderia, ', id_cliente: ', d.id_cliente, 
               ', fecha_compra: ', d.fecha_compra, ', valor_compra: ', d.valor_compra)
    from deleted d;
end;

CREATE TRIGGER Trigger_Clientes_Insert
ON Clientes
AFTER INSERT
AS
BEGIN
    INSERT INTO Auditoria_General (tabla, evento, usuario, datos_nuevos)
    SELECT 
        'Clientes' AS tabla,
        'INSERT' AS evento,
        SYSTEM_USER AS usuario,
        CONCAT('id_cliente: ', i.id_cliente, ', nombre_cliente: ', i.nombre_cliente, ', telefono_cliente: ', i.telefono_cliente, ', correo_cliente: ', i.correo_cliente)
    FROM INSERTED i;
END;

CREATE TRIGGER Trigger_Clientes_Update
ON Clientes
AFTER UPDATE
AS
BEGIN
    INSERT INTO Auditoria_General (tabla, evento, usuario, datos_anteriores, datos_nuevos)
    SELECT 
        'Clientes' AS tabla,
        'UPDATE' AS evento,
        SYSTEM_USER AS usuario,
        CONCAT('id_cliente: ', d.id_cliente, ', nombre_cliente: ', d.nombre_cliente, ', telefono_cliente: ', d.telefono_cliente, ', correo_cliente: ', d.correo_cliente) AS datos_anteriores,
        CONCAT('id_cliente: ', i.id_cliente, ', nombre_cliente: ', i.nombre_cliente, ', telefono_cliente: ', i.telefono_cliente, ', correo_cliente: ', i.correo_cliente) AS datos_nuevos
    FROM DELETED d
    INNER JOIN INSERTED i ON d.id_cliente = i.id_cliente;
END;

CREATE TRIGGER Trigger_Clientes_Delete
ON Clientes
AFTER DELETE
AS
BEGIN
    INSERT INTO Auditoria_General (tabla, evento, usuario, datos_anteriores)
    SELECT 
        'Clientes' AS tabla,
        'DELETE' AS evento,
        SYSTEM_USER AS usuario,
        CONCAT('id_cliente: ', d.id_cliente, ', nombre_cliente: ', d.nombre_cliente, ', telefono_cliente: ', d.telefono_cliente, ', correo_cliente: ', d.correo_cliente)
    FROM DELETED d;
END;

CREATE TRIGGER Trigger_Productos_Insert
ON Productos
AFTER INSERT
AS
BEGIN
    INSERT INTO Auditoria_General (tabla, evento, usuario, datos_nuevos)
    SELECT 
        'Productos' AS tabla,
        'INSERT' AS evento,
        SYSTEM_USER AS usuario,
        CONCAT('id_producto: ', i.id_producto, ', nombre_producto: ', i.nombre_producto, ', exp_date: ', i.exp_date, ', made_date: ', i.made_date, ', id_panaderia: ', i.id_panaderia)
    FROM INSERTED i;
END;

CREATE TRIGGER Trigger_Productos_Update
ON Productos
AFTER UPDATE
AS
BEGIN
    INSERT INTO Auditoria_General (tabla, evento, usuario, datos_anteriores, datos_nuevos)
    SELECT 
        'Productos' AS tabla,
        'UPDATE' AS evento,
        SYSTEM_USER AS usuario,
        CONCAT('id_producto: ', d.id_producto, ', nombre_producto: ', d.nombre_producto, ', exp_date: ', d.exp_date, ', made_date: ', d.made_date, ', id_panaderia: ', d.id_panaderia) AS datos_anteriores,
        CONCAT('id_producto: ', i.id_producto, ', nombre_producto: ', i.nombre_producto, ', exp_date: ', i.exp_date, ', arrival_date: ', i.made_date, ', id_panaderia: ', i.id_panaderia) AS datos_nuevos
    FROM DELETED d
    INNER JOIN INSERTED i ON d.id_producto = i.id_producto;
END;

CREATE TRIGGER Trigger_Productos_Delete
ON Productos
AFTER DELETE
AS
BEGIN
    INSERT INTO Auditoria_General (tabla, evento, usuario, datos_anteriores)
    SELECT 
        'Productos' AS tabla,
        'DELETE' AS evento,
        SYSTEM_USER AS usuario,
        CONCAT('id_producto: ', d.id_producto, ', nombre_producto: ', d.nombre_producto, ', exp_date: ', d.exp_date, ', made_date: ', d.made_date, ', id_panaderia: ', d.id_panaderia)
    FROM DELETED d;
END;

CREATE TRIGGER Trigger_Proveedores_Insert
ON Proveedor
AFTER INSERT
AS
BEGIN
    INSERT INTO Auditoria_General (tabla, evento, usuario, datos_nuevos)
    SELECT 
        'Proveedores' AS tabla,
        'INSERT' AS evento,
        SYSTEM_USER AS usuario,
        CONCAT('id_proveedor: ', i.id_proveedor, ', nombre_proveedor: ', i.nombre_proveedor, ', telefono_proveedor: ', i.telefono_proveedor, ', direccion_proveedor: ', i.direccion_proveedor)
    FROM INSERTED i;
END;

CREATE PROCEDURE RegistrarCompra
    @cod_compra INT,
    @id_panaderia CHAR(3),
    @id_cliente INT,
    @fecha_compra DATE,
    @valor_compra DECIMAL(10, 2)
AS
BEGIN
    BEGIN TRY
        INSERT INTO Compra (cod_compra, id_panaderia, id_cliente, fecha_compra, valor_compra)
        VALUES (@cod_compra, @id_panaderia, @id_cliente, @fecha_compra, @valor_compra);

        PRINT 'Compra registrada exitosamente.';
    END TRY
    BEGIN CATCH
        PRINT 'Error al registrar la compra: ' + ERROR_MESSAGE();
    END CATCH;
END;

EXEC RegistrarCompra 
    @cod_compra = 7626, 
    @id_panaderia = 001, 
    @id_cliente = 3001, 
    @fecha_compra = '2024-11-29', 
    @valor_compra = 25000.00;

CREATE PROCEDURE ConsultarClientesPorTelefono
    @telefono_cliente NUMERIC(10)
AS
BEGIN
    BEGIN TRY
        SELECT id_cliente, nombre_cliente, telefono_cliente, correo_cliente
        FROM Clientes
        WHERE telefono_cliente = @telefono_cliente;

        PRINT 'Consulta finalizada exitosamente.';
    END TRY
    BEGIN CATCH
        PRINT 'Error al realizar la consulta: ' + ERROR_MESSAGE();
    END CATCH;
END;

EXEC ConsultarClientesPorTelefono @telefono_cliente = 123456788;

CREATE PROCEDURE ActualizarValorCompra
    @cod_compra INT,
    @nuevo_valor DECIMAL(10, 2)
AS
BEGIN
    BEGIN TRY
        UPDATE Compra
        SET valor_compra = @nuevo_valor
        WHERE cod_compra = @cod_compra;

        PRINT 'Valor de la compra actualizado exitosamente.';
    END TRY
    BEGIN CATCH
        PRINT 'Error al actualizar el valor: ' + ERROR_MESSAGE();
    END CATCH;
END;

EXEC ActualizarValorCompra @cod_compra = 7521, @nuevo_valor = 30000.00;

CREATE PROCEDURE EliminarProductosCaducados
AS
BEGIN
    BEGIN TRY
        DELETE FROM Productos
        WHERE exp_date < GETDATE();

        PRINT 'Productos caducados eliminados exitosamente.';
    END TRY
    BEGIN CATCH
        PRINT 'Error al eliminar productos caducados: ' + ERROR_MESSAGE() ;
    END CATCH;
END;

insert into Productos (id_producto, nombre_producto, exp_date, made_date, id_panaderia) values
(1050, 'Pan Pizza', '2024-11-10', '2024-10-20', 001); 

EXEC EliminarProductosCaducados;
