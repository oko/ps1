# `ps1`: Miscellaneous PowerShell Scripts

This is a small collection of potentially-useful scripts for Windows users.

## Display Scripts
### Resolution Reset Fixer
This script fixes situations where display sleep behavior causes Windows to revert to a "simulated" screen size of default 1024x768, resulting in resized windows upon wakeup. See [the Microsoft Answers form post](http://answers.microsoft.com/en-us/windows/forum/windows_7-hardware/windows-7-movesresizes-windows-on-monitor-power/1653aafb-848b-464a-8c69-1a68fbd106aa) for details. The script will set the same resolution for **all** `SIMULATED_*` screen entries described in that post, so this may be unsuitable for mixed-resolution multi-monitor setups (untested).

To use the script:

1.	Run PowerShell as an Administrator
2.	Set the execution policy to "Unrestricted" so that you can run unsigned scripts:
	
		PS1> Set-ExecutionPolicy Unrestricted

3.	`cd` to this repository's download location
4.	Run the reset script:

		PS1> .\display\prevent-resolution-resets.ps1 3840 2160

	The two arguments `3840 2160` should be replaced with the horizontal and vertical resolutions of your display.