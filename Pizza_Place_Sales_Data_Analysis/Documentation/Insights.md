# Maven Pizza Sales Analysis — Business Insights

## Project Overview

This project analyzes pizza sales data from 2015 using SQL Server to identify sales patterns, top-performing products, revenue trends, and potential business opportunities.

The analysis covers order timing, weekday performance, pizza sizes, product popularity, category revenue, monthly trends, and first-half versus second-half performance.

## 1. Overall Sales Performance

* **Average Order Value:** 38.18.
* **Highest Revenue Month:** July, with 72,300.
* **Lowest Revenue Month:** October, with 63,796.
* The difference between July and October revenue was 8,504.

### Business Insight

July was the strongest month by revenue, while October recorded the lowest monthly revenue. The business could investigate what contributed to July's performance and whether promotions, customer demand, or operational factors affected October.

*Note: The dataset covers one year, so these results identify monthly differences within 2015 and do not establish a recurring seasonal trend.*

## 2. Order Timing and Weekday Performance

### Busiest Hours

| Hour  | Total Orders |
| ----- | -----------: |
| 12:00 |        2,520 |
| 13:00 |        2,455 |
| 18:00 |        2,399 |
| 17:00 |        2,336 |
| 19:00 |        2,009 |

The busiest recorded hour was **12:00**, followed by 13:00. Early evening hours, particularly 17:00 and 18:00, also recorded high order volumes.

### Orders by Day of the Week

| Day       | Total Orders |
| --------- | -----------: |
| Friday    |        3,538 |
| Thursday  |        3,239 |
| Saturday  |        3,158 |
| Wednesday |        3,024 |
| Tuesday   |        2,973 |
| Monday    |        2,794 |
| Sunday    |        2,624 |

Friday had the highest order count, while Sunday had the lowest.

### Business Insight

Staffing and preparation could be planned around the lunch rush and early evening demand. Friday may also require additional operational capacity because it recorded the highest weekday order count and revenue.

Friday's reported revenue was **135,597**.

## 3. Sales by Pizza Size

### Quantity Sold

| Size             | Quantity Sold |
| ---------------- | ------------: |
| Large (L)        |        18,956 |
| Medium (M)       |        15,635 |
| Small (S)        |        14,403 |
| Extra Large (XL) |           552 |
| XXL              |            28 |

### Revenue by Size

| Size             | Revenue |
| ---------------- | ------: |
| Large (L)        | 374,667 |
| Medium (M)       | 247,955 |
| Small (S)        | 177,125 |
| Extra Large (XL) |  14,352 |
| XXL              |   1,008 |

### Business Insight

Large pizzas led both quantity sold and revenue in the query results. Medium and Small pizzas followed, while XL and XXL recorded much lower sales.

The business could review demand and inventory allocation by size. Before making major decisions about XL or XXL availability, it should also consider product availability, pricing, and the number of products offered in each size.

## 4. Top-Performing Pizza Products

### Highest Quantity Sold

| Pizza                      | Quantity Sold |
| -------------------------- | ------------: |
| The Classic Deluxe Pizza   |         2,453 |
| The Barbecue Chicken Pizza |         2,432 |
| The Hawaiian Pizza         |         2,422 |
| The Pepperoni Pizza        |         2,418 |
| The Thai Chicken Pizza     |         2,371 |

The Classic Deluxe Pizza recorded the highest quantity sold among the listed products.

### Highest Revenue

| Pizza                        | Revenue |
| ---------------------------- | ------: |
| The Thai Chicken Pizza       |  44,027 |
| The Barbecue Chicken Pizza   |  43,376 |
| The California Chicken Pizza |  42,002 |
| The Classic Deluxe Pizza     |  37,944 |
| The Southwest Chicken Pizza  |  35,185 |

The Thai Chicken Pizza generated the highest reported revenue, followed by the Barbecue Chicken and California Chicken pizzas.

### Highest Average Selling Price

The Brie Carre Pizza had the highest reported average selling price at **24.00**, but its quantity sold was only **490**.

### Business Insight

The Classic Deluxe Pizza performed strongly in both quantity sold and number of orders, while the Thai Chicken Pizza led in revenue. These products could be considered for featured promotions, subject to profitability and ingredient costs.

The Brie Carre Pizza's higher average price did not translate into a similarly high sales volume, so its performance should be assessed using margin and customer demand before changing its price or promotion strategy.

## 5. Revenue by Pizza Category

| Category  | Reported Revenue |
| --------- | ---------------: |
| Supreme   |          206,095 |
| Classic   |          198,929 |
| Chicken   |          198,682 |
| Veggie    |          192,573 |
| Mushroom* |           18,828 |

Classic recorded the highest quantity sold at **13,529**, while Supreme generated the highest reported category revenue at **206,095**.

### Business Insight

The category leading in quantity does not necessarily lead in revenue. Classic was the top category by quantity, whereas Supreme was the top category by reported revenue.

This difference suggests that product mix and selling prices should be considered alongside sales volume when evaluating category performance.

*Data-quality note: the Mushroom result is associated with a suspicious product label (`"The Pepperoni`) in the query output. The category totals should not be treated as fully reliable until that record and the source import are checked.*

## 6. Monthly Revenue Changes

| Month     | Revenue | Change from Previous Month |
| --------- | ------: | -------------------------: |
| January   |  69,545 |                          — |
| February  |  64,929 |                     -4,616 |
| March     |  70,180 |                     +5,251 |
| April     |  68,527 |                     -1,653 |
| May       |  71,204 |                     +2,677 |
| June      |  67,999 |                     -3,205 |
| July      |  72,300 |                     +4,301 |
| August    |  68,034 |                     -4,266 |
| September |  63,976 |                     -4,058 |
| October   |  63,796 |                       -180 |
| November  |  70,142 |                     +6,346 |
| December  |  64,475 |                     -5,667 |

November recorded the largest positive month-over-month revenue change, increasing by **6,346** compared with October. December then recorded a decrease of **5,667** compared with November.

### Business Insight

Revenue varied across the year rather than increasing consistently. Reviewing the factors behind the increases in March, May, July, and November may help the business identify successful sales activities. The available data alone does not establish what caused these changes.

## 7. First-Half vs. Second-Half Revenue

The category-level results reported lower revenue in the second half of 2015 for all listed categories:

| Category  | First-Half Revenue | Second-Half Revenue | Difference |
| --------- | -----------------: | ------------------: | ---------: |
| Classic   |             99,675 |              99,254 |       -421 |
| Chicken   |             99,983 |              98,699 |     -1,284 |
| Supreme   |            104,980 |             101,115 |     -3,865 |
| Veggie    |             98,203 |              94,370 |     -3,833 |
| Mushroom* |              9,543 |               9,285 |       -258 |

Supreme and Veggie recorded the largest reported declines among the main categories. Classic had the smallest decline.

At the product level, the Thai Chicken Pizza increased from **21,550** in the first half to **22,477** in the second half, a gain of **927**. The Classic Deluxe Pizza also increased by **920**.

The Barbecue Chicken Pizza declined from **22,673** to **20,703**, a decrease of **1,970**.

### Business Insight

The second-half performance was mixed across products, even though the reported category totals declined. Product-level comparisons can help identify products that maintained or increased revenue and those that may need further investigation.

*The Mushroom category figures require data validation because of the suspicious product label noted above.*

## 8. Recommendations

Based on the reported results:

1. **Plan for peak hours:** Ensure sufficient staffing and preparation during the busiest lunch hours and early evening.
2. **Prepare for high-demand days:** Review staffing and inventory plans for Fridays, which had the highest weekday order count and revenue.
3. **Monitor leading products:** Track the Classic Deluxe, Thai Chicken, and Barbecue Chicken pizzas by quantity, revenue, and profit margin.
4. **Review product sizes:** Large pizzas led quantity and revenue; investigate the reasons for low XL and XXL sales before changing the menu.
5. **Investigate monthly fluctuations:** Examine the business factors behind July's high revenue, October's low revenue, and November's increase.
6. **Validate imported data:** Correct or investigate the suspicious `"The Pepperoni` record and confirm category mappings before publishing category-level conclusions.
7. **Add profitability analysis when cost data is available:** Revenue alone does not establish which products are most profitable.

## Conclusion

The SQL analysis identified meaningful differences in sales by time, weekday, size, product, category, and month. Large pizzas led sales by size, the Classic Deluxe Pizza led quantity sold, the Thai Chicken Pizza led reported product revenue, and Supreme led reported category revenue.

These findings can support operational planning and further business investigation. Category-level conclusions should be revisited after validating the suspicious product record, and profitability should be assessed separately if ingredient or product cost data becomes available.