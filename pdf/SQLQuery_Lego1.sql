-- Which theme has the most parts?
select t.name as 'Theme Name', s.name as 'Set Name', s.year, s.num_parts from themes t
inner join sets s 
on t.id = s.theme_id
order by num_parts desc;

-- See the number of Themes
select*from themes
select name, count(name) from themes
group by name
order by count(name) desc;


-- See the number of Sets
select*from sets
select name, count(name) as 'Set Qty' from sets
group by name
order by count(name) desc;

-- See details of Sets with most Set Qty
select*from sets
where name = 'Basic Building Set'
order by num_parts desc;

-- Check out the themes of 'Basic Building Set' 
select t.name, s.theme_id, s.num_parts from themes t
inner join sets s 
on t.id = s.theme_id
where s.name = 'Basic Building Set';

-- Check which sets have spare
select*from inventory_parts where is_spare ='t';

-- Let's join inventory_parts, inventory_sets & sets
select inp.part_num, inp.color_id, inp.quantity, inp.is_spare, ins.set_num, ins.quantity, s.num_parts, s.name as 'Set', t.name as 'Theme' from inventory_parts inp
inner join inventory_sets ins
on inp.inventory_id = ins.inventory_id
inner join sets s
on ins.set_num = s.set_num
inner join themes t
on s.theme_id = t.id
where inp.is_spare = 't'
order by s.num_parts desc;
-- This view is not helping

-- Notice that sets is connected to inventories
select inp.part_num, inp.color_id, inp.quantity, inp.is_spare, s.num_parts, s.name as 'Set', t.name as 'Theme', t.id from inventory_parts inp
inner join inventories i
on inp.inventory_id = i.id
inner join sets s
on i.set_num = s.set_num
inner join themes t
on s.theme_id = t.id
where inp.is_spare = 't'
order by inp.quantity desc, s.num_parts desc;

--Alternative syntax
select s.name as 'Set Name', t.name as 'Theme Name', s.num_parts, inp.is_spare, inp.quantity, inp.color_id, inp.part_num from sets s 
inner join themes t 
on s.theme_id = t.id
inner join inventories i
on s.set_num = i.set_num
inner join inventory_parts inp
on i.id = inp.inventory_id

select s.name, count(s.name) as 'Set Qty' from sets s 
inner join themes t 
on s.theme_id = t.id
inner join inventories i
on s.set_num = i.set_num
inner join inventory_parts inp
on i.id = inp.inventory_id
group by s.name
order by count(s.name) desc;

select s.name, count(inp.is_spare) from sets s 
inner join themes t 
on s.theme_id = t.id
inner join inventories i
on s.set_num = i.set_num
inner join inventory_parts inp
on i.id = inp.inventory_id
where s.theme_id = 158
group by s.name



select inp.part_num, inp.color_id, inp.quantity, inp.is_spare, s.num_parts, s.name as 'Set', t.name as 'Theme', t.id from inventory_parts inp
inner join inventories i
on inp.inventory_id = i.id
inner join sets s
on i.set_num = s.set_num
inner join themes t
on s.theme_id = t.id
where inp.is_spare = 't' and t.name = 'Star Wars'
order by inp.quantity desc, s.num_parts desc;

select*from sets 

select name, count(name), num_parts from sets
group by count(name)
having name like '% Advent Calendar %';

select name, sum(num_parts) from sets
group by name
order by sum(num_parts) desc;