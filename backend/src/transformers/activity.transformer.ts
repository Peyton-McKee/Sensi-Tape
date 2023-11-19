import { Activity } from '@prisma/client';
import { PublicActivity } from '../public-types/public-activity';

export const activityTransformer = (activity: Activity): PublicActivity => {
  return {
    id: activity.id,
    name: activity.name,
    time: activity.time,
    activityType: activity.activityType,
    duration: activity.duration,
    distance: activity.feet
  };
};
