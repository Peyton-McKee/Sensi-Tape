import { Prisma } from '@prisma/client';
import { PublicUser } from '../public-types/public-user';
import userQueryArgs from '../query-args/user.query-args';
import { PublicUserSettings } from '../public-types/public-user-settings';
import { dataTransformer } from './data.transformer';
import { activityTransformer } from './activity.transformer';

export const userTransformer = (user: Prisma.UserGetPayload<typeof userQueryArgs>): PublicUser => {
  return {
    id: user.id,
    firstName: user.firstName,
    lastName: user.lastName,
    email: user.email,
    tags: user.currentTags,
    activities: user.activities.map(activityTransformer),
    data: user.data.map(dataTransformer),
    userSettings: userSettingsTransformer(user.userSettings)
  };
};

export const userSettingsTransformer = (userSettings: Prisma.UserSettingsGetPayload<{}> | null): PublicUserSettings => {
  if (!userSettings) return undefined;
  return {
    id: userSettings.id,
    gender: userSettings.gender,
    age: userSettings.age,
    height: userSettings.height,
    weight: userSettings.weight,
    activityLevel: userSettings.activityLevel
  };
};
