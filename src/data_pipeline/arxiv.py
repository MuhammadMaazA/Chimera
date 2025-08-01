from omegaconf import DictConfig
from datasets import load_dataset
from torch.utils.data import DataLoader
from transformers import AutoTokenizer

def get_dataloaders(cfg: DictConfig) -> tuple[DataLoader, DataLoader, AutoTokenizer, int]:
    """
    Downloads, processes, and prepares the ArXiv dataset for training and validation.
    """
    print("--- Initializing Data Pipeline ---")

    print(f"Loading tokenizer: 'distilbert-base-uncased'")
    tokenizer = AutoTokenizer.from_pretrained("distilbert-base-uncased")    

    print(f"Loading dataset: '{cfg.path}', subset: '{cfg.subset}'")
    dataset = load_dataset(
        cfg.path,
        cfg.subset,
        cache_dir=cfg.data_dir # Use data_dir from main.yaml
    )