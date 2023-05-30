USE legos
;

-- Let's take an initial look at the data

SELECT *
FROM sets
LIMIT 10
;

-- In which years did Lego release the most sets?

SELECT year, COUNT(*) as Count_sets_year
FROM sets
GROUP BY year
ORDER BY Count_sets_year
DESC
LIMIT 5
;

-- Let's find the number of different colors for legos

SELECT COUNT(DISTINCT name)
FROM colors
;

-- Of these 135 colors how many are translucent?

SELECT is_trans AS Translucent, COUNT(*) AS Count
FROM colors
GROUP BY is_trans
;

-- How did the average number of parts in sets fluctuate over the years?

SELECT year, AVG(num_parts)
FROM sets
GROUP BY year
ORDER BY year
DESC
;


-- What were the most common themes?

SELECT name, COUNT(*) AS Count_Themes_Name
FROM themes
GROUP BY name
ORDER BY Count_Themes_Name
DESC
;

-- What were the names and counts of parent themes per recent year?

SELECT s.name AS Set_name, t.name AS Parent_theme_name, s.year, COUNT(*) AS Count_Theme_Name
FROM themes AS t
JOIN sets AS s
ON t.id = s.theme_id
GROUP BY t.parent_id
ORDER BY s.year
DESC
;

-- What were the years with the most quantities of inventory sets?

SELECT s.year, COUNT(*) AS Quant_Inv_Sets_year
FROM inventory_sets AS i
JOIN sets AS s
ON i.set_num = s.set_num
GROUP BY s.year, i.quantity
ORDER BY Quant_Inv_Sets_year
DESC
;

-- We can also make multiple joins to see the database in a comprehensive manner

SELECT *
FROM sets AS s
JOIN inventories AS i ON s.set_num = i.set_num
JOIN inventory_parts as ip ON i.id = ip.inventory_id
JOIN parts AS p ON ip.part_num = p.part_num
JOIN part_categories AS pc ON p.part_cat_id = pc.id
LIMIT 10
;

-- Since there were a lot of columns called "name" let's make that more specific

SELECT s.name AS Set_name, p.name AS Part_name, pc.name AS Part_category_name
FROM sets AS s
JOIN inventories AS i ON s.set_num = i.set_num
JOIN inventory_parts as ip ON i.id = ip.inventory_id
JOIN parts AS p ON ip.part_num = p.part_num
JOIN part_categories AS pc ON p.part_cat_id = pc.id
LIMIT 10
;

-- If we want to find a specific set name's part and part category we can apply filters

SELECT s.name AS Set_name, p.name AS Part_name, pc.name AS Part_category_name
FROM sets AS s
JOIN inventories AS i ON s.set_num = i.set_num
JOIN inventory_parts as ip ON i.id = ip.inventory_id
JOIN parts AS p ON ip.part_num = p.part_num
JOIN part_categories AS pc ON p.part_cat_id = pc.id
WHERE s.name = "Weetabix Castle"
;

