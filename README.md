# TimezoneTurnOn

## Overview

Scripts to manage **"Auto Time Zone Updater"** 'tzautoupdate' service on a Windows device. Intended to be used as part of a "Proactive Remediations", now just "Remediations", in Microsoft Intune to automatically adjust the system's time zone.

In a scenario where a Windows device has been deployed using Autopilot, the automatic adjustment of the system's time zone becomes very important. By default, every Windows device starts out with the time zone set to Pacific Time (UTC-08:00), which is not ideal. The 'tzautoupdate' service, when enabled, allows Windows to automatically adjust the system's time zone based on the device's location. Particularly useful for devices that move between different time zones.

However, during an Autopilot deployment, the 'tzautoupdate' service is not always enabled. This is where this scripts come into play. They ensure that 'tzautoupdate' service is set to Manual, allowing the system to automatically adjust its time zone based on its location. This avoids potential issues caused by incorrect time zone settings, should be important part of any Autopilot deployment.

## Scripts

- **`Detect.ps1`** It checks whether the Windows Time Zone Auto Update service (tzautoupdate) is configured to start manually. 
Script stores the name of the service and the desired start-up setting in variables, then tries to get the service object, suppressing errors if the service is not found. It Returns the appropriate message and exits based on the comparison.

- **`Remediate.ps1`** Sets 'tzautoupdate' service to Manual. It enables the "Automatic Time Zone" service (tzautoupdate) which fixes the time zone to be automatically configured using location services when Autopilot has been set up to hide Privacy Settings. Remember to also configure a Configuration Profile to enable "Location Services". Script defines a function to manage services, which takes the service name and the action to be performed as parameters. It then calls this function to manage the 'tzautoupdate' service, setting it to Manual. IF it worked it exits with a success status code (0).

## Usage

`Detect.ps1` and `Fix.ps1` scripts are designed to be used with Microsoft Intune's "Remediations" feature in the "Devices" section or space. 

Here's a step-by-step guide on how to use these scripts:

1. **Create a new Remediations script in Microsoft Intune.** Navigate to the "Devices" section. Select "Remediations" and click on "+ Create script package".

2. **Fill in the basic information.** Provide a name and description for the script package. Could be something like "Enable Auto Time Zone Update".

3. **Upload the scripts.** In the "Detection script" field, upload the `Detect.ps1` script. In the "Remediation script" field, upload the `Remediate.ps1` script. 

4. **Configure script settings.** Set the script type to "PowerShell", and set "Run this script using the logged-on credentials" to "No". Also, set "Enforce script signature check" to "No".

5. **Assign the script package.** Assign the script package to a group of devices where you want to enable the automatic time zone update.

6. **Monitor script performance.** Once the script package is assigned, you can monitor its performance in the "Remediations" dashboard. You can see how many devices have successfully enabled the 'tzautoupdate' service, and how many devices have failed.

Remember, remediation script will only run if the detection script exits with a non-zero exit code, indicating that the 'tzautoupdate' service is not set to Manual.


## Disclaimer
This script is provided as-is with no warranties or guarantees of any kind. Always test scripts and tools in a controlled environment before deploying them in a production setting.


