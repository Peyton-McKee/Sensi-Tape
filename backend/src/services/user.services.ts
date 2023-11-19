import { ActivityLevel, Data, Recommendation, User } from '@prisma/client';
import prisma from '../prisma/prisma';
import { HttpException } from '../utils/error.utils';
import { PublicUser } from '../public-types/public-user';
import { userSettingsTransformer, userTransformer } from '../transformers/user.transformer';
import { PublicUserSettings } from '../public-types/public-user-settings';
import userQueryArgs from '../query-args/user.query-args';

export default class UserService {
  /**
   * Gets all the users stored in the database
   * @returns All the users in the database
   */
  static async getAllUsers(): Promise<User[]> {
    return await prisma.user.findMany();
  }

  /**
   * Attempts to get the user with the given id from the database along with its data, throws error if not found
   * @param userId The user id of the user to return
   * @returns The specified user with the user's data
   */
  static async getSingleUser(userId: string): Promise<PublicUser> {
    const user = await prisma.user.findUnique({
      where: {
        id: userId
      },
      ...userQueryArgs
    });

    if (!user) {
      throw new HttpException(
        404,
        `User with id ${userId} not found! (Please Logout and Login again to resolve this issue)`
      );
    }

    return userTransformer(user);
  }

  /**
   * Creates a user in the database
   * @param firstName the users firstname
   * @param lastName the users lastname
   * @param email the users email
   * @returns a created user
   */
  static async createUser(firstName: string, lastName: string, email: string): Promise<User> {
    const user = await prisma.user.create({
      data: {
        firstName,
        lastName,
        email
      }
    });

    return user;
  }

  /**
   * Gets the top 6 recommendations for the user with the given id
   * @param userId the user to get the recommendations for
   * @returns the top 6 recommendations for the user
   */
  static async getUserRecommendations(userId: string): Promise<Recommendation[]> {
    const user = await this.getSingleUser(userId);

    const recommendations = await prisma.recommendation.findMany({
      include: {
        tags: true
      }
    });

    //Get the six recommendations with the most tags in common with the user
    const userTags = user.tags.map((tag) => tag.name);
    const sortedRecommendations = recommendations
      .map((recommendation) => {
        const commonTags = recommendation.tags.filter((tag) => userTags.includes(tag.name));
        return {
          recommendation,
          commonTags
        };
      })
      .sort((a, b) => b.commonTags.length - a.commonTags.length)
      .slice(0, 6)
      .map((recommendation) => recommendation.recommendation);

    return sortedRecommendations;
  }

  /**
   * Upserts user settings for the user with the given id
   * @param userId the user to add settings for
   * @param height the height of the user
   * @param weight the weight of the user
   * @param gender the gender of the user
   * @param age the age of the user
   * @param activityLevel the activity level of the user
   * @returns the created or updated user settings
   */
  static async upsertUserSettings(
    userId: string,
    height: number,
    weight: number,
    gender: string,
    age: number,
    activityLevel: ActivityLevel
  ): Promise<PublicUserSettings> {
    const user = await this.getSingleUser(userId);

    const userSettings = await prisma.userSettings.upsert({
      where: {
        userId: user.id
      },
      update: {
        height,
        weight,
        gender,
        age,
        activityLevel
      },
      create: {
        user: {
          connect: {
            id: user.id
          }
        },
        height,
        weight,
        gender,
        age,
        activityLevel
      }
    });

    return userSettingsTransformer(userSettings);
  }
}
