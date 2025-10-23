-- 初始化 games 表数据
-- 执行前确认：\c gamevault

TRUNCATE TABLE games RESTART IDENTITY CASCADE;

INSERT INTO games (description, developer, discount_price, genre, image_url, is_active, platform, price, release_date, title) VALUES
-- 1–5 RPG
('An open-world action RPG', 'FromSoftware', 49.99, 'RPG', '/uploads/games/game_1.jpg', TRUE, 'PC', 59.99, '2022-10-20', 'Elden Ring'),
('Fantasy adventure in a vast open world', 'Mihoyo', 111.00, 'RPG', '/uploads/games/game_2.jpg', TRUE, 'PC', 222.00, '2020-05-21', 'Genshin Impact'),
('Classic JRPG with turn-based combat', 'Square Enix', 39.99, 'RPG', '/uploads/games/game_3.jpg', TRUE, 'Switch', 59.99, '2019-09-27', 'Dragon Quest XI'),
('Dark fantasy with punishing combat', 'FromSoftware', 29.99, 'RPG', '/uploads/games/game_4.jpg', TRUE, 'PC', 49.99, '2016-03-24', 'Dark Souls III'),
('Tactical role-playing saga', 'Intelligent Systems', 34.99, 'RPG', '/uploads/games/game_5.jpg', TRUE, 'Switch', 59.99, '2019-07-26', 'Fire Emblem: Three Houses'),

-- 6–10 Action / Adventure
('Cyberpunk action thriller with rich storylines', 'CD Projekt Red', 39.99, 'Action', '/uploads/games/game_6.jpg', TRUE, 'PC', 59.99, '2020-12-10', 'Cyberpunk 2077'),
('Classic action-adventure with updated visuals', 'Capcom', 19.99, 'Action', '/uploads/games/game_7.jpg', TRUE, 'PC', 29.99, '2019-01-25', 'Resident Evil 2 Remake'),
('Superhero open-world experience', 'Insomniac Games', 44.99, 'Action', '/uploads/games/game_8.jpg', TRUE, 'PlayStation', 69.99, '2023-10-20', 'Spider-Man 2'),
('Survival adventure in infected world', 'Naughty Dog', 34.99, 'Adventure', '/uploads/games/game_9.jpg', TRUE, 'PC', 49.99, '2023-03-28', 'The Last of Us Part I'),
('Post-apocalyptic open-world shooter', 'Guerrilla Games', 29.99, 'Action', '/uploads/games/game_10.jpg', TRUE, 'PC', 49.99, '2020-08-07', 'Horizon Zero Dawn'),

-- 11–15 Shooter
('Fast-paced FPS with tactical gameplay', 'Infinity Ward', 44.99, 'Shooter', '/uploads/games/game_11.jpg', TRUE, 'PC', 59.99, '2022-11-10', 'Call of Duty: Modern Warfare II'),
('Sci-fi shooter set in deep space', 'Bungie', 29.99, 'Shooter', '/uploads/games/game_12.jpg', TRUE, 'PC', 49.99, '2017-09-06', 'Destiny 2'),
('Hero-based competitive shooter', 'Blizzard', 0.00, 'Shooter', '/uploads/games/game_13.jpg', TRUE, 'PC', 0.00, '2022-10-04', 'Overwatch 2'),
('Battle royale tactical shooter', 'Respawn Entertainment', 0.00, 'Shooter', '/uploads/games/game_14.jpg', TRUE, 'PC', 0.00, '2019-02-04', 'Apex Legends'),
('Terrorist vs counter-terrorist FPS', 'Valve', 0.00, 'Shooter', '/uploads/games/game_15.jpg', TRUE, 'PC', 0.00, '2012-08-21', 'CS:GO'),

-- 16–20 Strategy / Simulation
('Fantasy strategy with global conquest', 'Creative Assembly', 39.99, 'Strategy', '/uploads/games/game_16.jpg', TRUE, 'PC', 59.99, '2022-02-17', 'Total War: Warhammer III'),
('Civilization-building simulation', 'Firaxis Games', 24.99, 'Strategy', '/uploads/games/game_17.jpg', TRUE, 'PC', 49.99, '2016-10-21', 'Sid Meier''s Civilization VI'),
('City management survival', '11 Bit Studios', 19.99, 'Simulation', '/uploads/games/game_18.jpg', TRUE, 'PC', 29.99, '2018-04-24', 'Frostpunk'),
('Life simulation sandbox', 'Maxis', 19.99, 'Simulation', '/uploads/games/game_19.jpg', TRUE, 'PC', 39.99, '2014-09-02', 'The Sims 4'),
('Interplanetary space exploration sim', 'Squad', 24.99, 'Simulation', '/uploads/games/game_20.jpg', TRUE, 'PC', 49.99, '2015-04-27', 'Kerbal Space Program'),

-- 21–25 Indie / Platform / Puzzle
('Minimalist adventure puzzle', 'Playdead', 4.99, 'Puzzle', '/uploads/games/game_21.jpg', TRUE, 'PC', 9.99, '2016-06-29', 'INSIDE'),
('Atmospheric platformer', 'Team Cherry', 7.99, 'Platform', '/uploads/games/game_22.jpg', TRUE, 'PC', 14.99, '2017-02-24', 'Hollow Knight'),
('Creative 2D crafting adventure', 'Re-Logic', 4.99, 'Sandbox', '/uploads/games/game_23.jpg', TRUE, 'PC', 9.99, '2011-05-16', 'Terraria'),
('Rhythm-based platformer', 'RobTop Games', 0.99, 'Arcade', '/uploads/games/game_24.jpg', TRUE, 'Mobile', 1.99, '2013-08-13', 'Geometry Dash'),
('Mystery-solving visual novel', 'Spike Chunsoft', 14.99, 'Adventure', '/uploads/games/game_25.jpg', TRUE, 'PC', 29.99, '2020-11-13', 'AI: The Somnium Files'),

-- 26–30 Sports / Racing / Sandbox
('Realistic racing simulator', 'Polyphony Digital', 39.99, 'Racing', '/uploads/games/game_26.jpg', TRUE, 'PlayStation', 59.99, '2022-03-04', 'Gran Turismo 7'),
('Open-world racing game', 'Playground Games', 29.99, 'Racing', '/uploads/games/game_27.jpg', TRUE, 'PC', 59.99, '2021-11-09', 'Forza Horizon 5'),
('Soccer sports simulator', 'EA Sports', 34.99, 'Sports', '/uploads/games/game_28.jpg', TRUE, 'PC', 69.99, '2023-09-29', 'EA Sports FC 24'),
('Basketball simulation', '2K Games', 29.99, 'Sports', '/uploads/games/game_29.jpg', TRUE, 'PC', 59.99, '2023-09-08', 'NBA 2K24'),
('Sandbox creative building game', 'Mojang', 9.99, 'Sandbox', '/uploads/games/game_30.jpg', TRUE, 'PC', 19.99, '2011-11-18', 'Minecraft');

-- 验证
SELECT COUNT(*) AS inserted_games FROM games;
