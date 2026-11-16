export interface ToDo {
  id: number,
  title: string,
  completed: boolean
}

declare global {
  namespace Express {
    interface Request {
      user?: { id: number; role: string };
    }
  }
}

export {};