# Borrowed code from https://gist.github.com/Codebytes/29bf18015f6e93fca9421df73c6e512c
#Install New apps
Write-Output "Installing Apps"
$apps = @(
    @{name = "OpenSCAD" }, 
    @{name = "OpenJSCAD"; source = "msstore" }, 
    @{name = "Ultimaker.Cura" }, 
    @{name = "FreeCAD.FreeCAD" }, 
    @{name = "KiCad.KiCad" }, 
    @{name = "Prusa3D.PrusaSlicer" }
);

Foreach ($app in $apps) {
    $listApp = winget list --exact -q $app.name
    if (![String]::Join("", $listApp).Contains($app.name)) {
        Write-host "Installing:" $app.name
        if ($app.source -ne $null) {
            winget install --exact --silent $app.name --source $app.source
        }
        else {
            winget install --exact --silent $app.name 
        }
    }
    else {
        Write-host "Skipping Install of " $app.name
    }
}
