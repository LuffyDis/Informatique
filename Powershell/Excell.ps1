clear
$XLSDoc = "C:\Ressources\Stamon\Documents\Configs.xls"
$SheetName = "Sheet1"
$Excel = New-Object -ComObject "Excel.Application"

$Workbook = $Excel.workbooks.open($XLSDoc)
$Sheet = $Workbook.Worksheets.Item($SheetName)

<#---------Monitoring----------------#>
<#-----------------------------------#>

<#--- Copy bin ---#>
$dateMonitoring = Get-Date -format yyyy-MM-dd
[String]$SourceCodeMonitoring = $Sheet.Cells.Item(23,8).Text +'bin\Debug\' + '\*'
[String]$TargetCodeMonitoring = $Sheet.Cells.Item(23,13).Text + '\' + $dateMonitoring + '\MonitoringApp'

Write-Output $SourceCodeMonitoring
Write-Output $TargetCodeMonitoring
Write-Output $dateMonitoring

if(Test-Path -Path $TargetCodeMonitoring)
{
	$configMonitoringToDelete= $TargetCodeMonitoring + '\MonitoringApp.exe.config' 
	Set-ItemProperty -Path $configMonitoringToDelete -name IsReadOnly -value $false
    Remove-Item -Path $TargetCodeMonitoring -Recurse
    New-Item -ItemType directory -Path $TargetCodeMonitoring
}
else
{
    New-Item -ItemType directory -Path $TargetCodeMonitoring
}

Copy-Item $SourceCodeMonitoring $TargetCodeMonitoring -recurse

<#--- Delete files ---#>
<# Delete MonitoringApp.vshost.exe , 
          MonBatch.log , 
          MonBatchInfo.log , 
          MonitoringApp.vshost.exe.config , 
          MonitoringApp.exe.config#>

$filePathMonitoring = $TargetCodeMonitoring + '\MonitoringApp.vshost.exe' 
if(Test-Path $filePathMonitoring)
{
    Remove-Item $filePathMonitoring
}

$filePathMonitoring = $TargetCodeMonitoring + '\MonBatch.log' 
if(Test-Path $filePathMonitoring)
{
    Remove-Item $filePathMonitoring
}

$filePathMonitoring = $TargetCodeMonitoring + '\MonBatchInfo.log' 
if(Test-Path $filePathMonitoring)
{
    Remove-Item $filePathMonitoring
}

$filePathMonitoring = $TargetCodeMonitoring + '\MonitoringApp.vshost.exe.config' 
if(Test-Path $filePathMonitoring)
{
    Remove-Item $filePathMonitoring
}

$filePathMonitoring = $TargetCodeMonitoring + '\MonitoringApp.exe.config' 
if(Test-Path $filePathMonitoring)
{
    Remove-Item $filePathMonitoring
}

<#--- Copy configs ---#>
$SourceConfigCode = $Sheet.Cells.Item(23,8).Text + 'Configs\App.tst.config'
$TargeConfigCode = $TargetCodeMonitoring + '\MonitoringApp.exe.config'
Copy-Item -Path $SourceConfigCode -Destination $TargeConfigCode

<#--- Check configs ---#>
[xml]$contentConfig = Get-Content -Path $TargeConfigCode
<#-- 1. Connection string--#> 
[System.Xml.XmlElement]$connectionString = [System.Xml.XmlElement]$contentConfig.ChildNodes[1].connectionStrings
$connectionStringToCompare = $Sheet.Cells.Item(8,3).Text
if($connectionString.add.connectionString -ne $connectionStringToCompare)
{
	Write-Error 'The monitoring connection string is not well formatted'
}
Write-Output 'The monitoring connection string is well formatted'
<#-- 2. Service Semaphore--#>
[System.Xml.XmlElement]$ServiceSemaphore = [System.Xml.XmlElement]$contentConfig.ChildNodes[1].applicationSettings.'BRail.Semaphore.Client.ClientLib.Properties.Settings'
$ServiceSemaphoreToCompare = $Sheet.Cells.Item(8,8).Text
if($ServiceSemaphore.setting.value -ne $ServiceSemaphoreToCompare)
{
	Write-Error 'The monitoring service semaphore is not well formatted'
}
Write-Output 'The monitoring service semaphore is well formatted'
<#-- 3. Name semaphore--#>
$SemaphoreName = [System.Xml.XmlElement]$contentConfig.ChildNodes[1].applicationSettings.'MonitoringApp.Properties.Settings'
$SemaphoreNameToCompare = $Sheet.Cells.Item(13,3).Text
if($SemaphoreName.Setting.value -ne $SemaphoreNameToCompare)
{
	Write-Error 'The monitoring semaphore name is not well formatted'
}
Write-Output 'The monitoring semaphore name is well formatted'
<#-- 4. Version--#>
<#-- 5. Mail url--#>
<#-- 6. Mail urn--#>
<#-- 7. Environment--#>
<#-- 8. Log erreurs--#>
[System.Xml.XmlElement]$LogError = [System.Xml.XmlElement]$contentConfig.ChildNodes[1].loggingConfiguration.listeners.ChildNodes[0]
$LogErrorToCompare = $Sheet.Cells.Item(18,13).Text
if($LogError.fileName -ne $LogErrorToCompare)
{
	Write-Error 'The monitoring log error path is not well formatted'
}
Write-Output 'The monitoring log error path is well formatted'
<#-- 9. Log infos--#>
[System.Xml.XmlElement]$LogInfo = [System.Xml.XmlElement]$contentConfig.ChildNodes[1].loggingConfiguration.listeners.ChildNodes[1]
$LogInfoToCompare = $Sheet.Cells.Item(18,17).Text
if($LogInfo.fileName -ne $LogInfoToCompare)
{
	Write-Error 'The monitoring log info path is not well formatted'
}
Write-Output 'The monitoring log info path is well formatted'

<#---------Transfert----------------#>
<#-----------------------------------#>

<#--- Copy bin ---#>
$dateTransfert = Get-Date -format yyyy-MM-dd
[String]$SourceCodeTransfert = $Sheet.Cells.Item(47,8).Text +'bin\Debug\' + '\*'
[String]$TargetCodeTransfert = $Sheet.Cells.Item(47,13).Text + '\' + $dateTransfert + '\TransfertApp'

Write-Output $SourceCodeTransfert
Write-Output $TargetCodeTransfert
Write-Output $dateTransfert

if(Test-Path -Path $TargetCodeTransfert)
{
	$configTransfertToDelete= $TargetCodeTransfert + '\TransferApp.exe.config' 
	Set-ItemProperty -Path $configTransfertToDelete -name IsReadOnly -value $false
    Remove-Item -Path $TargetCodeTransfert -Recurse
    New-Item -ItemType directory -Path $TargetCodeTransfert
}
else
{
    New-Item -ItemType directory -Path $TargetCodeTransfert
}

Copy-Item $SourceCodeTransfert $TargetCodeTransfert -recurse

<#--- Delete files ---#>
<# Delete TransferApp.vshost.exe , 
          Batch.log , 
          BatchInfo.log , 
          TransferApp.vshost.exe.config , 
          TransferApp.exe.config#>

$filePatTransfert = $TargetCodeTransfert + '\TransferApp.vshost.exe' 
if(Test-Path $filePatTransfert)
{
    Remove-Item $filePatTransfert
}

$filePatTransfert = $TargetCodeTransfert + '\Batch.log' 
if(Test-Path $filePatTransfert)
{
    Remove-Item $filePatTransfert
}

$filePatTransfert = $TargetCodeTransfert + '\BatchInfo.log' 
if(Test-Path $filePatTransfert)
{
    Remove-Item $filePatTransfert
}

$filePatTransfert = $TargetCodeTransfert + '\TransferApp.vshost.exe.config' 
if(Test-Path $filePatTransfert)
{
    Remove-Item $filePatTransfert
}

$filePatTransfert = $TargetCodeTransfert + '\TransferApp.exe.config' 
if(Test-Path $filePatTransfert)
{
    Remove-Item $filePatTransfert
}

<#--- Copy configs ---#>
$SourceConfigCode = $Sheet.Cells.Item(47,8).Text + 'Configs\App.tst.config'
$TargeConfigCode = $TargetCodeTransfert + '\TransferApp.exe.config'
Copy-Item -Path $SourceConfigCode -Destination $TargeConfigCode

<#--- Check configs ---#>
[xml]$contentConfig = Get-Content -Path $TargeConfigCode
<#-- 1. Connection string--#> 
[System.Xml.XmlElement]$connectionString = [System.Xml.XmlElement]$contentConfig.ChildNodes[1].connectionStrings
$connectionStringToCompare = $Sheet.Cells.Item(32,3).Text
if($connectionString.add.connectionString -ne $connectionStringToCompare)
{
	Write-Error 'The transfert connection string is not well formatted'
}
Write-Output 'The transfert connection string is well formatted'
<#-- 2. Service Semaphore--#>
[System.Xml.XmlElement]$ServiceSemaphore = [System.Xml.XmlElement]$contentConfig.ChildNodes[1].applicationSettings.'BRail.Semaphore.Client.ClientLib.Properties.Settings'
$ServiceSemaphoreToCompare = $Sheet.Cells.Item(32,8).Text
if($ServiceSemaphore.setting.value -ne $ServiceSemaphoreToCompare)
{
	Write-Error 'The transfert service semaphore is not well formatted'
}
Write-Output 'The transfert service semaphore is well formatted'
<#-- 3. Name semaphore--#>
$SemaphoreName = [System.Xml.XmlElement]$contentConfig.ChildNodes[1].applicationSettings.'TransferApp.Properties.Settings'.ChildNodes[0]
$SemaphoreNameToCompare = $Sheet.Cells.Item(37,3).Text
if($SemaphoreName.value -ne $SemaphoreNameToCompare)
{
	Write-Error 'The transfert semaphore name is not well formatted'
}
Write-Output 'The transfert semaphore name is well formatted'
<#-- 4. Version--#>
<#-- 5. Mail url--#>
<#-- 6. Mail urn--#>
<#-- 7. Environment--#>
<#-- 8. Log erreurs--#>
[System.Xml.XmlElement]$LogError = [System.Xml.XmlElement]$contentConfig.ChildNodes[1].loggingConfiguration.listeners.ChildNodes[0]
$LogErrorToCompare = $Sheet.Cells.Item(42,13).Text
if($LogError.fileName -ne $LogErrorToCompare)
{
	Write-Error 'The transfert log error path is not well formatted'
}
Write-Output 'The transfert log error path is well formatted'
<#-- 9. Log infos--#>
[System.Xml.XmlElement]$LogInfo = [System.Xml.XmlElement]$contentConfig.ChildNodes[1].loggingConfiguration.listeners.ChildNodes[1]
$LogInfoToCompare = $Sheet.Cells.Item(42,17).Text
if($LogInfo.fileName -ne $LogInfoToCompare)
{
	Write-Error 'The transfert log info path is not well formatted'
}
Write-Output 'The transfert log info path is well formatted'

<#---------Web application----------------#>
<#----------------------------------------#>
$dateWebApp = Get-Date -format yyyy-MM-dd
<#-Build and Publish in temporary folder-#>
<#- Delete Temporary Path -#>
$TemporaryFolderPath = $Sheet.Cells.Item(72,8).Text
if(Test-Path $TemporaryFolderPath)
{
	Remove-Item -Path $TemporaryFolderPath -Recurse
	Write-Output 'Remove temporary path'
}
<#--Build and publish--#>
$msbuildTool = "C:\Windows\Microsoft.NET\Framework64\v4.0.30319\msbuild.exe"
$buildTarget = "--% "+ $Sheet.Cells.Item(72,3).Text
$LofFileName = $dateWebApp + "-WebApp.log"
$LogfilePath = "C:\Ressources\Stamon\Livraisons\TEST\Build\" + $LofFileName
$PublishProfilePath = "C:\Ressources\Stamon\Documents\Local-publish-Test.pubxml"
$builParameter = "/p:Configuration=Debug;TargetFrameworkVersion=v3.5 /fl  /flp:Logfile="+ $LogfilePath + " /p:DeployOnBuild=true /p:PublishProfile=" + $PublishProfilePath + " /p:VisualStudioVersion=11.0"
Invoke-Expression "$msbuildTool $buildTarget $builParameter"
if($LastExitCode -ne 0)
{
	Write-Output 'Build failed see logs'
	throw 'Build Failed'
}
<#--Copy and replace and check configs --#>
[String]$TargetCodeWeb = $Sheet.Cells.Item(72,13).Text + '\' + $dateTransfert + '\WebApp'
Write-Output $TargetCodeWeb

if(Test-Path -Path $TargetCodeWeb)
{
	$configWebToDelete= $TargetCodeWeb + '\web.config' 
	Set-ItemProperty -Path $configWebToDelete -name IsReadOnly -value $false
    Remove-Item -Path $TargetCodeWeb -Recurse
    New-Item -ItemType directory -Path $TargetCodeWeb
}
else
{
    New-Item -ItemType directory -Path $TargetCodeWeb
}
$SourceCodeWebb = $TemporaryFolderPath + '\*'
Copy-Item $SourceCodeWebb $TargetCodeWeb -recurse
<#--Remove config--#>
$configWebToDelete= $TargetCodeWeb + '\web.config' 
Set-ItemProperty -Path $configWebToDelete -name IsReadOnly -value $false
Remove-Item -Path $configWebToDelete -Recurse
$configWebFrom = $TargetCodeWeb + '\Configs\Web.tst.config'
$ConfigWebTo = $TargetCodeWeb + '\web.config' 
Copy-Item $configWebFrom $ConfigWebTo
$configFolder = $TargetCodeWeb + '\Configs'
Remove-Item $configFolder -Recurse
<#--Check configs--#>
$contentConfig = Get-Content $ConfigWebTo
$connectionStringWeb = $Sheet.Cells.Item(57,3).Text
$VersionWeb = $Sheet.Cells.Item(57,13).Text
$ServiceUrlWeb = $Sheet.Cells.Item(57,8).Text
$FallBackUrl = $Sheet.Cells.Item(62,3).Text
$SessionState = $Sheet.Cells.Item(62,8).Text
<#-- 1. Connection string--#>
[System.Xml.XmlElement]$ConnectionstringWebToCheck = [System.Xml.XmlElement]$contentConfig.ChildNodes[1].connectionStrings
if($ConnectionstringWebToCheck.add.connectionString -ne $connectionStringWeb)
{
	Write-Error 'The web connection string is not well formatted'
}
Write-Output 'The web connection string is well formatted'
<#-- 1. Version--#>
[System.Xml.XmlElement]$versionWebToCheck = [System.Xml.XmlElement]$contentConfig.ChildNodes[1].appSettings.ChildNodes[2]
if($versionWebToCheck.value -ne $VersionWeb)
{
	Write-Error 'The web version is not well formatted'
}
Write-Output 'The web version is well formatted'
<#-- 2. Version--#>
[System.Xml.XmlElement]$versionWebToCheck = [System.Xml.XmlElement]$contentConfig.ChildNodes[1].appSettings.ChildNodes[2]
if($versionWebToCheck.value -ne $VersionWeb)
{
	Write-Error 'The web version is not well formatted'
}
Write-Output 'The web version is well formatted'
<#-- 3. ServiceUrlWeb--#>
[System.Xml.XmlElement]$ServiceUrlWebToCheck = [System.Xml.XmlElement]$contentConfig.ChildNodes[1].applicationPortal
if($ServiceUrlWebToCheck.serviceUrl -ne $ServiceUrlWeb)
{
	Write-Error 'The service url web is not well formatted'
}
Write-Output 'The service url web is well formatted'
<#-- 4. FallbackUrl--#>
[System.Xml.XmlElement]$FallbackUrlWebToCheck = [System.Xml.XmlElement]$contentConfig.ChildNodes[1].applicationPortal.msnetSingleSignOn
if($FallbackUrlWebToCheck.fallbackUrl -ne $FallBackUrl)
{
	Write-Error 'The FallbackUrl web is not well formatted'
}
Write-Output 'The FallbackUrl web is well formatted'
<#-- 5. $SessionState--#>
[System.Xml.XmlElement]$SessionStateToCheck = [System.Xml.XmlElement]$contentConfig.ChildNodes[1].'system.web'.sessionState
if($SessionStateToCheck.sqlConnectionString -ne $SessionState)
{
	Write-Error 'The SessionState web is not well formatted'
}
Write-Output 'The SessionState web is well formatted'
$Excel.Quit()