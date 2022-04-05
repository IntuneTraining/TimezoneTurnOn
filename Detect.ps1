$ServiceName = 'tzautoupdate'
$Action = 'Manual'
$Service = Get-Service -Name $ServiceName -ErrorAction SilentlyContinue

If ($service.StartType -eq $Action) {
    Write-Host "$ServiceName is already configured correctly."
    Exit 0
}
else {
    Write-Warning "$ServiceName is not configured correctly."
    Exit 1
}