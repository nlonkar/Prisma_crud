/*
  Warnings:

  - You are about to drop the `user` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropTable
DROP TABLE `user`;

-- CreateTable
CREATE TABLE `mqtt_broker` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(45) NOT NULL,
    `address` VARCHAR(255) NOT NULL,
    `port` INTEGER NOT NULL DEFAULT 1883,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `mqtt_client` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(255) NOT NULL,
    `user` VARCHAR(255) NULL,
    `password` VARCHAR(255) NULL,
    `broker_id` INTEGER NOT NULL,
    `source_id` INTEGER NOT NULL,
    `is_in_operation` TINYINT NOT NULL DEFAULT 0,

    INDEX `fk_mqtt_client_mqtt_broker1_idx`(`broker_id`),
    INDEX `fk_mqtt_client_point_source1_idx`(`source_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `mqtt_map` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `sensor_id` INTEGER NOT NULL,
    `dataset_id` INTEGER NOT NULL,
    `point_id` INTEGER NULL,

    INDEX `fk_mqtt_map_mqtt_sensor1_idx`(`sensor_id`),
    INDEX `fk_mqtt_map_mqtt_sensor_dataset1_idx`(`dataset_id`),
    INDEX `fk_mqtt_map_point1_idx`(`point_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `mqtt_sensor` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(255) NOT NULL,
    `type_id` INTEGER NOT NULL,
    `broker_id` INTEGER NULL,

    INDEX `fk_mqtt_sensor_mqtt_broker1_idx`(`broker_id`),
    INDEX `fk_mqtt_sensor_mqtt_sensor_type1_idx`(`type_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `mqtt_sensor_dataset` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(45) NOT NULL,
    `type_id` INTEGER NOT NULL,
    `topic_id` INTEGER NOT NULL,

    INDEX `fk_mqtt_sensor_dataset_mqtt_sensor_type1_idx`(`type_id`),
    INDEX `fk_mqtt_sensor_dataset_mqtt_topic1_idx`(`topic_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `mqtt_sensor_type` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(255) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `mqtt_topic` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(255) NOT NULL,
    `type_id` INTEGER NOT NULL,

    INDEX `fk_mqtt_topic_mqtt_topic_type1_idx`(`type_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `mqtt_topic_type` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(45) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `mqtt_client` ADD CONSTRAINT `fk_mqtt_client_mqtt_broker1` FOREIGN KEY (`broker_id`) REFERENCES `mqtt_broker`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `mqtt_map` ADD CONSTRAINT `fk_mqtt_map_mqtt_sensor1` FOREIGN KEY (`sensor_id`) REFERENCES `mqtt_sensor`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `mqtt_map` ADD CONSTRAINT `fk_mqtt_map_mqtt_sensor_dataset1` FOREIGN KEY (`dataset_id`) REFERENCES `mqtt_sensor_dataset`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `mqtt_sensor` ADD CONSTRAINT `fk_mqtt_sensor_mqtt_broker1` FOREIGN KEY (`broker_id`) REFERENCES `mqtt_broker`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `mqtt_sensor` ADD CONSTRAINT `fk_mqtt_sensor_mqtt_sensor_type1` FOREIGN KEY (`type_id`) REFERENCES `mqtt_sensor_type`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `mqtt_sensor_dataset` ADD CONSTRAINT `fk_mqtt_sensor_dataset_mqtt_sensor_type1` FOREIGN KEY (`type_id`) REFERENCES `mqtt_sensor_type`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `mqtt_sensor_dataset` ADD CONSTRAINT `fk_mqtt_sensor_dataset_mqtt_topic1` FOREIGN KEY (`topic_id`) REFERENCES `mqtt_topic`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `mqtt_topic` ADD CONSTRAINT `fk_mqtt_topic_mqtt_topic_type1` FOREIGN KEY (`type_id`) REFERENCES `mqtt_topic_type`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;
