use bgj8s0thq9x1mii07wxo;

-- Chritian Monterrosa

-- Obtener todos los productos con su respectivo proveedor (detallar la información del proveedor)
SELECT p.nombre AS producto, p.precio, p.cantidad, pr.nombre AS proveedor FROM productos p INNER JOIN proveedores pr ON p.id_proveedor = pr.id_proveedor;

-- Mostrar solo los productos cuyo precio sea mayor a 15.00
SELECT nombre, precio FROM productos where precio > 15;

-- Listar los proveedores que no tienen teléfono registrado.
SELECT nombre FROM proveedores where telefono is NULL;

-- Contar cuántos productos hay por proveedor.
SELECT id_proveedor, COUNT(id_producto) AS Productos FROM productos GROUP BY id_proveedor;

------------------------------------------------------------------------------------------------------------------------------------

-- Lenny Servino

-- Calcular el valor total del inventario (cantidad * precio) para cada producto.
select nombre, cantidad, precio, cantidad * precio as 'Valor total' from productos;

-- Obtener el proveedor con más productos registrados.
select p.nombre, count(*) as 'Cantidad de productos' from proveedores p join productos pr on p.id_proveedor = pr.id_proveedor group by p.nombre order by count(*) desc limit 1;

-- Obtener el número total de productos por cada categoría. Usa la cláusula GROUP BY para agrupar los resultados por categoría.
select c.nombre as 'Categoría', count(*) as 'Cantidad de productos' from categorias c join productos p on c.id_categoria = p.id_categoria group by c.nombre;

/* Asignar una clasificación a los productos basándote en su precio: "Alto" para productos con un precio mayor a 20.00, y "Bajo" para los demás. Utiliza la cláusula CASE. */
select nombre, precio, case when precio > 20 then 'Alto' else 'Bajo' end as 'Clasificación' from productos;

------------------------------------------------------------------------------------------------------------------------------------

-- Alejandra Villatoro

/* Obtener todos los productos junto con el nombre del proveedor, incluso si algunos proveedores no tienen productos asociados. Usa la cláusula LEFT JOIN. */
SELECT p.id_producto, p.nombre AS producto, p.precio, pr.nombre AS proveedor FROM productos p LEFT JOIN proveedores pr ON p.id_proveedor = pr.id_proveedor;

/* Calcular el precio promedio de los productos en cada categoría. Usa la cláusula GROUP BY para agrupar los productos por categoría. */
SELECT c.nombre AS categoria, AVG(p.precio) AS precio_promedio FROM productos p INNER JOIN categorias c ON p.id_categoria = c.id_categoria GROUP BY c.nombre;

/* Filtrar las categorías que tienen más de dos productos registrados. Utiliza la cláusula HAVING para aplicar una condición de agregación. */
SELECT c.nombre AS categoria, COUNT(p.id_producto) AS total_productos FROM productos p INNER JOIN categorias c ON p.id_categoria = c.id_categoria GROUP BY c.nombre HAVING COUNT(p.id_producto) > 2;

------------------------------------------------------------------------------------------------------------------------------------

-- Marcos Alfaro

--  *Aumentar en un 10% el precio de todos los productos de la categoría "Electrónica" u otra categoría.*
UPDATE productos p
INNER JOIN categorias c ON p.id_categoria = c.id_categoria
SET p.precio = p.precio * 1.10
WHERE c.nombre = 'Electrónica';

--  *Obtener el producto más caro de cada categoría. Utiliza una subconsulta en la cláusula `WHERE` para obtener el máximo precio por categoría.*
SELECT p.*
FROM productos p
WHERE p.precio = (
    SELECT MAX(p2.precio)
    FROM productos p2
    WHERE p2.id_categoria = p.id_categoria
);

--  *Verificar si hay proveedores que tienen productos cuyo precio es menor a `10.00`. Utiliza la cláusula `EXISTS` con una subconsulta.*
SELECT p.nombre AS proveedor
FROM proveedores p
WHERE EXISTS (
    SELECT 1
    FROM productos pr
    WHERE pr.id_proveedor = p.id_proveedor
    AND pr.precio < 10.00
);

------------------------------------------------------------------------------------------------------------------------------------

