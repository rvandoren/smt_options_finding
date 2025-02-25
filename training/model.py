import torch
import torch.nn as nn
import torch.optim as optim
from torch_geometric.nn import GCNConv, global_mean_pool
from torch_geometric.data import DataLoader
from torch.utils.data import Dataset
from pysmt.operators import ALL_TYPES

class GNNRegressionModel(nn.Module):
    def __init__(self, input_dim_graph, input_dim_options, hidden_dim=64):
        super(GNNRegressionModel, self).__init__()

        self.conv1 = GCNConv(input_dim_graph, hidden_dim)
        self.conv2 = GCNConv(hidden_dim, hidden_dim)
        
        self.mlp_options = nn.Sequential(
            nn.Linear(input_dim_options, hidden_dim),
            nn.ReLU(),
            nn.Linear(hidden_dim, hidden_dim)
        )
        
        self.regressor = nn.Sequential(
            nn.Linear(hidden_dim * 2, hidden_dim),
            nn.ReLU(),
            nn.Linear(hidden_dim, 1)
        )

    def forward(self, graph_data, options_features):
        x, edge_index, batch = graph_data.x, graph_data.edge_index, graph_data.batch
        x = self.conv1(x, edge_index)
        x = torch.relu(x)
        x = self.conv2(x, edge_index)
        x = torch.relu(x)
        graph_embedding = global_mean_pool(x, batch)  # Global pooling

        options_embedding = self.mlp_options(options_features)

        combined = torch.cat([graph_embedding, options_embedding], dim=1)
        
        out = self.regressor(combined)
        return out.squeeze()

class SMTDataset(Dataset):
    def __init__(self, graphs, option_features, times):
        self.graphs = graphs
        self.option_features = torch.tensor(option_features, dtype=torch.float)
        self.times = torch.tensor(times, dtype=torch.float)
    
    def __len__(self):
        return len(self.graphs)

    def __getitem__(self, idx):
        return self.graphs[idx], self.option_features[idx], self.times[idx]

def train(model, loader, optimizer, criterion, device):
    model.train()
    total_loss = 0
    for graph, options, time in loader:
        graph = graph.to(device)
        options = options.to(device)
        time = time.to(device)

        optimizer.zero_grad()
        pred = model(graph, options)
        loss = criterion(pred, time)
        loss.backward()
        optimizer.step()
        total_loss += loss.item()
    return total_loss / len(loader)

class GNNRankingModel(nn.Module):
    def __init__(self, input_dim_graph, input_dim_options, hidden_dim=64):
        super(GNNRankingModel, self).__init__()

        self.conv1 = GCNConv(input_dim_graph, hidden_dim)
        self.conv2 = GCNConv(hidden_dim, hidden_dim)

        self.mlp_options = nn.Sequential(
            nn.Linear(input_dim_options, hidden_dim),
            nn.ReLU(),
            nn.Linear(hidden_dim, hidden_dim)
        )

        self.scorer = nn.Sequential(
            nn.Linear(hidden_dim * 2, hidden_dim),
            nn.ReLU(),
            nn.Linear(hidden_dim, 1)  # Score for each option
        )

    def forward(self, graph_data, options_features):
        x, edge_index, batch = graph_data.x, graph_data.edge_index, graph_data.batch
        x = self.conv1(x, edge_index)
        x = torch.relu(x)
        x = self.conv2(x, edge_index)
        x = torch.relu(x)
        graph_embedding = global_mean_pool(x, batch)

        graph_embedding = graph_embedding.unsqueeze(1).repeat(1, options_features.size(1), 1)
        options_embedding = self.mlp_options(options_features)
        combined = torch.cat([graph_embedding, options_embedding], dim=-1)

        scores = self.scorer(combined).squeeze(-1)
        return scores

# Updated dataset to allow multiple options per graph
class SMTDataset(Dataset):
    def __init__(self, graphs, option_features, scores):
        self.graphs = graphs
        self.option_features = [torch.tensor(f, dtype=torch.float) for f in option_features]
        self.scores = [torch.tensor(s, dtype=torch.float) for s in scores]

    def __len__(self):
        return len(self.graphs)

    def __getitem__(self, idx):
        return self.graphs[idx], self.option_features[idx], self.scores[idx]

# Updated training loop
def train(model, loader, optimizer, criterion, device):
    model.train()
    total_loss = 0
    for graph, options, scores in loader:
        graph = graph.to(device)
        options = options.to(device)
        scores = scores.to(device)

        optimizer.zero_grad()
        pred_scores = model(graph, options)
        loss = criterion(pred_scores, scores)
        loss.backward()
        optimizer.step()
        total_loss += loss.item()
    return total_loss / len(loader)