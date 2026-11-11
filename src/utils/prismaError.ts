import { Prisma } from "@prisma/client";

export function handlePrismaError(err: unknown) {
  if (err instanceof Prisma.PrismaClientKnownRequestError) {
    if (err.code === 'P2002') {
      return { status: 409, message: 'This data already exists'};
    }
    if (err.code === 'P2025') {
      return { status: 404, message: 'Not found'};
    }
  }
    return { status: 500, message: 'Internal server error'};
}