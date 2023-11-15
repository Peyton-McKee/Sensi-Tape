-- CreateEnum
CREATE TYPE "ActivityLevel" AS ENUM ('SEDENTARY', 'LIGHTLY_ACTIVE', 'MODERATELY_ACTIVE', 'VERY_ACTIVE', 'EXTREMELY_ACTIVE');

-- CreateEnum
CREATE TYPE "ActivityType" AS ENUM ('STRETCHING', 'STRENGTH_TRAINING', 'CARDIO', 'YOGA', 'PILATES', 'TAI_CHI', 'MEDITATION', 'DANCE', 'WALKING', 'RUNNING', 'CYCLING', 'SWIMMING', 'HIKING', 'CLIMBING', 'SKIING', 'SNOWBOARDING', 'SKATING', 'ROWING', 'KAYAKING', 'CANOEING', 'SURFING', 'PADDLEBOARDING', 'MARTIAL_ARTS', 'BOXING', 'GYMNASTICS', 'CALISTHENICS', 'CROSSFIT', 'BARRE', 'OTHER');

-- CreateEnum
CREATE TYPE "Tag" AS ENUM ('RELAXATION', 'FLEXIBILITY', 'DISCOMFORT_RESOLUTION', 'STRENGTH', 'PAIN_RELIEF', 'MOBILITY', 'STABILITY', 'BALANCE', 'POSTURE');

-- CreateTable
CREATE TABLE "User" (
    "id" TEXT NOT NULL,
    "firstName" TEXT NOT NULL,
    "lastName" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "currentTags" "Tag"[],

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
CREATE TABLE "Data" (
    "id" TEXT NOT NULL,
    "dataTypeName" TEXT NOT NULL,
    "value" INTEGER NOT NULL,
    "userId" TEXT NOT NULL,

    CONSTRAINT "Data_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Activity" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "tags" "Tag"[],
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
    "tags" "Tag"[],
    "link" TEXT NOT NULL,

    CONSTRAINT "Recommendation_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "User_email_key" ON "User"("email");

-- CreateIndex
CREATE UNIQUE INDEX "UserSettings_userId_key" ON "UserSettings"("userId");

-- CreateIndex
CREATE UNIQUE INDEX "DataType_name_key" ON "DataType"("name");

-- AddForeignKey
ALTER TABLE "UserSettings" ADD CONSTRAINT "UserSettings_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Data" ADD CONSTRAINT "Data_dataTypeName_fkey" FOREIGN KEY ("dataTypeName") REFERENCES "DataType"("name") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Data" ADD CONSTRAINT "Data_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Activity" ADD CONSTRAINT "Activity_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
