clear
$msbuildTool = "C:\Windows\Microsoft.NET\Framework64\v4.0.30319\msbuild.exe"
$buildTarget = "--% C:\TFS2010\A534-StaMon\StaMon\Test\GuiWebApp\GuiWebApp.csproj" 
$LogfilePath = "C:\Ressources\Stamon\Livraisons\TEST\Build\Build.log"
$PublishProfilePath = "C:\Ressources\Stamon\Documents\Local-publish-Test.pubxml"
$builParameter = "/p:Configuration=Debug;TargetFrameworkVersion=v3.5 /fl  /flp:Logfile="+ $LogfilePath + " /p:DeployOnBuild=true /p:PublishProfile=" + $PublishProfilePath + " /p:VisualStudioVersion=11.0"
Invoke-Expression "$msbuildTool $buildTarget $builParameter"
if($LastExitCode -ne 0)
{
	Write-Output 'Build failed see logs'
	throw 'Build Failed'
}

