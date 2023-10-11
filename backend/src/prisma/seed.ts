import prisma from './prisma';

const performSeed = async () => {
  await prisma.user.create({
    data: {
      firstName: 'Joe',
      lastName: 'Mama',
      email: 'joe.mama@gmail.com'
    }
  });

  await prisma.user.create({
    data: {
      firstName: 'Mark',
      lastName: 'Fontenot',
      email: 'cookie.eater@gmail.com'
    }
  });

  await prisma.exercise.create({
    data: {
      name: 'Stretch Ankle',
      tags: ['FLEXIBILITY', 'MOBILITY', 'STABILITY'],
      link: 'https://www.youtube.com/watch?v=dQw4w9WgXcQ'
    }
  });

  await prisma.exercise.create({
    data: {
      name: 'Complain to the neighbors',
      tags: ['DISCOMFORT_RESOLUTION', 'PAIN_RELIEF', 'STRENGTH'],
      link: 'https://www.youtube.com/watch?v=dQw4w9WgXcQ'
    }
  });

  await prisma.exercise.create({
    data: {
      name: 'Joe Mama',
      link: 'https://www.youtube.com/watch?v=dQw4w9WgXcQ'
    }
  });
};

performSeed()
  .catch((e) => {
    console.error(e);
    process.exit(1);
  })
  .finally(async () => {
    await prisma.$disconnect();
  });
