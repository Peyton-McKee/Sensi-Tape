import { Recommendation, Tag } from '@prisma/client';
import prisma from '../prisma/prisma';

export default class RecommendationService {
  /**
   * Gets all the recommendations from the database
   * @returns All the recommendations in the database
   */
  static async getAllRecommendations(): Promise<Recommendation[]> {
    const recommendations = await prisma.recommendation.findMany();
    return recommendations;
  }

  /**
   * Creates a recommendation in the database
   * @param name the name of the recommendation
   * @param tags the tags associated with the recommendation
   * @param link the link to the video of the recommendation
   * @returns the created recommendation
   */
  static async createRecommendation(name: string, tags: Tag[], link: string): Promise<Recommendation> {
    const recommendation = await prisma.recommendation.create({
      data: {
        name,
        tags,
        link
      }
    });

    return recommendation;
  }
}
