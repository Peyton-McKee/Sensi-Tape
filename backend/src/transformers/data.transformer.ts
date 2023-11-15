import { Data } from '@prisma/client';
import { PublicData } from '../public-types/public-data';

export const dataTransformer = (data: Data): PublicData => {
  return {
    id: data.id,
    value: data.value,
    dataTypeName: data.dataTypeName
  };
};
