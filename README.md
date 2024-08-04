# Active Directory Alias Management Script

This PowerShell script allows you to manage user aliases in Active Directory and perform a delta sync with Azure Active Directory. The script provides a simple user interface to add aliases to users and perform synchronization.

## Features

- Add alias to a user's `proxyAddresses` attribute in Active Directory.
- Perform a delta sync with Azure Active Directory.
- User-friendly interface with clear instructions and feedback.

## Prerequisites

- Windows PowerShell
- Active Directory module for Windows PowerShell
- Azure Active Directory Connect installed and configured

## Usage

1. **Clone or download the script:**

2. **Run the script:**

    ```powershell
    .\AliasManagement.ps1
    ```

3. **Follow the prompts:**

    - The script will provide options to either add an alias to a user or exit and perform a delta sync.
    - When adding an alias, you will be prompted to enter the User Principal Name (UPN) and the alias.
    - After adding an alias, the script will update the user in Active Directory and provide feedback.
    - On exiting, the script will perform a delta sync and wait for it to complete before closing.

## Script Walkthrough

### Add Alias

- Prompts for User Principal Name (UPN) and alias.
- Checks if the user exists in Active Directory.
- Checks if the alias is already present in the user's `proxyAddresses` attribute.
- Adds the alias if it is not already present.
- Updates the user object in Active Directory.
- Provides feedback on success or failure.

### Delta Sync

- Runs Azure Active Directory synchronization.
- Waits for the synchronization to complete.
- Provides feedback when the synchronization is complete.

## Example

1. **Starting the script:**

    ```plaintext
    ===== Active Directory Alias Management =====
    Choose an option:
    1. Add alias
    2. Exit
    Enter your choice (1 or 2):
    ```

2. **Adding an alias:**

    ```plaintext
    ===== Add Alias to User =====
    Enter the User Principal Name (UPN) of the user (e.g., user@example.com): user@example.com
    Enter the alias to be added (e.g., alias@example.com): alias@example.com
    Alias 'alias@example.com' added successfully to the user's proxyAddresses attribute.
    Press Enter to continue...
    ```

3. **Exiting and performing delta sync:**

    ```plaintext
    ===== Delta Sync =====
    Waiting for synchronization to finish...
    Azure Active Directory synchronization completed successfully.
    Press Enter to continue...
    ```

## Notes

- Ensure you have the necessary permissions to update user objects in Active Directory and perform synchronization.
- The script uses `Clear-Host` to clear the screen for a better user experience.
- Use appropriate error handling and logging as needed for your environment.

## License

This script is provided under the MIT License. See the LICENSE file for details.

## Contributing

Contributions are welcome! Please submit a pull request or open an issue to discuss changes.

 
