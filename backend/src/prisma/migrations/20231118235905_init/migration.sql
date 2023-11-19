-- CreateEnum
CREATE TYPE "ActivityLevel" AS ENUM ('SEDENTARY', 'LIGHTLY_ACTIVE', 'MODERATELY_ACTIVE', 'VERY_ACTIVE', 'EXTREMELY_ACTIVE');

-- CreateEnum
CREATE TYPE "ActivityType" AS ENUM ('STRETCHING', 'STRENGTH_TRAINING', 'CARDIO', 'YOGA', 'PILATES', 'TAI_CHI', 'MEDITATION', 'DANCE', 'WALKING', 'RUNNING', 'CYCLING', 'SWIMMING', 'HIKING', 'CLIMBING', 'SKIING', 'SNOWBOARDING', 'SKATING', 'ROWING', 'KAYAKING', 'CANOEING', 'SURFING', 'PADDLEBOARDING', 'MARTIAL_ARTS', 'BOXING', 'GYMNASTICS', 'CALISTHENICS', 'CROSSFIT', 'BARRE', 'OTHER');

-- CreateTable
CREATE TABLE "User" (
    "id" TEXT NOT NULL,
    "firstName" TEXT NOT NULL,
    "lastName" TEXT NOT NULL,
    "email" TEXT NOT NULL,

    CONSTRAINT "User_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "UserSettings" (
    "id" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "activityLevel" "ActivityLevel" NOT NULL,
    "gender" TEXT NOT NULL,
    "age" INTEGER NOT NULL,
    "height" INTEGER NOT NULL,
    "weight" INTEGER NOT NULL,

    CONSTRAINT "UserSettings_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "DataType" (
    "name" TEXT NOT NULL,

    CONSTRAINT "DataType_pkey" PRIMARY KEY ("name")
);

-- CreateTable
CREATE TABLE "Tag" (
    "name" TEXT NOT NULL,

    CONSTRAINT "Tag_pkey" PRIMARY KEY ("name")
);

-- CreateTable
CREATE TABLE "Data" (
    "id" TEXT NOT NULL,
    "dataTypeName" TEXT NOT NULL,
    "time" BIGINT NOT NULL,
    "value" INTEGER NOT NULL,
    "userId" TEXT NOT NULL,

    CONSTRAINT "Data_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Activity" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "time" INTEGER NOT NULL,
    "activityType" "ActivityType" NOT NULL,
    "duration" INTEGER NOT NULL,
    "feet" INTEGER NOT NULL,
    "userId" TEXT NOT NULL,

    CONSTRAINT "Activity_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Recommendation" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "link" TEXT NOT NULL,

    CONSTRAINT "Recommendation_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "_TagToUser" (
    "A" TEXT NOT NULL,
    "B" TEXT NOT NULL
);

-- CreateTable
CREATE TABLE "_RecommendationToTag" (
    "A" TEXT NOT NULL,
    "B" TEXT NOT NULL
);

-- CreateIndex
CREATE UNIQUE INDEX "User_email_key" ON "User"("email");

-- CreateIndex
CREATE UNIQUE INDEX "UserSettings_userId_key" ON "UserSettings"("userId");

-- CreateIndex
CREATE UNIQUE INDEX "DataType_name_key" ON "DataType"("name");

-- CreateIndex
CREATE UNIQUE INDEX "Tag_name_key" ON "Tag"("name");

-- CreateIndex
CREATE UNIQUE INDEX "_TagToUser_AB_unique" ON "_TagToUser"("A", "B");

-- CreateIndex
CREATE INDEX "_TagToUser_B_index" ON "_TagToUser"("B");

-- CreateIndex
CREATE UNIQUE INDEX "_RecommendationToTag_AB_unique" ON "_RecommendationToTag"("A", "B");

-- CreateIndex
CREATE INDEX "_RecommendationToTag_B_index" ON "_RecommendationToTag"("B");

-- AddForeignKey
ALTER TABLE "UserSettings" ADD CONSTRAINT "UserSettings_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Data" ADD CONSTRAINT "Data_dataTypeName_fkey" FOREIGN KEY ("dataTypeName") REFERENCES "DataType"("name") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Data" ADD CONSTRAINT "Data_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Activity" ADD CONSTRAINT "Activity_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_TagToUser" ADD CONSTRAINT "_TagToUser_A_fkey" FOREIGN KEY ("A") REFERENCES "Tag"("name") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_TagToUser" ADD CONSTRAINT "_TagToUser_B_fkey" FOREIGN KEY ("B") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_RecommendationToTag" ADD CONSTRAINT "_RecommendationToTag_A_fkey" FOREIGN KEY ("A") REFERENCES "Recommendation"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_RecommendationToTag" ADD CONSTRAINT "_RecommendationToTag_B_fkey" FOREIGN KEY ("B") REFERENCES "Tag"("name") ON DELETE CASCADE ON UPDATE CASCADE;
