import subprocess
import glob
import os
import sys
import platform

def compile_missions(workspace_dir):
    # Path to the filterscripts directory
    filterscripts_dir = os.path.join(workspace_dir, "filterscripts")

    # Get all .pwn files in the filterscripts directory
    pwn_files = glob.glob(os.path.join(filterscripts_dir, "*.pwn"))

    if not pwn_files:
        print("No .pwn files found in the filterscripts directory.")
        return

    # Check if the operating system is macOS or Windows
    is_mac = platform.system() == "Darwin"
    is_windows = platform.system() == "Windows"
    pawncc_dir = os.path.join(workspace_dir, 'qawno', 'mac') if is_mac else os.path.join(workspace_dir, 'qawno')

    for pwn_file in pwn_files:
        # Extract the mission name from the file path
        mission_name = os.path.basename(pwn_file)
        mission_name = os.path.splitext(mission_name)[0]

        # Define the base command
        command = [
            os.path.join(pawncc_dir, 'pawncc.exe' if is_windows else 'pawncc'),  # Use the appropriate directory
            '-;+', '-(+', '-\\', '-Z-',
            f'-i{os.path.join(filterscripts_dir, mission_name)}',
            f'-i{os.path.join(workspace_dir, "qawno", "include")}',
            '-d3', '-t4',
            f'-o{os.path.join(filterscripts_dir, mission_name)}',
            pwn_file
        ]

        # Append the WINDOWS_COMPILER flag if on Windows
        if is_windows:
            command.append('WINDOWS_COMPILER=1')

        try:
            # Run the command
            result = subprocess.run(
                command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True)

            # Only display if there are warnings or errors
            if result.returncode != 0 or "warning" in result.stdout.lower() or "error" in result.stderr.lower():
                print(f"Compiling mission: {mission_name}")
                if result.stdout:
                    print(f"{mission_name} - Compiler Output:\n{result.stdout}")
                if result.stderr:
                    print(f"{mission_name} - Compiler Errors:\n{result.stderr}")

        except Exception as e:
            print(f"An error occurred while trying to compile {mission_name}: {e}")

if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("Usage: python compile_missions.py <workspace_dir>")
        sys.exit(1)

    # Get workspace directory from command line argument
    workspace_dir = sys.argv[1]
    compile_missions(workspace_dir)
