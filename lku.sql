INSERT INTO logi (tegevus, andmed, kasutaja, aeg)
    VALUES (
        'INSERT', 
        CONCAT('cityName: ', NEW.cityName, ', countryName: ', NEW.countryName, ', continent: ', NEW.continent, 
               ', region: ', NEW.region, ', district: ', NEW.district, ', population: ', NEW.population), 
        USER(), 
        NOW()
    )
  
INSERT INTO logi (tegevus, andmed, kasutaja, aeg)
    VALUES (
        'DELETE', 
        CONCAT('cityName: ', OLD.cityName, ', countryName: ', OLD.countryName, ', continent: ', OLD.continent, 
               ', region: ', OLD.region, ', district: ', OLD.district, ', population: ', OLD.population), 
        USER(), 
        NOW()
    )

INSERT INTO logi (tegevus, andmed, kasutaja, aeg)
    VALUES (
        'UPDATE', 
        CONCAT('cityName: ', NEW.cityName, ', countryName: ', NEW.countryName, ', continent: ', NEW.continent, 
               ', region: ', NEW.region, ', district: ', NEW.district, ', population: ', NEW.population), 
        USER(), 
        NOW()
    )
