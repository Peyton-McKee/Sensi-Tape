import { Exercise } from '@prisma/client';
import prisma from '../prisma/prisma';

export default class ExerciseService {
  /**
   * Gets all the exercises from the database
   * @returns All the exercises in the database
   */
  static async getAllExercises(): Promise<Exercise[]> {
    return await prisma.exercise.findMany();
  }
}
