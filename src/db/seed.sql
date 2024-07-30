-- !Inserting a new project
-- INSERT INTO projects (title): This part specifies the table (projects) and the column (title) into which you want to insert a new value.
-- VALUES ('My First Project'): This specifies the value that will be inserted into the title column of the new record in the projects table. In this case, a new project with the title "My First Project" is being created.
INSERT INTO
  projects (title)
VALUES
  ('My First Project');

-- !Inserting a new task
-- INSERT INTO projects (title): This part specifies the table (projects) and the column (title) into which you want to insert a new value.
-- VALUES ('My First Project'): This specifies the value that will be inserted into the title column of the new record in the projects table. In this case, a new project with the title "My First Project" is being created.
INSERT INTO
  tasks (project_id, title)
VALUES
  (1, 'My First Task');

-- !Context and Relationships
-- In relational databases, tables often have relationships with each other. In this case:
-- The projects table likely has a primary key column (usually named id), which uniquely identifies each project.
-- The tasks table may have a foreign key column (project_id) that references the primary key in the projects table, establishing a relationship between tasks and projects.
-- By inserting a record into the tasks table with project_id = 1, you're associating the task "My First Task" with the project whose ID is 1 ("My First Project"). This is a common way to link related data across tables in a relational database, ensuring data integrity and enabling complex queries based on these relationships.