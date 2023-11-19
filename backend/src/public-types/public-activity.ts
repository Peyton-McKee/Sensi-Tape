import { ActivityType, Tag } from '@prisma/client';

export interface PublicActivity {
  id: string;
  name: string;
  time: number;
  activityType: ActivityType;
  duration: number;
  distance: number; // feet
}
