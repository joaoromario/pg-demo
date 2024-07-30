import { Router } from "express";
import { router as projectsRouter } from "./projects.router";

export const apiRouter = Router();

const ROUTER = [{ url: "/projects", router: projectsRouter }];

ROUTER.forEach(({ url, router }) => {
  apiRouter.use(url, router);
});
// This block of code iterates over the ROUTER array using the forEach method. For each element, it extracts the url and router properties using destructuring.
// apiRouter.use(url, router);: This line registers the router for the specified URL path. When a request is made to a path starting with "/projects", it will be handled by the projectsRouter router. This means that the projectsRouter will be responsible for defining the sub-routes and handling the logic for any routes starting with /projects.
