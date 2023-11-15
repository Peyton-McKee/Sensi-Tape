import { Activity, ActivityLevel, ActivityType } from '@prisma/client';
import prisma from '../prisma/prisma';
import UserService from './user.services';

export default class ActivityService {
  /**
   * Gets all the activity levels from the database
   * @returns All the activity levels in the database in a javascript object
   */
  static async getAllActivityLevels(): Promise<{ activityLevels: ActivityLevel[] }> {
    const activityLevels = Object.values(ActivityLevel);
    return {
      activityLevels
    };
  }

  /**
   * Gets all the activity types from the database
   * @returns All the activity types in the database in a javascript object
   */
  static async getAllActivityTypes(): Promise<{ activityTypes: ActivityType[] }> {
    const activityTypes = await Object.values(ActivityType);
    return {
      activityTypes
    };
  }

  /**
   * Creates an activity in the database
   * @param userId the id of the user whos activity it is
   * @param title the title of the activity
   * @param type the type of the activity
   * @param time the time of the activity from midnight in seconds
   * @param duration the duration of the activity in seconds
   * @param distance the distance of the activity in feet
   * @returns the created activity
   */
  static async createActivity(
    userId: string,
    title: string,
    type: ActivityType,
    time: number,
    duration: number,
    distance: number
  ): Promise<Activity> {
    const user = await UserService.getSingleUser(userId);

    const activity = await prisma.activity.create({
      data: {
        user: {
          connect: {
            id: user.id
          }
        },
        name: title,
        activityType: type,
        time,
        duration,
        feet: distance
      }
    });

    return activity;
  }
}
