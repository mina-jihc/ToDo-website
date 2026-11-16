import { prisma } from '../prisma';
import { AppError } from '../utils/AppError';

export const taskService = {
  async getAll(userId: number, role: string, page = 1, perPage = 10) {
    return prisma.tasks.findMany({
      where: role === "admin" ? {} : { userId },
      skip: (page - 1) * perPage,
      take: perPage,
      orderBy: { id: 'desc' },
      include: { appUser: { select: { id: true, name: true, email: true, role: true },} },
    })
  },

async getById(id: number, userId: number) {
    const task = await prisma.tasks.findFirst({
      where: { id, userId },
      include: { appUser: { select: { id: true, name: true, email: true, role: true }}, taskTags: { include: { tag: true } } },
    })
    console.log(' RESULT:', task);
    if (!task) {
      console.log(' 404 LAQTYRADY');
    throw new AppError("Task not found", 404);
  }

  return task;
  },

async create(userId: number, title: string) {
    return await prisma.tasks.create({
      data: { userId, title, completed: false },
    })
}
,
async createWithTag(userId: number, title: string, tagId: number) { 
  return prisma.$transaction(async (tx) => {
    const task = await tx.tasks.create({
      data: { userId, title, completed: false },
    })
    await tx.task_tags.create({
      data: { task_id: task.id, tag_id: tagId },
    })
    return task;
  })
},
async createTag(name: string) {
  return prisma.tags.create({ data: { name } })
},

async update(
  id: number, userId: number,
  data: { title?: string | undefined; completed?: boolean | undefined },
) {
  const task = await prisma.tasks.findFirst({ where: { id, userId } });
  if (!task) throw new AppError('Task not found', 404);
  return prisma.tasks.update({
    where: { id },
    data: {
      ...(data.title !== undefined ? { title: data.title } : {}),
      ...(data.completed !== undefined ? { completed: data.completed } : {}),
    },
  })
},

 async remove(id: number) {
    const result = await prisma.tasks.deleteMany({ where: { id } });

    if (result.count === 0) {
      throw new AppError('Task not found', 404);
    }
    return result.count;
  },

  async count() {
    return prisma.tasks.count()
  },
}