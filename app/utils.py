def calculate_growth_rates(sales_data):
    sales_growth_rate = {}
    previous_month_sales = None

    for month, sales in sales_data.items():
        if previous_month_sales is not None:
            growth_rate = ((sales - previous_month_sales) / previous_month_sales) * 100
            sales_growth_rate[month] = round(growth_rate, 2)
        previous_month_sales = sales

    return sales_growth_rate