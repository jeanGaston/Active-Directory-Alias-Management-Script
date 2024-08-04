function Add-Alias {
    # Clear the screen for better UI experience
    Clear-Host
    Write-Host "===== Add Alias to User ====="

    # Prompting for User Principal Name (UPN) and Alias
    $UPN = Read-Host "Enter the User Principal Name (UPN) of the user (e.g., user@example.com)"
    $Alias = Read-Host "Enter the alias to be added (e.g., alias@example.com)"

    # Get the User object from Active Directory
    try {
        $User = Get-ADUser -Filter { UserPrincipalName -eq $UPN } -Properties proxyAddresses -ErrorAction Stop
    } catch {
        Write-Host "Error: User $UPN not found in Active Directory." -ForegroundColor Red
        Pause "Press Enter to continue..."
        return
    }

    # Check if the Alias is already added to the proxyAddresses attribute
    if ($User.proxyAddresses -contains "smtp:$Alias") {
        Write-Host "Alias '$Alias' is already added to the user's proxyAddresses attribute." -ForegroundColor Yellow
        Pause "Press Enter to continue..."
        return
    }

    # Add the Alias to the proxyAddresses attribute
    $User.proxyAddresses += "smtp:$Alias"

    # Update the user object in Active Directory
    try {
        Set-ADUser -Instance $User -ErrorAction Stop
        Write-Host "Alias '$Alias' added successfully to the user's proxyAddresses attribute." -ForegroundColor Green
    } catch {
        Write-Host "Error: Failed to update the user object in Active Directory." -ForegroundColor Red
    }

    Pause "Press Enter to continue..."
}

function Sync-Delta {
    # Clear the screen for better UI experience
    Clear-Host
    Write-Host "===== Delta Sync ====="

    # Run Azure Active Directory synchronization
    Start-ADSyncSyncCycle -PolicyType Delta

    # Check if synchronization jobs are running and wait for them to finish
    do {
        Write-Host "Waiting for synchronization to finish..." -ForegroundColor Cyan
        Start-Sleep -Seconds 10
        $IsSyncInProgress = Get-ADSyncConnectorRunStatus | Where-Object { $_.Status -eq "InProgress" }
    } while ($IsSyncInProgress)

    Write-Host "Azure Active Directory synchronization completed successfully." -ForegroundColor Green
    Pause "Press Enter to continue..."
}

# Main loop
while ($true) {
    Clear-Host
    Write-Host "===== Active Directory Alias Management ====="
    Write-Host "Choose an option:"
    Write-Host "1. Add alias"
    Write-Host "2. Exit"
    $Choice = Read-Host "Enter your choice (1 or 2)"

    switch ($Choice) {
        1 {
            Add-Alias
        }
        2 {
            Sync-Delta
            exit
        }
        default {
            Write-Host "Invalid choice. Please enter 1 or 2." -ForegroundColor Red
            Pause "Press Enter to continue..."
        }
    }
}
