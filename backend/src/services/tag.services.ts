import { Tag } from '@prisma/client';
import prisma from '../prisma/prisma';

export default class TagService {
  /**
   * Gets all tags from the database
   * @returns all tags
   */
  static async getAllTags(): Promise<Tag[]> {
    const tags = await prisma.tag.findMany();
    return tags;
  }
}
