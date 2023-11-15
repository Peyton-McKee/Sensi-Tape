import { Data, Tag } from '@prisma/client';
import { PublicUserSettings } from './public-user-settings';
import { PublicData } from './public-data';

export type PublicUser = {
  id: string;
  firstName: string;
  lastName: string;
  email: string;
  tags: Tag[];
  data: PublicData[];
  userSettings?: PublicUserSettings;
};
