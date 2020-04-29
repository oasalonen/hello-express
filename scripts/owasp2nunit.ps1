# Convert OWASP ZAP report to an NUnit compatible format
# original from https://dev.azure.com/francislacroix/_git/CodeShare?path=%2FOWASPBlog%2FOWASPToNUnit3.xslt
$XslPath = "$($Env:SYSTEM_DEFAULTWORKINGDIRECTORY)/_oasalonen.hello-express/drop/scripts/owasp2nunit.xslt"
$XmlInputPath = "$($Env:SYSTEM_DEFAULTWORKINGDIRECTORY)/report.xml"
$XmlOutputPath = "$($Env:SYSTEM_DEFAULTWORKINGDIRECTORY)/nunit-zap-report.xml"
$XslTransform = New-Object System.Xml.Xsl.XslCompiledTransform
$XslTransform.Load($XslPath)
$XslTransform.Transform($XmlInputPath, $XmlOutputPath)