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
};

performSeed()
  .catch((e) => {
    console.error(e);
    process.exit(1);
  })
  .finally(async () => {
    await prisma.$disconnect();
  });
