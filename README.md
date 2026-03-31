# SQL-Retail-Data-Cleaning
This project focuses on the end-to-end cleaning of a raw retail sales dataset. The goal was to transform "dirty" data—containing duplicates, missing values, and inconsistent formatting—into a clean, reliable dataset suitable for business intelligence analysis.

**Project Overview**:
This project involved a full ETL (Extract, Transform, Load) process to clean a raw retail sales dataset. The goal was to prepare the data for high-performance analysis in Power BI, ensuring that all data types were optimized for DAX calculations and visualization.

**Key Technical Achievements:**

    Boolean Normalization: Converted Discount Applied from inconsistent text strings ("True"/"False") into Integer/Boolean (1/0) format. This optimization allows for faster aggregation and direct summation of discount counts in visualization tools.

    Numeric Precision: Defined financial columns (Price, Total Spent) as Double/Decimal types to maintain mathematical accuracy for revenue reporting.

    Date Standardization: Transformed string-based transaction dates into true SQL DATE objects to enable time-series intelligence.

