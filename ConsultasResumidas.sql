-- La cantidad de colaboradores que nacieron luego del año 1995.
SELECT
    count (FechaNacimiento)
from Colaboradores
where year(FechaNacimiento)>1995

-- El costo total de todos los pedidos que figuren como Pagado.
SELECT
    SUM(pe.Costo)
from Pedidos pe
where pe.Pagado=1

-- La cantidad total de unidades pedidas del producto con ID igual a 30.
    SELECT 
        SUM(p.Cantidad)
    from Pedidos p
    where p.IDProducto=30

-- La cantidad de clientes distintos que hicieron pedidos en el año 2020.
    SELECT distinct
        COUNT(p.IDCliente)
    from Pedidos p
    where year(p.FechaSolicitud)=2020

-- Por cada material, la cantidad de productos que lo utilizan.
    SELECT * from Materiales_x_Producto

    SELECT
        mp.IDMaterial,
        COUNT(mp.IDMaterial) as cantProductos
    from Materiales_x_Producto mp 
    group by mp.IDMaterial


-- Para cada producto, listar el nombre y la cantidad de pedidos pagados.
    SELECT * from Pedidos

    SELECT 
        pe.IDProducto,
        COUNT(*)
    From Pedidos pe 
    INNER JOIN Productos pr on pe.IDProducto= pr.ID
    where pe.Pagado =1
    GROUP by pe.IDProducto

    SELECT 
        pe.IDProducto,
        pr.Descripcion
    From Pedidos pe 
    INNER JOIN Productos pr on pe.IDProducto= pr.ID
    where pe.Pagado =1
    order by pe.IDProducto asc

    

-- Por cada cliente, listar apellidos y nombres de los clientes y la cantidad de productos distintos que haya pedido.
    
    SELECT
        pe.IDCliente,
        pe.IDProducto,
        cl.Apellidos,
        cl.Nombres
    from Pedidos pe
    inner join clientes cl on pe.IDCliente=cl.ID
    ORDER by pe.IDCliente

    SELECT
        c.Nombres,
        c.Apellidos,
        COUNT(distinct pe.IDProducto) cantProductoscl
    FROM Pedidos pe
    INNER JOIN Clientes c on pe.IDCliente=c.ID
    GROUP by pe.IDCliente, c.Nombres, c.Apellidos

    select * from Pedidos where IDCliente=32

-- Por cada colaborador y tarea que haya realizado, listar apellidos y nombres, nombre de la tarea y la cantidad de veces que haya realizado esa tarea.

    SELECT 
        col.Apellidos,
        col.Nombres,
        tr.Nombre,
        COUNT(txp.IDTarea) as TareasRealizadas
    from Colaboradores col
    inner JOIN Tareas_x_Pedido txp on col.Legajo=txp.Legajo
    INNER JOIN Tareas tr on txp.IDTarea=tr.ID
    group by txp.IDTarea, col.Apellidos, col.Nombres, tr.Nombre

    SELECT * from Tareas_x_Pedido


-- Por cada cliente, listar los apellidos y nombres y el importe individual más caro que hayan abonado en concepto de pago.

    SELECT
        cl.Apellidos,
        cl.Nombres,
        MAX(pe.Costo) elmenorcost
    from Clientes cl
    inner JOIN Pedidos pe on cl.ID=pe.IDCliente
    GROUP by pe.Costo, cl.Apellidos, cl.Nombres

select Costo,
IDCliente
from Pedidos
order by Costo asc

-- Por cada colaborador, apellidos y nombres y la menor cantidad de unidades solicitadas en un pedido individual en el que haya trabajado.

    SELECT
        co.Apellidos,
        co.Nombres,
        min(pe.Cantidad) cantUnidades
    from Colaboradores co
    inner JOIN Tareas_x_Pedido txp on co.Legajo=txp.Legajo
    inner join Pedidos pe on txp.IDPedido=pe.ID
    group by pe.Cantidad, co.Apellidos, co.Nombres


-- Listar apellidos y nombres de aquellos clientes que no hayan realizado ningún pedido. Es decir, que contabilicen 0 pedidos.

    select
    cl.Apellidos,
    cl.Nombres,
    pe.id
    from Clientes cl
    LEFT join Pedidos pe on cl.ID=pe.IDCliente
    where pe.id is null

    select
    cl.Apellidos,
    cl.Nombres,
    count (pe.id) Pedidosrealizados
    from Clientes cl
    LEFT join Pedidos pe on cl.ID=pe.IDCliente
    where pe.ID is null
    group by pe.ID, cl.Nombres, cl.Apellidos
    



-- Obtener un listado de productos indicando descripción y precio de aquellos productos que hayan registrado más de 15 pedidos.

SELECT 
    pr.Descripcion,
    pr.Costo,
    pe.Cantidad,
    COUNT(pr.ID) 
from Pedidos pe
inner join Productos pr on pr.ID=pe.IDCliente
where pe.Cantidad>15
GROUP by pr.ID, pr.Descripcion,pe.Cantidad, pr.Costo
order by pr.Descripcion asc

SELECT 
    pr.Descripcion,
    pr.Costo,
    COUNT(pr.Descripcion) CantProductos
from Pedidos pe
inner join Productos pr on pr.ID=pe.IDCliente
GROUP by pr.Descripcion, pr.Costo
HAVING COUNT(pr.Descripcion) >15

-- Obtener un listado de productos indicando descripción y nombre de categoría de los productos que tienen un precio promedio de pedidos mayor a 
--$25000.

SELECT 
    pr.Descripcion,
    ca.Nombre Categoria,
    pr.Costo,
    COUNT(pr.Costo) pedidosMayores
from Pedidos pe
inner join Productos pr on pr.ID=pe.IDCliente
inner join Categorias ca on pr.IDCategoria=ca.ID
where pr.Costo>25000
GROUP by pr.Descripcion, ca. Nombre, pr.Costo




-- Apellidos y nombres de los clientes que hayan registrado más de 15 pedidos que superen los $15000.

    SELECT
        cl.Apellidos,
        cl.Nombres,
        COUNT(pe.IDCliente) Clientes     
    from Pedidos pe
    inner join Clientes cl on pe.IDCliente=cl.ID
    GROUP by pe.IDCliente, cl.Apellidos, cl.Nombres
    HAVING COUNT(pe.IDCliente)>15 and SUM(pe.Costo) >15000

-- Para cada producto, listar el nombre, el texto 'Pagados'  y la cantidad de pedidos pagados. Anexar otro listado con nombre, el texto 'No pagados' y cantidad de pedidos no pagados.

SELECT 
    pr.ID,
    pr.Descripcion,
    COUNT(pe.Pagado) Pagados
from Productos pr
INNER JOIN Pedidos pe on pr.ID=pe.IDProducto
WHERE pe.Pagado=1
GROUP by pe.Pagado, pr.Descripcion, pr.ID