import DataService from '../services/data.servics';
import DataTypeService from '../services/dateType.services';
import ExerciseService from '../services/exercie.services';
import UserService from '../services/user.services';
import prisma from './prisma';

const performSeed = async () => {
  const joeMama = await UserService.createUser('Joe', 'Mama', 'mama.joe@northeastern.edu');

  const mark = await UserService.createUser('Mark', 'Fontenot', 'cookie.eater@gmail.com');

  const john = await UserService.createUser('John', 'Doe', 'doe.j@gmail.com');

  const jane = await UserService.createUser('Jane', 'Doe', 'doe.ja@gmail.com');

  await DataTypeService.createDataType('STEPS');

  await DataTypeService.createDataType('PAIN');

  await DataTypeService.createDataType('DISCOMFORT');

  await DataTypeService.createDataType('HEART_RATE');

  await DataService.createData('STEPS', 1000, joeMama.id);

  await DataService.createData('STEPS', 2250, joeMama.id);

  await DataService.createData('STEPS', 4160, joeMama.id);

  await DataService.createData('STEPS', 3325, joeMama.id);

  await DataService.createData('STEPS', 2000, joeMama.id);

  await DataService.createData('STEPS', 4237, joeMama.id);

  await DataService.createData('HEART_RATE', 100, joeMama.id);

  await DataService.createData('HEART_RATE', 110, joeMama.id);

  await DataService.createData('HEART_RATE', 120, joeMama.id);

  await DataService.createData('HEART_RATE', 115, joeMama.id);

  await DataService.createData('HEART_RATE', 105, joeMama.id);

  await DataService.createData('HEART_RATE', 100, joeMama.id);

  await DataService.createData('PAIN', 2, joeMama.id);

  await DataService.createData('PAIN', 3, joeMama.id);

  await DataService.createData('PAIN', 3, joeMama.id);

  await DataService.createData('PAIN', 5, joeMama.id);

  await DataService.createData('PAIN', 4, joeMama.id);

  await DataService.createData('PAIN', 1, joeMama.id);

  await DataService.createData('DISCOMFORT', 2, joeMama.id);

  await DataService.createData('DISCOMFORT', 3, joeMama.id);

  await DataService.createData('DISCOMFORT', 3, joeMama.id);

  await ExerciseService.createExercise(
    'Stretch Ankle',
    ['FLEXIBILITY', 'MOBILITY', 'STABILITY'],
    'https://www.youtube.com/watch?v=dQw4w9WgXcQ'
  );

  await ExerciseService.createExercise(
    'Compain to the neighbors',
    ['DISCOMFORT_RESOLUTION', 'PAIN_RELIEF', 'STRENGTH', 'STABILITY'],
    'https://www.youtube.com/watch?v=dQw4w9WgXcQ'
  );

  await ExerciseService.createExercise(
    'Calf Raises',
    ['STRENGTH', 'STABILITY'],
    'https://www.youtube.com/watch?v=dQw4w9WgXcQ'
  );

  await ExerciseService.createExercise(
    'Toe Raises',
    ['STRENGTH', 'STABILITY'],
    'https://www.youtube.com/watch?v=dQw4w9WgXcQ'
  );

  await ExerciseService.createExercise(
    'Jumping Jacks',
    ['STRENGTH', 'STABILITY'],
    'https://www.youtube.com/watch?v=dQw4w9WgXcQ'
  );
};

performSeed()
  .catch((e) => {
    console.error(e);
    process.exit(1);
  })
  .finally(async () => {
    await prisma.$disconnect();
  });
