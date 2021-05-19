-- Alter table
alter table inventories
alter column id int;

alter table inventory_sets
alter column quantity int;

alter table sets
alter column theme_id int;
alter table sets
alter column num_parts int;

alter table themes
alter column id int;

alter table inventory_minifigs
alter column inventory_id int;
alter table inventory_minifigs
alter column quantity int;

alter table colors
alter column id int;

alter table part_categories
alter column id int;

alter table inventory_parts
alter column inventory_id int;
alter table inventory_parts
alter column quantity int;

alter table inventories
alter column id int;

-- Let's see which theme has the highest number of sets
select top 20 t.name as 'Theme', s.name as 'Set', s.year, s.num_parts from themes t
inner join sets s
on t.id = s.theme_id
order by s.num_parts desc;
-- The Ultimate Battle for Chima has the most pieces.

-- Notice that there are repetitions in Theme. Let's see Lego got the most Themes.
select top 20 theme_id, count(theme_id) as 'No. of theme' from sets
group by theme_id
order by count(theme_id) desc;

select*from sets where theme_id = 501;
select*from themes where id = 501;
-- theme_id 501 is 'Gears'. It has a lot of characters from different genres. Let's look at Number 2. 
select*from sets where theme_id = 158;
select*from themes where id = 158;
-- theme_id 158 is 'Star Wars'. This is ideal!

-- Check out the spare parts from Star Wars
select s.name, s.num_parts, inp.part_num, inp.quantity, inp.color_id from sets s
inner join inventories inv
on s.set_num = inv.set_num
inner join inventory_parts inp
on inv.id = inp.inventory_id
where s.theme_id = 158
and inp.is_spare = 't';

select s.name as 'Set Name', s.set_num, s.num_parts, inp.part_num, inp.quantity, inp.color_id, c.name as 'Color Name', c.rgb from sets s
inner join inventories inv
on s.set_num = inv.set_num
inner join inventory_parts inp
on inv.id = inp.inventory_id
inner join colors c
on c.id = inp.color_id
where s.theme_id = 158
and inp.is_spare = 't'
order by s.set_num, s.num_parts desc;

-- Let's see which set has the most spare types
select s.name, count(inp.is_spare) as 'No of Spare types' from sets s 
inner join themes t 
on s.theme_id = t.id
inner join inventories i
on s.set_num = i.set_num
inner join inventory_parts inp
on i.id = inp.inventory_id
where s.theme_id = 158 and inp.is_spare = 't'
group by s.name
order by count(inp.is_spare) desc
