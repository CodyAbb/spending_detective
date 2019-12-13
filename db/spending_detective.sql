DROP TABLE transactions;
DROP TABLE merchants;
DROP TABLE tags;

CREATE TABLE tags (
  id SERIAL PRIMARY KEY,
  type VARCHAR (255),
  description VARCHAR(255)
);

CREATE TABLE merchants(
  id SERIAL PRIMARY KEY,
  name VARCHAR(255),
  active BOOLEAN
);

CREATE TABLE transactions(
  id SERIAL PRIMARY KEY,
  transaction_date INT,
  month VARCHAR(255),
  tag_id INT REFERENCES tags(id),
  merchant_id INT REFERENCES merchants(id)
);
