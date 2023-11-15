import { Data } from '@prisma/client';
import prisma from '../prisma/prisma';
import { HttpException } from '../utils/error.utils';

/**
 * Service for interacting with the data table in the database
 */
export default class DataService {
  /**
   * Creates a data in the database
   * @param dataTypeName The name of the data type the data is associated with
   * @param value The value of the data
   * @param userId The userId of the user the data is associated with
   * @returns The created data
   */
  static async createData(dataTypeName: string, value: number, userId: string): Promise<Data> {
    const dataType = await prisma.dataType.findUnique({
      where: {
        name: dataTypeName
      }
    });

    if (!dataType) {
      throw new HttpException(404, `Data Type with name ${dataTypeName} not found!`);
    }

    const user = await prisma.user.findUnique({
      where: {
        id: userId
      }
    });

    if (!user) {
      throw new HttpException(404, `User with id ${userId} not found!`);
    }

    const data = await prisma.data.create({
      data: {
        value,
        dataType: {
          connect: {
            name: dataTypeName
          }
        },
        user: {
          connect: {
            id: userId
          }
        }
      }
    });

    return data;
  }
}
