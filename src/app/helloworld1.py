from taipy.gui import Gui

# Define the GUI page
page = """
# Hello, World!

Welcome to your minimal Taipy GUI application.
"""

# Run the GUI on port 3500
Gui(page).run(port=3500)