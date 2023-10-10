-- CreateTable
CREATE TABLE "User" (
    "id" TEXT NOT NULL,
    "firstName" TEXT NOT NULL,
    "lastName" TEXT NOT NULL,
    "email" TEXT NOT NULL,

    CONSTRAINT "User_pkey" PRIMARY KEY ("id")
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
    "userId" TEXT NOT NULL,

    CONSTRAINT "Data_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "User_email_key" ON "User"("email");

-- CreateIndex
CREATE UNIQUE INDEX "DataType_name_key" ON "DataType"("name");

-- AddForeignKey
ALTER TABLE "Data" ADD CONSTRAINT "Data_dataTypeName_fkey" FOREIGN KEY ("dataTypeName") REFERENCES "DataType"("name") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Data" ADD CONSTRAINT "Data_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
