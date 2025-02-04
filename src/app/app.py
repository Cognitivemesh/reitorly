import taipy as tp
import polars as pl
import networkx as nx
from pyvis.network import Network
from taipy.gui import Gui

# Create Polars dataframes
nodes = pl.DataFrame({
    "id": [1, 2],
    "name": ["Supplier A", "Plant B"],
    "type": ["Supplier", "Plant"]
})

edges = pl.DataFrame({
    "source_id": [1],
    "relation": ["provisions"],
    "target_id": [2]
})

# Create NetworkX graph
G = nx.DiGraph()
for row in nodes.to_dicts():
    G.add_node(row["id"], label=row["name"], type=row["type"])

for row in edges.to_dicts():
    G.add_edge(row["source_id"], row["target_id"], label=row["relation"])

# Visualize the graph using Pyvis
net = Network(notebook=True, cdn_resources='remote')
net.from_nx(G)
net.show("graph.html")

# Taipy GUI definition
page = """
# Dashboard Mock

## Nodes DataFrame
<|{nodes}|table|>

## Edges DataFrame
<|{edges}|table|>

## Graph Visualization
<|iframe src="graph.html" width=800 height=600|>
"""
gui = Gui(page)

if __name__ == "__main__":
    gui.run(use_reloader=True, title="Dynamic chart",host="0.0.0.0", port=3300)