import prisma from '../prisma/prisma';
import { PublicRecommendation } from '../public-types/public-recommendation';

export default class RecommendationService {
  /**
   * Gets all the recommendations from the database
   * @returns All the recommendations in the database
   */
  static async getAllRecommendations(): Promise<PublicRecommendation[]> {
    const recommendations = await prisma.recommendation.findMany({
      include: {
        tags: true
      }
    });
    return recommendations;
  }

  /**
   * Creates a recommendation in the database
   * @param name the name of the recommendation
   * @param tags the tags associated with the recommendation
   * @param link the link to the video of the recommendation
   * @returns the created recommendation
   */
  static async createRecommendation(name: string, tags: string[], link: string): Promise<PublicRecommendation> {
    const recommendation = await prisma.recommendation.create({
      data: {
        name,
        tags: {
          connectOrCreate: tags.map((tag: string) => ({
            where: { name: tag },
            create: { name: tag }
          }))
        },
        link
      },
      include: {
        tags: true
      }
    });

    return recommendation;
  }
}
