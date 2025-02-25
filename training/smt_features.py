from collections import defaultdict
from pysmt.shortcuts import And, Not, Or, Symbol, LE, Int, Plus, Equals
from pysmt.smtlib.parser import SmtLibParser
from pysmt.fnode import FNode
from pysmt.operators import ALL_TYPES, op_to_str
from torch_geometric.data import Data
import torch
import numpy as np

class SMTFormulaGraphWithFeatures(SMTFormulaGraph):
    def __init__(self, smt2_file):
        super().__init__(smt2_file)
        self.feature_counters = defaultdict(int)
        self.select_counts = []
        self.store_depths = []
        self.bv_adders = []
    
    def encode_node(self, node: FNode):
        idx = super().encode_node(node)
        self.feature_counters[node.node_type()] += 1
        
        if node.node_type() == op_to_str("Select"):
            self.select_counts.append(1)
        elif node.node_type() == op_to_str("Store"):
            self.store_depths.append(len(node.args()))
        
        return idx
    
    def compute_additional_features(self):
        """
        Compute features like averages, medians, and deviations from counters.
        """
        features = {}
        features['select_avg'] = sum(self.select_counts) / len(self.select_counts) if self.select_counts else 0
        features['store_depth_avg'] = sum(self.store_depths) / len(self.store_depths) if self.store_depths else 0
        features['bv_adder_avg'] = sum(self.bv_adders) / len(self.bv_adders) if self.bv_adders else 0
        return features
    
    def build_graph(self):
        """
        Builds the graph and computes features for the SMT formula.
        """
        data = super().build_graph()
        
        # Compute and add features
        additional_features = self.compute_additional_features()
        data.additional_features = torch.tensor(list(additional_features.values()))
        
        return data
