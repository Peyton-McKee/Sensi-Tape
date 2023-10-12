import { Data, User } from '@prisma/client';
import prisma from '../prisma/prisma';
import { HttpException } from '../utils/error.utils';

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
  static async getSingleUser(userId: string): Promise<User & { data: Data[] }> {
    const user = await prisma.user.findUnique({
      where: {
        id: userId
      },
      include: {
        data: true
      }
    });

    if (!user) {
      throw new HttpException(
        404,
        `User with id ${userId} not found! (Please Logout and Login again to resolve this issue)`
      );
    }

    return user;
  }

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
}
