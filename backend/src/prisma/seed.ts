import DataService from '../services/data.services';
import DataTypeService from '../services/dateType.services';
import UserService from '../services/user.services';
import prisma from './prisma';

const performSeed = async () => {
  const golden = await UserService.createUser('Stephen', 'Golden', 'golden.s@northeastern.edu');

  const settings = await UserService.upsertUserSettings(golden.id, 72, 180, 'Male', 21, 'SEDENTARY');

  const mark = await UserService.createUser('Mark', 'Fontenot', 'cookie.eater@gmail.com');

  const john = await UserService.createUser('John', 'Doe', 'doe.j@gmail.com');

  const jane = await UserService.createUser('Jane', 'Doe', 'doe.ja@gmail.com');

  await DataTypeService.createDataType('FRONT_ANKLE_TEMP');

  await DataService.createData('FRONT_ANKLE_TEMP', 98.8, golden.id);
  await DataService.createData('FRONT_ANKLE_TEMP', 99, golden.id);
  await DataService.createData('FRONT_ANKLE_TEMP', 100, golden.id);
  await DataService.createData('FRONT_ANKLE_TEMP', 99, golden.id);
  await DataService.createData('FRONT_ANKLE_TEMP', 98.8, golden.id);
  await DataService.createData('FRONT_ANKLE_TEMP', 99, golden.id);
  await DataService.createData('FRONT_ANKLE_TEMP', 100, golden.id);
  await DataService.createData('FRONT_ANKLE_TEMP', 101, golden.id);
  await DataService.createData('FRONT_ANKLE_TEMP', 102, golden.id);
  await DataService.createData('FRONT_ANKLE_TEMP', 103, golden.id);
  await DataService.createData('FRONT_ANKLE_TEMP', 100, golden.id);
  await DataService.createData('FRONT_ANKLE_TEMP', 100, golden.id);
  await DataService.createData('FRONT_ANKLE_TEMP', 100, golden.id);

  await DataTypeService.createDataType('RIGHT_SIDE_ANKLE_TEMP');

  await DataService.createData('RIGHT_SIDE_ANKLE_TEMP', 98, golden.id);
  await DataService.createData('RIGHT_SIDE_ANKLE_TEMP', 99, golden.id);
  await DataService.createData('RIGHT_SIDE_ANKLE_TEMP', 100, golden.id);
  await DataService.createData('RIGHT_SIDE_ANKLE_TEMP', 99, golden.id);
  await DataService.createData('RIGHT_SIDE_ANKLE_TEMP', 98, golden.id);
  await DataService.createData('RIGHT_SIDE_ANKLE_TEMP', 99, golden.id);
  await DataService.createData('RIGHT_SIDE_ANKLE_TEMP', 97, golden.id);
  await DataService.createData('RIGHT_SIDE_ANKLE_TEMP', 97, golden.id);
  await DataService.createData('RIGHT_SIDE_ANKLE_TEMP', 104, golden.id);
  await DataService.createData('RIGHT_SIDE_ANKLE_TEMP', 105, golden.id);
  await DataService.createData('RIGHT_SIDE_ANKLE_TEMP', 106, golden.id);
  await DataService.createData('RIGHT_SIDE_ANKLE_TEMP', 100, golden.id);

  await DataTypeService.createDataType('LEFT_SIDE_ANKLE_TEMP');

  await DataService.createData('LEFT_SIDE_ANKLE_TEMP', 98, golden.id);
  await DataService.createData('LEFT_SIDE_ANKLE_TEMP', 100, golden.id);
  await DataService.createData('LEFT_SIDE_ANKLE_TEMP', 105, golden.id);
  await DataService.createData('LEFT_SIDE_ANKLE_TEMP', 97, golden.id);
  await DataService.createData('LEFT_SIDE_ANKLE_TEMP', 98, golden.id);
  await DataService.createData('LEFT_SIDE_ANKLE_TEMP', 100, golden.id);
  await DataService.createData('LEFT_SIDE_ANKLE_TEMP', 97, golden.id);
  await DataService.createData('LEFT_SIDE_ANKLE_TEMP', 97, golden.id);
  await DataService.createData('LEFT_SIDE_ANKLE_TEMP', 104, golden.id);
};

performSeed()
  .catch((e) => {
    console.error(e);
    process.exit(1);
  })
  .finally(async () => {
    await prisma.$disconnect();
  });
