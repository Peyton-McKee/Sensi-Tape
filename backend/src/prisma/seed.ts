import DataService from '../services/data.services';
import DataTypeService from '../services/dateType.services';
import ExerciseService from '../services/recommendation.services';
import UserService from '../services/user.services';
import prisma from './prisma';

const performSeed = async () => {
  const joeMama = await UserService.createUser('Joe', 'Mama', 'mama.joe@northeastern.edu');

  const settings = await UserService.upsertUserSettings(joeMama.id, 72, 180, 'Male', 21, 'SEDENTARY');

  const mark = await UserService.createUser('Mark', 'Fontenot', 'cookie.eater@gmail.com');

  const john = await UserService.createUser('John', 'Doe', 'doe.j@gmail.com');

  const jane = await UserService.createUser('Jane', 'Doe', 'doe.ja@gmail.com');

  await DataTypeService.createDataType('FRONT_ANKLE_TEMP');

  await DataService.createData('FRONT_ANKLE_TEMP', 98.8, joeMama.id);
  await DataService.createData('FRONT_ANKLE_TEMP', 99, joeMama.id);
  await DataService.createData('FRONT_ANKLE_TEMP', 100, joeMama.id);
  await DataService.createData('FRONT_ANKLE_TEMP', 99, joeMama.id);
  await DataService.createData('FRONT_ANKLE_TEMP', 98.8, joeMama.id);
  await DataService.createData('FRONT_ANKLE_TEMP', 99, joeMama.id);
  await DataService.createData('FRONT_ANKLE_TEMP', 100, joeMama.id);
  await DataService.createData('FRONT_ANKLE_TEMP', 101, joeMama.id);
  await DataService.createData('FRONT_ANKLE_TEMP', 102, joeMama.id);
  await DataService.createData('FRONT_ANKLE_TEMP', 103, joeMama.id);
  await DataService.createData('FRONT_ANKLE_TEMP', 100, joeMama.id);
  await DataService.createData('FRONT_ANKLE_TEMP', 100, joeMama.id);
  await DataService.createData('FRONT_ANKLE_TEMP', 100, joeMama.id);

  await DataTypeService.createDataType('RIGHT_SIDE_ANKLE_TEMP');

  await DataService.createData('RIGHT_SIDE_ANKLE_TEMP', 98, joeMama.id);
  await DataService.createData('RIGHT_SIDE_ANKLE_TEMP', 99, joeMama.id);
  await DataService.createData('RIGHT_SIDE_ANKLE_TEMP', 100, joeMama.id);
  await DataService.createData('RIGHT_SIDE_ANKLE_TEMP', 99, joeMama.id);
  await DataService.createData('RIGHT_SIDE_ANKLE_TEMP', 98, joeMama.id);
  await DataService.createData('RIGHT_SIDE_ANKLE_TEMP', 99, joeMama.id);
  await DataService.createData('RIGHT_SIDE_ANKLE_TEMP', 97, joeMama.id);
  await DataService.createData('RIGHT_SIDE_ANKLE_TEMP', 97, joeMama.id);
  await DataService.createData('RIGHT_SIDE_ANKLE_TEMP', 104, joeMama.id);
  await DataService.createData('RIGHT_SIDE_ANKLE_TEMP', 105, joeMama.id);
  await DataService.createData('RIGHT_SIDE_ANKLE_TEMP', 106, joeMama.id);
  await DataService.createData('RIGHT_SIDE_ANKLE_TEMP', 100, joeMama.id);

  await DataTypeService.createDataType('LEFT_SIDE_ANKLE_TEMP');

  await DataService.createData('LEFT_SIDE_ANKLE_TEMP', 98, joeMama.id);
  await DataService.createData('LEFT_SIDE_ANKLE_TEMP', 100, joeMama.id);
  await DataService.createData('LEFT_SIDE_ANKLE_TEMP', 105, joeMama.id);
  await DataService.createData('LEFT_SIDE_ANKLE_TEMP', 97, joeMama.id);
  await DataService.createData('LEFT_SIDE_ANKLE_TEMP', 98, joeMama.id);
  await DataService.createData('LEFT_SIDE_ANKLE_TEMP', 100, joeMama.id);
  await DataService.createData('LEFT_SIDE_ANKLE_TEMP', 97, joeMama.id);
  await DataService.createData('LEFT_SIDE_ANKLE_TEMP', 97, joeMama.id);
  await DataService.createData('LEFT_SIDE_ANKLE_TEMP', 104, joeMama.id);

  await ExerciseService.createRecommendation(
    'Stretch Ankle',
    ['FLEXIBILITY', 'MOBILITY', 'STABILITY'],
    'https://www.youtube.com/watch?v=dQw4w9WgXcQ'
  );

  await ExerciseService.createRecommendation(
    'Compain to the neighbors',
    ['DISCOMFORT_RESOLUTION', 'PAIN_RELIEF', 'STRENGTH', 'STABILITY'],
    'https://www.youtube.com/watch?v=dQw4w9WgXcQ'
  );

  await ExerciseService.createRecommendation(
    'Calf Raises',
    ['STRENGTH', 'STABILITY'],
    'https://www.youtube.com/watch?v=dQw4w9WgXcQ'
  );

  await ExerciseService.createRecommendation(
    'Toe Raises',
    ['STRENGTH', 'STABILITY'],
    'https://www.youtube.com/watch?v=dQw4w9WgXcQ'
  );

  await ExerciseService.createRecommendation(
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
