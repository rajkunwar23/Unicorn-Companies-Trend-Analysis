CREATE TABLE dim_geography (
    geo_id INT PRIMARY KEY,
    city VARCHAR(100),
    country VARCHAR(100),
    continent VARCHAR(50)
);

CREATE TABLE dim_industry (
    industry_id INT PRIMARY KEY,
    industry VARCHAR(150)
);

CREATE TABLE dim_investor (
    company_id INT,
	company VARCHAR(100),
    investor VARCHAR(200),

	FOREIGN KEY (company_id)
    REFERENCES fact_unicorn(company_id)
);


CREATE TABLE fact_unicorn (

    company_id INT PRIMARY KEY,
    company VARCHAR(150),

    valuation_B NUMERIC(12,2),
    funding_B NUMERIC(12,2),
    valuation_to_funding_ratio NUMERIC(10,2),
    ftv_ratio NUMERIC(10,4),

    valuation_tier VARCHAR(50),

    year_founded INT,
    year_joined INT,
    years_to_unicorn INT,

    industry VARCHAR(150),
    city VARCHAR(100),
    country VARCHAR(100),
    continent VARCHAR(50),

    investor_count INT,
    investors TEXT,

    is_valuation_outlier BOOLEAN,
    is_mega_unicorn BOOLEAN,
    is_high_efficiency BOOLEAN,

    gdp_year INT,
    gdp_B NUMERIC(12,2),
    valuation_pct_of_gdp NUMERIC(15,6),

    geo_id INT,
    industry_id INT,

    FOREIGN KEY (geo_id)
        REFERENCES dim_geography(geo_id),

    FOREIGN KEY (industry_id)
        REFERENCES dim_industry(industry_id)
);


-- Run this comands in SQL Shell after connecting to the correct db 

-\copy dim_geography (geo_id INT ,city VARCHAR(100),country VARCHAR(100),continent VARCHAR(50)); FROM 'C:\Users\rajku\Downloads\exported_all_db\dim_geography.csv' DELIMITER ',' CSV HEADER;

-\copy dim_investor (company_id ,company,investor) FROM 'C:\Users\rajku\Downloads\exported_all_db\dim_investor.csv' DELIMITER ',' CSV HEADER;

\copy fact_unicorn (company_id, company, valuation_b, funding_b, valuation_to_funding_ratio, ftv_ratio, valuation_tier, year_founded, year_joined, years_to_unicorn, industry, city, country, continent, investor_count, investors, is_valuation_outlier, is_mega_unicorn, is_high_efficiency, gdp_year, gdp_b, valuation_pct_of_gdp, geo_id, industry_id) FROM 'C:\Users\rajku\Downloads\exported_all_db\fact_unicorn.csv' DELIMITER ',' CSV HEADER;

ALTER TABLE fact_unicorn 
DROP COLUMN is_valuation_outlier, 
DROP COLUMN is_mega_unicorn,
DROP COLUMN is_high_efficiency,
DROP COLUMN gdp_year, 
DROP COLUMN gdp_b,
DROP COLUMN valuation_pct_of_gdp;

ALTER TABLE fact_unicorn 
DROP COLUMN investor_count;

