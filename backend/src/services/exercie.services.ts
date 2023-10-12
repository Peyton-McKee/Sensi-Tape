import { Exercise, Tag } from '@prisma/client';
import prisma from '../prisma/prisma';

export default class ExerciseService {
  /**
   * Gets all the exercises from the database
   * @returns All the exercises in the database
   */
  static async getAllExercises(): Promise<Exercise[]> {
    return await prisma.exercise.findMany();
  }

  static async createExercise(name: string, tags: Tag[], link: string): Promise<Exercise> {
    const exercise = await prisma.exercise.create({
      data: {
        name,
        tags,
        link
      }
    });

    return exercise;
  }
}
