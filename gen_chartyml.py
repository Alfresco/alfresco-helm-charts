import os
import yaml

def list_subfolders(folder_path):
    """
    List subfolders and return a dict, each key is a folder name
    """
    return {f.name for f in os.scandir(folder_path) if f.is_dir()}

def load_existing_yaml(file_path):
    """
    Load an existing charts yml or return an empty one
    """
    default_charts = {'charts': {}}
    try:
        with open(file_path, 'r', encoding="utf-8") as yaml_file:
            existing_file_data = yaml.safe_load(yaml_file)
            return existing_file_data if existing_file_data else default_charts
    except FileNotFoundError:
        return default_charts

def write_yaml_file(data, file_path):
    """
    Dump yaml to disk
    """
    with open(file_path, 'w', encoding="utf-8") as yaml_file:
        yaml.dump(data, yaml_file, default_flow_style=False)

if __name__ == "__main__":
    YAML_FILE_PATH = 'charts.yaml'
    CHARTS_PATH = 'charts'

    subfolders = list_subfolders(CHARTS_PATH)
    data = {"charts": subfolders}

    existing_data = load_existing_yaml(YAML_FILE_PATH)
    for entry in data['charts']:
        existing_data['charts'].setdefault(entry)

    write_yaml_file(existing_data, YAML_FILE_PATH)