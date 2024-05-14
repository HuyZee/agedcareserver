-- CreateTable
CREATE TABLE `Member` (
    `member_id` INTEGER NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(191) NOT NULL,
    `date_of_birth` DATETIME(3) NOT NULL,
    `gender` VARCHAR(191) NOT NULL,
    `emergency_contact` VARCHAR(191) NOT NULL,
    `next_of_kin` VARCHAR(191) NOT NULL,
    `mailing_address` VARCHAR(191) NOT NULL,
    `allergies_or_diet` VARCHAR(191) NOT NULL,
    `current_medications` VARCHAR(191) NOT NULL,
    `general_practitioner` VARCHAR(191) NOT NULL,

    PRIMARY KEY (`member_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Staff` (
    `staff_id` INTEGER NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(191) NOT NULL,
    `contact_information` VARCHAR(191) NOT NULL,
    `qualifications` VARCHAR(191) NOT NULL,
    `role` VARCHAR(191) NOT NULL,
    `availability` VARCHAR(191) NOT NULL,

    PRIMARY KEY (`staff_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Service` (
    `service_id` INTEGER NOT NULL AUTO_INCREMENT,
    `service_type` VARCHAR(191) NOT NULL,
    `duration` VARCHAR(191) NOT NULL,
    `description` VARCHAR(191) NOT NULL,

    PRIMARY KEY (`service_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Facility` (
    `facility_id` INTEGER NOT NULL AUTO_INCREMENT,
    `room_number` VARCHAR(191) NOT NULL,
    `occupancy_status` VARCHAR(191) NOT NULL,
    `reservation_length` VARCHAR(191) NOT NULL,
    `date_reserved` DATETIME(3) NOT NULL,

    PRIMARY KEY (`facility_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Appointment` (
    `appointment_id` INTEGER NOT NULL AUTO_INCREMENT,
    `member_id` INTEGER NOT NULL,
    `staff_id` INTEGER NOT NULL,
    `service_id` INTEGER NOT NULL,
    `facility_id` INTEGER NOT NULL,
    `appointment_date` DATETIME(3) NOT NULL,
    `appointment_time` VARCHAR(191) NOT NULL,
    `notes` VARCHAR(191) NOT NULL,

    PRIMARY KEY (`appointment_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Medication` (
    `medication_id` INTEGER NOT NULL AUTO_INCREMENT,
    `medication_name` VARCHAR(191) NOT NULL,
    `dosage_form` VARCHAR(191) NOT NULL,
    `quantity_on_hand` INTEGER NOT NULL,
    `expiration_date` DATETIME(3) NOT NULL,

    PRIMARY KEY (`medication_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Inventory` (
    `inventory_id` INTEGER NOT NULL AUTO_INCREMENT,
    `medication_id` INTEGER NOT NULL,
    `quantity` INTEGER NOT NULL,
    `last_restocked` DATETIME(3) NOT NULL,

    PRIMARY KEY (`inventory_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Schedule` (
    `schedule_id` INTEGER NOT NULL AUTO_INCREMENT,
    `staff_id` INTEGER NOT NULL,
    `date` DATETIME(3) NOT NULL,
    `shift_start_time` VARCHAR(191) NOT NULL,
    `shift_end_time` VARCHAR(191) NOT NULL,

    PRIMARY KEY (`schedule_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `Appointment` ADD CONSTRAINT `Appointment_member_id_fkey` FOREIGN KEY (`member_id`) REFERENCES `Member`(`member_id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Appointment` ADD CONSTRAINT `Appointment_staff_id_fkey` FOREIGN KEY (`staff_id`) REFERENCES `Staff`(`staff_id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Appointment` ADD CONSTRAINT `Appointment_service_id_fkey` FOREIGN KEY (`service_id`) REFERENCES `Service`(`service_id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Appointment` ADD CONSTRAINT `Appointment_facility_id_fkey` FOREIGN KEY (`facility_id`) REFERENCES `Facility`(`facility_id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Medication` ADD CONSTRAINT `Medication_medication_id_fkey` FOREIGN KEY (`medication_id`) REFERENCES `Inventory`(`inventory_id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Schedule` ADD CONSTRAINT `Schedule_staff_id_fkey` FOREIGN KEY (`staff_id`) REFERENCES `Staff`(`staff_id`) ON DELETE RESTRICT ON UPDATE CASCADE;
