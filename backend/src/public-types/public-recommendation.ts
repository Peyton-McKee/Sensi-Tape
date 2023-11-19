import { Tag } from '@prisma/client';

export type PublicRecommendation = {
  id: string;
  name: string;
  tags: Tag[];
  link: string;
};
