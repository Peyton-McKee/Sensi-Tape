import { ActivityLevel } from '@prisma/client';

export type PublicUserSettings = {
  id: string;
  age: number;
  gender: string;
  weight: number;
  height: number;
  activityLevel: ActivityLevel;
};
