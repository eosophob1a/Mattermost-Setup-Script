CREATE DATABASE mattermost;
CREATE USER mmuser WITH PASSWORD 'Password42!';
GRANT ALL PRIVILEGES ON DATABASE mattermost to mmuser;