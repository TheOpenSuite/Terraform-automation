import yaml
import json
import subprocess
import os
import sys

# Constants
CONFIG_FILE_PATH = "configs/example-project.yaml"
TFVARS_JSON_FILE = "config.auto.tfvars.json"
PLAN_FILE = "tf-deployment.plan"

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
        while True:
            output = process.stdout.readline()
            if output == '' and process.poll() is not None:
                break
            if output:
                print(output.strip())
        rc = process.poll()
        if rc != 0:
            print(f"Error: Command '{' '.join(command)}' failed with exit code {rc}")
            sys.exit(rc)
        return rc
    except FileNotFoundError:
        print(f"Error: Command '{command[0]}' not found. Is it installed and in your PATH?")
        sys.exit(1)
    except Exception as e:
        print(f"An unexpected error occurred: {e}")
        sys.exit(1)

def main():
    """Main function to drive the Terraform deployment."""
    # 1. Load YAML configuration
    print(f"--- Loading configuration from {CONFIG_FILE_PATH} ---")
    try:
        with open(CONFIG_FILE_PATH, "r") as f:
            config = yaml.safe_load(f)
    except FileNotFoundError:
        print(f"Error: Configuration file not found at {CONFIG_FILE_PATH}")
        sys.exit(1)
    except yaml.YAMLError as e:
        print(f"Error parsing YAML file: {e}")
        sys.exit(1)

    print("Configuration loaded successfully.")

    # 2. Convert to .tfvars.json
    print(f"--- Generating {TFVARS_JSON_FILE} ---")
    with open(TFVARS_JSON_FILE, "w") as f:
        json.dump(config, f, indent=2)
    print(f"{TFVARS_JSON_FILE} created successfully.")

    # 3. Run Terraform Init
    print("\n--- Running terraform init ---")
    run_command(["terraform", "init"])

    # 4. Run Terraform Plan and save to file
    print(f"\n--- Running terraform plan and saving to {PLAN_FILE} ---")
    run_command(["terraform", "plan", "-out", PLAN_FILE])

    # 5. Run Terraform Apply using the saved plan file (IAM binding and rest of resources)
    print(f"\n--- Running terraform apply using {PLAN_FILE} ---")
    run_command(["terraform", "apply", PLAN_FILE])

    print("\n--- Deployment process completed! ---")

    # Clean up the generated files
    print("\n--- Cleaning up generated files ---")
    try:
        os.remove(TFVARS_JSON_FILE)
        print(f"Cleaned up {TFVARS_JSON_FILE}.")
    except OSError as e:
        print(f"Warning: Could not remove {TFVARS_JSON_FILE}: {e}")

    try:
        os.remove(PLAN_FILE)
        print(f"Cleaned up {PLAN_FILE}.")
    except OSError as e:
        print(f"Warning: Could not remove {PLAN_FILE}: {e}")


if __name__ == "__main__":
    main()

