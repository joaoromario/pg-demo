-- !Dropping tables if they exist
-- DROP TABLE IF EXISTS tasks CASCADE;: This command deletes the tasks table from the database if it exists. The IF EXISTS clause prevents an error if the table doesn't exist. The CASCADE option ensures that if there are any dependent objects, such as foreign key constraints, they are also removed.
-- DROP TABLE IF EXISTS projects CASCADE;: Similarly, this command deletes the projects table if it exists, along with any dependent objects due to the CASCADE option.

DROP TABLE IF EXISTS tasks CASCADE;
DROP TABLE IF EXISTS projects CASCADE;

-- !Creating projects table
-- CREATE TABLE projects: This command creates a new table named projects.
-- id SERIAL PRIMARY KEY: Defines a column named id that uses the SERIAL data type. SERIAL automatically generates a unique integer value for each row, starting from 1. The PRIMARY KEY constraint ensures that each value in the id column is unique and not null, serving as the table's unique identifier.
-- title VARCHAR(100) NOT NULL: Defines a column named title with a variable character type that can hold up to 100 characters. The NOT NULL constraint ensures that this column must have a value for every row, meaning a project must always have a title.
-- description TEXT: Defines a column named description that can hold text data of variable length. This column can be null, meaning it's optional.
-- created_at TIMESTAMP DEFAULT NOW(): Defines a column named created_at with a timestamp data type. The DEFAULT NOW() clause automatically sets the current date and time when a new row is inserted, indicating when the project was created.
CREATE TABLE projects (
  id SERIAL PRIMARY KEY,
  title VARCHAR(100) NOT NULL,
  description TEXT,
  created_at TIMESTAMP DEFAULT NOW()
);

-- !Creating tasks table
-- CREATE TABLE tasks: This command creates a new table named tasks.
-- id SERIAL PRIMARY KEY: Defines an id column with the SERIAL data type and PRIMARY KEY constraint, similar to the projects table.
-- project_id INTEGER REFERENCES projects(id) ON DELETE CASCADE:
-- project_id: Defines a column for storing integer values.
-- REFERENCES projects(id): This sets up a foreign key constraint, linking project_id to the id column in the projects table. This establishes a relationship between a task and its associated project.
-- ON DELETE CASCADE: This specifies that if a project is deleted from the projects table, all tasks associated with that project (i.e., having the same project_id) should also be deleted automatically. This ensures referential integrity between the tables.
-- title VARCHAR(100) NOT NULL: Similar to the projects table, this column holds the title of the task and must have a value.
-- description TEXT: A column for additional details about the task, which can be null.
-- start_time TIMESTAMP: A column for storing the start time of the task.
-- end_time TIMESTAMP: A column for storing the end time of the task.
-- created_at TIMESTAMP DEFAULT NOW(): Automatically sets the creation timestamp of the task, similar to the projects table.
CREATE TABLE tasks (
  id SERIAL PRIMARY KEY,
  project_id INTEGER REFERENCES projects(id) ON DELETE CASCADE,
  title VARCHAR(100) NOT NULL,
  description TEXT,
  start_time TIMESTAMP,
  end_time TIMESTAMP,
  created_at TIMESTAMP DEFAULT NOW()
);