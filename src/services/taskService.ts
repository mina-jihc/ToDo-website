import { compile, string } from 'zod';
import { prisma } from '../prisma';
import { handlePrismaError } from '../utils/prismaError';
import { createTaskWithTag } from './tasks';

export const taskService = {
  async getAll(page = 1, perPage = 10) {
    return prisma.tasks.findMany({
      skip: (page - 1) * perPage,
      take: perPage,
      orderBy: { id: 'desc' },
      include: { appUser: true },
    })
  },

async getById(id: number) {
    return prisma.tasks.findUnique({
      where: { id },
      include: { appUser: true, taskTags: { include: { tag: true } } },
    })
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
  id: number,
  data: { title?: string | undefined; completed?: boolean | undefined },
) {
  return prisma.tasks.update({
    where: { id },
    data: {
      ...(data.title !== undefined ? { title: data.title } : {}),
      ...(data.completed !== undefined ? { completed: data.completed } : {}),
    },
  })
},

 async remove(id: number) {
    return prisma.tasks.delete({ where: { id } })
  },

  async count() {
    return prisma.tasks.count()
  },
}