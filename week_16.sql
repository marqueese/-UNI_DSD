--week 16 
\c dsd_w16

CREATE EXTENSION IF NOT EXISTS pgcrypto;

ALTER TABLE librarians ADD COLUMN encrypt_email BYTEA;

UPDATE librarians
SET encrypt_email = pgp_sym_encrypt(lib_email::text, 'my_secret_key');

CREATE OR REPLACE FUNCTION encrypt_email()
RETURNS TRIGGER AS $$
BEGIN
    NEW.encrypt_email = pgp_sym_encrypt(NEW.lib_email::text, 'my_secret_key');
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER before_insert_lib
BEFORE INSERT ON lib
FOR EACH ROW EXECUTE FUNCTION encrypt_email();

SELECT 
    lib_email as "Email",
    pgp_sym_decrypt(encrypt_email, 'my_secret_key') as "Encrypted email"
FROM librarians;

--question 2 

CREATE TABLE admins (
    lib_id INT PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    password TEXT NOT NULL,
    FOREIGN KEY lib_id REFERENCES librarians(lib_id)
    PRIMARY KEY(lib_id)
);

INSERT INTO admins 
VALUES
    (1, 'admin1',crypt('password123', gen_salt('bf'))) --crypt using blowfish


SELECT 
    username as "Username",
    password as "Password"
FROM admins 
WHERE password = crypt('password123', password); --in reality the first one would be a input password variable


--question 3 

CREATE TABLE secure_contacts (
    contact_id INT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    name_hash TEXT NOT NULL, 
    encrypted_email TEXT NOT NULL,  
    encrypted_phone TEXT NOT NULL 
);

-- Inserting two records into the secure_contacts table

--A digest is just the result of applying a hashing function (e.g., MD5() or SHA256()) to a string.

INSERT INTO secure_contacts (contact_id, name, name_hash, encrypted_email, encrypted_phone)
VALUES
    (1, 'John Doe', MD5('John Doe'), crypt('email', gen_salt('bf')), crypt('phone', gen_salt('bf'))),
    (2, 'Jane Smith', MD5('Jane Smith'), crypt('email', gen_salt('bf')), crypt('phone', gen_salt('bf')));


SELECT * FROM secure_contacts WHERE contact_id = 1;
