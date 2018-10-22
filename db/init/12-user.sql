/*Connect to database*/
\connect mobydq



/*Create table user*/
CREATE TABLE base.user (
    id SERIAL PRIMARY KEY
  , email TEXT NOT NULL UNIQUE
  , oauth_type TEXT NOT NULL
  , access_token TEXT NOT NULL
  , refresh_token INTEGER
  , expiry_date TIMESTAMP NOT NULL
  , flag_active BOOLEAN DEFAULT TRUE
  , created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
  , updated_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

COMMENT ON TABLE base.user IS
'Users information and their authentication methods.';

CREATE TRIGGER user_updated_date BEFORE UPDATE
ON base.user FOR EACH ROW EXECUTE PROCEDURE
base.update_updated_date_column();



/*Create function to create user role*/
CREATE OR REPLACE FUNCTION base.create_user_role()
RETURNS TRIGGER AS $$
DECLARE
    user TEXT := 'user_' || NEW.id;
BEGIN
    EXECUTE 'CREATE USER ' || user || ' WITH PASSWORD ''' || user || '''';
    RETURN NEW;
END;
$$ language plpgsql;

COMMENT ON FUNCTION base.create_user_role IS
'Function used to automatically create a role for a user.';

CREATE TRIGGER user_create_user_role AFTER INSERT
ON base.user FOR EACH ROW EXECUTE PROCEDURE
base.create_user_role();
