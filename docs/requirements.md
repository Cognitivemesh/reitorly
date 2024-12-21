# Reitorly requirements

## Reiorly Overview
The system should include:

A fully functional expense tracker and asset manager.Visualizations and reporting features for actionable insights. A secure and user-friendly interface.

* Monthly Summary Function: Generate a monthly summary showing total expenses and category-wise breakdown. The reports are monthly, weekly and daily.
* There different types of expenses: *Needs* are the expenses you cannot avoid like monthly bills. These are the following:
  * **Housing:** Mortgage or rent; homeowners or renters insurance; property tax (if not already in the mortgage payment).
  * **Transportation:** Car payment, gas, maintenance and auto insurance; public transportation. 
  * **Health care:** Health insurance; out-of-pocket medical costs.
  * **Life insurance**.
  * **Utilities:** electricity and natural gas; water; sanitation/garbage; internet; cell phone and/or landline.
  * Groceries, toiletries and haircuts, and other essentials.
* These expenses, also called discretionary expenses,  may be harder to account for in a budget, as they don’t always come with a set monthly fee.
  * Clothing, jewelry, etc.
  * Dining out, special meals in (steaks for the grill, etc.).
  * Alcohol.
  * Movie, concert and event tickets.
  * Gym or club memberships.
  * Travel expenses (airline tickets, hotels, rental cars, etc.).
  * Cable or streaming packages.
  * Self-care treats like spa visits and pedicures.
  * Home decor.

## Additional Features

Testing: Implement unit and integration tests for all critical features.
Documentation: Provide clear, user-friendly setup guides and usage documentation.

## Design and Architecture

### Code Structure

* Modular Design: Organize code into logical modules for better maintainability.
* Structuring the main project files and folders
* Follow modular design principles for maintainability.
* Use PEP 8 guidelines for code consistency.
### Data Handling
* Database Integration: Use SQLite or similar for efficient data storage and retrieval.
* Importing CSV expense data
Data Security: Encrypt sensitive financial data to ensure security.
### Visualization
Utilize libraries like Taipy with Plotly for clear and informative visual charts.
### API Integration
Incorporate financial APIs for real-time market data and analysis.


* Data Persistence: Utilize databases (e.g., SQLite) for efficient data storage and retrieval.
* API Integration: Incorporate financial APIs for real-time data and trading capabilities.


* Creating an Expense class to represent each expense

* Storing expenses in lists or dictionaries
* Writing expenses to a database file for saving
* Loading expenses from database file when starting the app
* Summarizing expenses by categories and totals
* Calculating budgets and alerts
* Customization: Allow users to define custom categories, accounts, and asset types.
* Reporting: Implement comprehensive reporting features for financial analysis.
* Security: Ensure sensitive financial data is properly secured and encrypted.
* Testing: Implement unit tests and integration tests for reliability.
* Documentation: Provide clear documentation for setup, usage, and contribution.
* Code Style: Follow PEP 8 guidelines for consistent and readable Python code.
* Generating a Monthly Summary: This function will summarize all the expenses that happened in the current month. It will show the total expenses of the current month and then category-wise total expenses.
