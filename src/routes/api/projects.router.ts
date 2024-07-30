import { Request, Response, Router } from "express";
import { pool } from "../../db";
import { router as tasksRouter } from "./tasks.router";

type Project = {
  id: number;
  title: string;
  description: string | null;
  created_at: Date;
};

export const router = Router();

// Registers tasksRouter under the route /:projectId/tasks. This means that any routes defined in tasksRouter will be prefixed with a project ID. For example, if tasksRouter has a route for getting tasks, the full route might be /projects/:projectId/tasks.
router.use("/:projectId/tasks", tasksRouter);

// /api/v1/projects
// Handles GET requests to /api/v1/projects to fetch all projects from the database. It uses a SQL query to select all projects and sends the result as the response.
router.get("/", async (req: Request, res: Response) => {
  const data = await pool.query<Project>(`SELECT * FROM projects;`);

  res.json(data.rows);
});

//!get project by id
//Handles GET requests to /api/v1/projects/:id to fetch a project by its ID. It retrieves the project ID from the URL, queries the database, and sends the project as the response. If no project is found, it sends a 404 error.
router.get("/:id", async (req: Request, res: Response) => {
  const { id } = req.params;

  const data = await pool.query<Project>(
    `SELECT * FROM projects WHERE id = $1;`,
    [id]
  );

  const project = data.rows[0];

  if (!project) {
    res
      .status(404)
      .json({ error: 404, message: `Record with id ${id} does not exist.` });
  }

  res.send(project);
});

//!Create new project
//Handles POST requests to /api/v1/projects to create a new project. It extracts title and description from the request body, inserts a new project into the database, and returns the newly created project.
router.post("/", async (req: Request, res: Response) => {
  const { title, description } = req.body;

  const data = await pool.query(
    `
    INSERT INTO projects (title, description) VALUES ($1, $2) RETURNING *;  
  `,
    [title, description]
  );

  res.send(data.rows[0]);
});

//!Update an existing project
//Handles PUT requests to /api/v1/projects/:id to update an existing project by its ID. It checks if the project exists, updates the project's title and description, and returns the updated project.
router.put("/:id", async (req: Request, res: Response) => {
  const { id } = req.params;

  const data = await pool.query<Project>(
    `SELECT * FROM projects WHERE id = $1;`,
    [id]
  );

  const project = data.rows[0];

  if (!project) {
    res
      .status(404)
      .json({ error: 404, message: `Record with id ${id} does not exist.` });
  }

  const { title, description } = req.body;

  const updated = await pool.query<Project>(
    `
      UPDATE projects 
      SET title = $1, description = $2
      WHERE id = $3
      RETURNING *
    `,
    [title, description, id]
  );

  res.send(updated.rows[0]);
});

//!Delete a project
//Handles DELETE requests to /api/v1/projects/:id to delete a project by its ID. It checks if the project exists and then deletes it from the database, returning the deleted project as a confirmation.
router.delete("/:id", async (req: Request, res: Response) => {
  const { id } = req.params;

  const data = await pool.query<Project>(
    `SELECT * FROM projects WHERE id = $1;`,
    [id]
  );

  const project = data.rows[0];

  if (!project) {
    res
      .status(404)
      .json({ error: 404, message: `Record with id ${id} does not exist.` });
  }

  const deleted = await pool.query(
    "DELETE FROM projects WHERE id = $1 RETURNING *",
    [id]
  );

  res.json(deleted.rows[0]);
});
