-- Setting up environment
SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";

-- Altering tables and adding indexes/keys

-- Adding key on Petrolpump_No in Tanker table
ALTER TABLE `Tanker`
   ADD KEY `Petrolpump_No` (`Petrolpump_No`);

-- Adding keys for Employee table
ALTER TABLE `Employee`
   ADD KEY `Petrolpump_No` (`Petrolpump_No`),
   ADD KEY `Manager_ID` (`Manager_ID`);

-- Adding keys for Invoice table
ALTER TABLE `Invoice`
   ADD KEY `Date` (`Date`),
   ADD KEY `Customer_Code` (`Customer_Code`);

-- Adding key for Petrolpump_No in Sales table
ALTER TABLE `Sales`
   ADD KEY `Petrolpump_No` (`Petrolpump_No`);

-- Adding foreign keys

-- Owns table foreign keys
ALTER TABLE `Owns`
   ADD CONSTRAINT `Owns_ibfk_1` FOREIGN KEY (`Registration_No`) REFERENCES `PetrolPump` (`Registration_No`),
   ADD CONSTRAINT `Owns_ibfk_2` FOREIGN KEY (`Owner_Name`) REFERENCES `Owners` (`Owner_Name`);

-- Tanker table foreign key
ALTER TABLE `Tanker`
   ADD CONSTRAINT `Tanker_ibfk_1` FOREIGN KEY (`Petrolpump_No`) REFERENCES `PetrolPump` (`Registration_No`);

-- Employee table foreign keys
ALTER TABLE `Employee`
   ADD CONSTRAINT `Employee_ibfk_1` FOREIGN KEY (`Petrolpump_No`) REFERENCES `PetrolPump` (`Registration_No`),
   ADD CONSTRAINT `Employee_ibfk_2` FOREIGN KEY (`Manager_ID`) REFERENCES `Employee` (`Employee_ID`);

-- Invoice table foreign keys
ALTER TABLE `Invoice`
   ADD CONSTRAINT `Invoice_ibfk_1` FOREIGN KEY (`Customer_Code`) REFERENCES `Customer` (`Customer_Code`);

-- Sales table foreign key
ALTER TABLE `Sales`
   ADD CONSTRAINT `Sales_ibfk_1` FOREIGN KEY (`Petrolpump_No`) REFERENCES `PetrolPump` (`Registration_No`);

-- Contacts table foreign key
ALTER TABLE `Contacts`
   ADD CONSTRAINT `Contacts_ibfk_1` FOREIGN KEY (`Employee_ID`) REFERENCES `Employee` (`Employee_ID`);

-- Serves table foreign keys
ALTER TABLE `Serves`
   ADD CONSTRAINT `Serves_ibfk_1` FOREIGN KEY (`Employee_ID`) REFERENCES `Employee` (`Employee_ID`),
   ADD CONSTRAINT `Serves_ibfk_2` FOREIGN KEY (`Customer_Code`) REFERENCES `Customer` (`Customer_Code`);

-- Sales_Manage table foreign keys
ALTER TABLE `Sales_Manage`
   ADD CONSTRAINT `Sales_Manage_ibfk_1` FOREIGN KEY (`Employee_ID`) REFERENCES `Employee` (`Employee_ID`),
   ADD CONSTRAINT `Sales_Manage_ibfk_2` FOREIGN KEY (`Sales_No`) REFERENCES `Sales` (`Sales_No`),
   ADD CONSTRAINT `Sales_Manage_ibfk_3` FOREIGN KEY (`Date`) REFERENCES `Sales` (`Date`);

-- Committing the transaction
COMMIT;
