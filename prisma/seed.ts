import { prisma } from '../src/prisma'

async function main() {
  const user = await prisma.app_users.upsert({
    where: { id: 1 },
    update: {},
    create: { id: 1, name: 'Amina' },
  })

  const tag = await prisma.tags.upsert({
    where: { name: 'Study' },
    update: {},
    create: { name: 'Study' },
  })

  const task = await prisma.tasks.create({
    data: {
      userId: user.id,
      title: 'Learn Prisma',
      completed: false,
    },
  })

  await prisma.task_tags.create({
    data: { task_id: task.id, tag_id: tag.id },
  })

  console.log('Seed has finished')
}

main()
  .catch(console.error)
  .finally(() => prisma.$disconnect())
