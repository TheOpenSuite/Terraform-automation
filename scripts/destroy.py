import yaml
import json
import subprocess
import os
import sys

def run_command(command, working_dir="."):
    """Executes a shell command and streams its output."""
    try:
        process = subprocess.Popen(
            command,
            cwd=working_dir,
            stdout=subprocess.PIPE,
            stderr=subprocess.STDOUT,
            text=True,
            bufsize=1
        )
        # Stream output in real-time
        for line in iter(process.stdout.readline, ''):
            print(line, end='')
        process.stdout.close()
        rc = process.wait()
        if rc != 0:
            print(f"\nError: Command '{' '.join(command)}' failed with exit code {rc}", file=sys.stderr)
            sys.exit(rc)
        return rc
    except FileNotFoundError:
        print(f"Error: Command '{command[0]}' not found. Is it installed and in your PATH?", file=sys.stderr)
        sys.exit(1)
    except Exception as e:
        print(f"An unexpected error occurred: {e}", file=sys.stderr)
        sys.exit(1)

def main():
    """Main function to drive the Terraform destruction."""
    # Determine the config file to use
    if len(sys.argv) > 1:
        config_file_path = sys.argv[1]
    else:
        config_file_path = "configs/example-project.yaml"
        print(f"Warning: No config file provided. Defaulting to {config_file_path}\n")

    if not os.path.exists(config_file_path):
        print(f"Error: Configuration file not found at {config_file_path}", file=sys.stderr)
        sys.exit(1)

    # 1. Load YAML configuration
    print(f"--- Loading configuration from {config_file_path} ---")
    try:
        with open(config_file_path, "r") as f:
            config = yaml.safe_load(f)
    except yaml.YAMLError as e:
        print(f"Error parsing YAML file: {e}", file=sys.stderr)
        sys.exit(1)
    
    print("Configuration loaded successfully.")
    
    # 2. Convert to .tfvars.json to ensure Terraform knows all variables
    tfvars_file = "config.auto.tfvars.json"
    print(f"--- Generating {tfvars_file} ---")
    with open(tfvars_file, "w") as f:
        json.dump(config, f, indent=2)
    print(f"{tfvars_file} created successfully.")

    # 3. Run Terraform Init
    print("\n--- Running terraform init ---")
    run_command(["terraform", "init", "-reconfigure"])

    # 4. Run Terraform Destroy
    print("\n--- Running terraform destroy ---")
    run_command(["terraform", "destroy", "-auto-approve"])

    print("\n--- Destruction process completed! ---")

    # 5. Clean up the generated tfvars file
    os.remove(tfvars_file)
    print(f"Cleaned up {tfvars_file}.")

if __name__ == "__main__":
    main()

