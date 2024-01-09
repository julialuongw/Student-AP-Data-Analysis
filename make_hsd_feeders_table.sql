# An implementation of the mapping of High School Districts to Elementary School Districts as determined by here https://docs.google.com/spreadsheets/d/1xOgT5p5WWf5xN3Kq5VJktrladZcjLTgQLDVuZFo0x1M/edit?usp=sharing
# Intended use: as a lookup table

CREATE TABLE Hsd_feeders (
    HS_District VARCHAR(256),
    ES_Districts_List VARCHAR(256),
    PRIMARY KEY(HS_District)
);

INSERT INTO Hsd_feeders
VALUES ('Escondido Union High', 'Escondido Union,San Pasqual Union Elementary'),
('Fallbrook Union High', 'Fallbrook Union Elementary'),
('Grossmont Union High', 'Alpine Union Elementary,Cajon Valley Union,La Mesa-Spring Valley,Lemon Grove,Santee'),
('Sweetwater Union High', 'Chula Vista Elementary,National Elementary,San Ysidro Elementary,South Bay Union'),
('San Dieguito Union High', 'Cardiff Elementary,Del Mar Union Elementary,Encinitas Union Elementary,Rancho Santa Fe Elementary,Solana Beach Elementary'),
('Julian Union High', 'Julian Union Elementary' );