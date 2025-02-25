from pysmt.shortcuts import And, Not, Or, Symbol, LE, Int, Plus, Equals
from pysmt.smtlib.parser import SmtLibParser
from pysmt.fnode import FNode
from pysmt.operators import ALL_TYPES, op_to_str
from torch_geometric.data import Data
import torch
import numpy as np


class SMTFormulaGraph:
    def __init__(self, smt2_file):
        """
        Initializes the SMTFormulaGraph object by parsing an SMT2 file.
        """
        self.smt2_file = smt2_file
        self.parser = SmtLibParser()
        self.one_hot_nodes = []
        self.coo_edges = []
        self.node_map = {}

    def parse_smt_file(self):
        """
        Parses the SMT2 file and returns the final formula.
        """
        with open(self.smt2_file, 'r') as f:
            script = self.parser.get_script(f)
        return script.get_last_formula()


    def encode_node(self, node: FNode):

        if node in self.node_map:
            return self.node_map[node]
        
        feature = len(ALL_TYPES) * [0]
        feature[node.node_type()] = 1
        self.one_hot_nodes.append(feature)

        idx = len(self.one_hot_nodes)
        self.node_map[node] = idx
        return idx


    def traverse_formula(self, formula: FNode):
        """
        Recursively traverses the formula to extract nodes and edges.
        """
        root_idx = self.encode_node(formula)

        for child in formula.args():
            print(f"Parent Node Type: {formula.node_type()}")
            print(f"Parent Type: {op_to_str(formula.node_type())}")
            print(f"Child Node Type: {child.node_type()}")
            print(f"Child Type: {op_to_str(child.node_type())}")

            child_idx = self.traverse_formula(child)
            self.coo_edges.append([root_idx, child_idx])

        return root_idx

    def build_graph(self):
        """
        Builds the graph representation of the SMT formula.
        """
        formula : FNode = self.parse_smt_file()
        print(f"Parsed SMT file: {formula}")

        # Extract Nodes and Edges from Formula
        self.traverse_formula(formula)

        if not self.one_hot_nodes or not self.coo_edges:
            raise ValueError("Graph construction failed: No nodes or edges found.")

        # Convert Nodes and Edges to Torch
        node_features = torch.tensor(self.one_hot_nodes)
        edge_index = torch.tensor(self.coo_edges).t()

        # Create PyTorch Geometric Data Object
        data = Data(x=node_features, edge_index=edge_index)
        return data

if __name__ == "__main__":
    smt2_file = "Dataset/BV_NI/2017-Preiner-keymaera/accelerating-node2100.smt2"

    graph_builder = SMTFormulaGraph(smt2_file)

    graph_data = graph_builder.build_graph()

    print("Graph Data:")
    print(graph_data)