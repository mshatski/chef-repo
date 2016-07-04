CREATE TABLE customers(
  id CHAR (32) NOT NULL,
  PRIMARY KEY(id),
  first_name VARCHAR(32),
  last_name VARCHAR(32),
  email VARCHAR(64)
);

INSERT INTO customers ( id, first_name, last_name, email ) VALUES ( uuid(), 'Mag', 'Tenno', 'mag.tenno@warframe.com' );
INSERT INTO customers ( id, first_name, last_name, email ) VALUES ( uuid(), 'Thrall', 'SonOfDurotan', 'thrall.sonofdurotan@wow.com' );