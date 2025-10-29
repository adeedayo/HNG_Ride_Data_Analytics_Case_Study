## Project Background
HNG Ride, established in 2021, is a transportation company located in North America.

The company has significant amount of data on its drivers, payments, rides and riders that has been previously underutilized. This project thoroughly analyzes and synthesizes this data in order to improve HNG Ride's transportation services.

Insights and recommendations will be provided on the following key areas:
- **Revenue Trends:** Evaluating quarterly revenue growth and identifying peak performance periods.  
- **Driver & Rider Performance:** Understanding ride completion rates, consistency, and identifying top performers.  
- **Operational Efficiency:** Examining cancellations, cashless adoption, and bonus qualification metrics.

The SQL queries utilized to clean, organize and prepare the data for this project can found here.
Targeted SQL queries regarding various business questions can be found here.

## Data Structure $ Initial Checks
HNG Rides's database as seen below consists of four tables: drivers_raw, payments_raw, riders_raw and rides_raw, with a total row count of 112,000 records


## Executive Summary

#### Overview of Findings 
Overall, the analysis revealed strong business performance trends and areas for optimization. Revenue showed steady growth with the highest year-over-year increase in Q4 2024, while driver performance varied widely—only a small group consistently achieved high ratings above 4.5 and over 30 rides monthly. Rider retention remained impressive, with a large share of 2021 sign-ups still active in 2024. Cashless payments dominated transactions, accounting for over 85% of all rides. However, cancellation rates were notably higher in Chicago, potentially linked to traffic or demand challenges. Lastly, only a few drivers qualified for performance bonuses, indicating room for broader driver engagement and quality improvement.

###### Revenue Trends:
- Quarterly revenue showed strong growth trends, particularly between 2023 and 2024.  
- **Q4 2024** recorded the highest YoY growth, suggesting seasonal ride demand or improved operational strategies.

##### Driver $ Rider Consistency: 
- Drivers’ average monthly rides varied widely. The top 5 most consistent drivers maintained steady performance across months, showing reliability and engagement.
- A subset of riders who joined in **2021** continued taking rides through **2024**, demonstrating long-term customer loyalty.  
- Additionally, most frequent riders preferred digital payments, showing readiness for a **cashless mobility ecosystem**.

##### Operational Efficiency:
Only a handful of drivers met the bonus criteria:
- 30+ completed rides,
- Rating ≥ 4.5, and
- Cancellation rate < 5%.  
This indicates a strong opportunity for **driver training and engagement programs** to increase the eligible pool.

#### Recommendations:
Based on the ucovered insights, the following recommendations have been provided:
- Focus on replicating successful operational practices from high-performing quarters to sustain revenue growth.

- Introduce a structured performance-based incentive system to motivate drivers below the threshold.

- Investigate high-cancellation cities like New York to identify underlying causes such as traffic, pricing, or app experience issues.

- Encourage long-term riders through loyalty programs and referral bonuses to maintain retention.

- Strengthen digital payment infrastructure and reward non-cash transactions to streamline operations.
