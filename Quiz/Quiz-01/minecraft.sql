create DATABASE minecraft;

use minecraft;

CREATE Table Player (
    player_id VARCHAR(10) PRIMARY KEY,
    player_name VARCHAR(50),
    player_email VARCHAR(100)
);

CREATE Table Villager (
    villager_id VARCHAR(10) PRIMARY KEY,
    villager_profession VARCHAR(50),
    biome VARCHAR(50)
);

CREATE Table Items (
    item_id VARCHAR(10) primary KEY,
    item_name VARCHAR(50),
    category_list VARCHAR(50),
    unit_emerald_price int
);

CREATE Table Trade_Session (
    transaction_id VARCHAR(10) PRIMARY KEY,
    transaction_date date,
    player_id VARCHAR(10),
    villager_id VARCHAR(10),
    Foreign Key (player_id) REFERENCES Player(player_id),
    Foreign Key (villager_id) REFERENCES Villager(villager_id)
);

CREATE Table Transaction_Detail (
    transaction_id VARCHAR(10),
    item_id VARCHAR(10),
    qty_list int,
    PRIMARY KEY(transaction_id, item_id),
    Foreign Key (transaction_id) REFERENCES Trade_Session(transaction_id),
    Foreign Key (item_id) REFERENCES Items(item_id)
);

INSERT INTO Player VALUES
('PL001', 'Technoblade', 'technoblade@mine.com'),
('PL002', 'Ph1lza', 'phil@mine.com'),
('PL003', 'Evbo', 'evbo@notmine.com');

INSERT INTO Villager VALUES
('VL101', 'Librarian', 'Plains'),
('VL102', 'Armorer', 'Taiga'),
('VL103', 'Fletcher', 'Desert');

INSERT INTO Items VALUES
('M001', 'Enchanted Book', 'Tool', 15),
('M002', 'Emerald Block', 'Material', 9),
('M003', 'Diamond Chestplate', 'Armor', 18),
('M004', 'Golden Apple', 'Consumable', 3),
('M005', 'Crossbow', 'Weapon', 12),
('M006', 'Spectral Arrow', 'Ammo', 1);

INSERT INTO Trade_Session VALUES
('TRX001', '2026-03-01', 'PL001', 'VL101'),
('TRX002', '2026-03-02', 'PL002', 'VL102'),
('TRX003', '2026-03-03', 'PL001', 'VL101'),
('TRX004', '2026-03-04', 'PL003', 'VL103');

INSERT INTO Transaction_Detail VALUES
('TRX001', 'M001', 2),
('TRX001', 'M002', 1),
('TRX002', 'M003', 1),
('TRX003', 'M001', 1),
('TRX003', 'M004', 5),
('TRX004', 'M005', 1),
('TRX004', 'M006', 64);

--- alter table kolom player_rank di table player ---
ALTER Table
player ADD player_rank VARCHAR(20) DEFAULT 'Member';
describe player;

--- update player rank set pig+++ where playerid = pl001 ---
UPDATE
player set player_rank = 'PIG+++'
WHERE player_id = 'PL001';
select player_rank from player;

--- show biome jadi badlands where VL103 ---
update
villager set biome = 'Badlands'
where villager_id = 'VL103';
select biome from villager;

--- show playerid where domain email = mine.com ---
SELECT player_id as Player_ID, 
CONCAT(
    upper(player_name),' ', "(mine.com)"
) as Player_Info
from player
where player_email LIKE '%@mine.com';

--- show transID, tgl trans format dd m y ---
SELECT transaction_id as `ID Transaksi`,
DATE_FORMAT(transaction_date, '%d %M %Y') as `Tanggal Transaksi`
from trade_session
order by transaction_id desc;

--- show transid, playername, villproff, total emerald each trans ---
SELECT t.transaction_id as `ID Transaksi`,
p.player_name as `Player Name`,
v.villager_profession as `profesi Villager`,
sum(d.qty_list * i.unit_emerald_price) as `Total Emeralds`
FROM trade_session t
join player p on t.player_id = p.player_id
join villager v on t.villager_id = v.villager_id
join transaction_detail d on t.transaction_id = d.transaction_id
join items i on d.item_id = i.item_id
GROUP BY t.transaction_id
ORDER BY t.transaction_id;

--- show villid, villprof,biome,total emeralds ---
SELECT v.villager_id as `Villager Id`,
v.villager_profession as Profession,
v.biome as `Biome Location`,
sum(d.qty_list * i.unit_emerald_price) as `Total Emeralds`
FROM villager v 
join trade_session t on v.villager_id = t.villager_id
join transaction_detail d on t.transaction_id = d.transaction_id
join items i on d.item_id = i.item_id
group by v.villager_id
having `Total Emeralds` > 20;

--- show player_name, item_name, qty_list, unitemeprice where transaction id = librarion and item_price > avg---
SELECT
p.player_name as `Player Name`,
i.item_name as `Item Name`,
d.qty_list as Quantity,
i.unit_emerald_price as `Emerald Price`
from trade_session t
join player p on t.player_id = p.player_id
join villager v on t.villager_id = v.villager_id
join transaction_detail d on t.transaction_id = d.transaction_id
join items i on d.item_id = i.item_id
where v.villager_profession = 'Librarian'
and i.unit_emerald_price > (Select avg(unit_emerald_price) from items);





