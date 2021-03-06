clear

$pathFrom = "C:\TFS2010\A534-StaMon\StaMon\Current\MonitoringApp\Configs"
$nameFrom ="App.prod.config"
$pathTo = "C:\Ressources\Stamon\Build"
$nameTo="MonitoringApp.exe.config"
$SemaphoreValueToCheck = "http://semaphore-infrabel/webservices/SemaphoreCertificateService.svc"
$connectionStringToCheck ="User Id=A534;Password=real_m8drid;Server=oratnsioictr2p;SID=IOICTR2P;Direct=True"

$path = $pathFrom + "\" + $nameFrom
$destinantion = $pathTo + "\" + $nameTo

<#Remove and copy configs#>
if(Test-Path -Path $destinantion)
{
    Set-ItemProperty -Path $destinantion -name IsReadOnly -value $false
    Remove-Item -Path $destinantion
}
Copy-Item -Path $path -Destination $destinantion 

<# Check config #>
[xml]$contentConfig = Get-Content -Path $destinantion
<# Semaphore Service #>
[System.Xml.XmlElement]$applicationSettings = $contentConfig.ChildNodes[1].applicationSettings
$Semaphore = $applicationSettings.'BRail.Semaphore.Client.ClientLib.Properties.Settings'.setting | Where-Object {$_.Name -eq 'SemaphoreServiceEndpointAddress'} | Select-Object Value
if($Semaphore.value -eq $SemaphoreValueToCheck)
{
    Write-Output "Semaphore check ok"
}
<# Connection string #>
[System.Xml.XmlElement]$connectionString = [System.Xml.XmlElement]$applicationSettings = $contentConfig.ChildNodes[1].connectionStrings
if($connectionString.add.connectionString -eq $connectionStringToCheck)
{
     Write-Output "Connection string check ok"
}