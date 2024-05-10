"""
Generate a mermaid diagram from a YAML file of Kubernetes manifests.
"""

import sys
import yaml


def generate_mermaid_diagram(yaml_stream):
    """
    Output a list of mermaid nodes after parsing a yaml stream containing
    Kubernetes manifests.
    """

    yaml_string = yaml_stream.read()

    manifests = yaml.safe_load_all(yaml_string)

    mermaid_diagram = "graph LR\n"

    for manifest in manifests:
        if isinstance(manifest, dict):
            kind = manifest.get('kind', '')
            name = manifest.get('metadata', {}).get('name', '')
            if kind and name:
                mermaid_diagram += f"{kind}_{name}({kind}: {name})\n"

    return mermaid_diagram


if __name__ == "__main__":
    given_argv_count = len(sys.argv)
    if given_argv_count == 1:
        file = sys.stdin
    elif given_argv_count == 2:
        file = open(sys.argv[1], 'r', encoding='utf-8')
    else:
        print("Usage: python mermaid.py [<yaml_file>]")
        sys.exit(1)

    print(generate_mermaid_diagram(file))
    file.close()
