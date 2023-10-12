import { DataType } from "@prisma/client";
import prisma from "../prisma/prisma";

/**
 * Service for interacting with the data type table in the database
 */
export default class DataTypeService {
   /**
    * Creates a data type in the database
    * @param name The name of the data type
    * @returns the created data type
    */
   static async createDataType(name: string): Promise<DataType> {
      const dataType = await prisma.dataType.create({
         data: {
            name
         }
      });

      return dataType;
   }
}