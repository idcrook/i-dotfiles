# Borrowed code from https://gist.github.com/Codebytes/29bf18015f6e93fca9421df73c6e512c
#Install New apps
Write-Output "Installing Apps"
$apps = @(
    @{name = "Microsoft.VisualStudioCode" },
    @{name = "Git.Git" }, 
    #     @{name = "Microsoft.PowerToys" }, 
    #     @{name = "Microsoft.WindowsTerminal"; source = "msstore" }, 
    @{name = "RealVNC.VNCViewer" },
    @{name = "7zip.7zip" },
    @{name = "calibre.calibre" },
    @{name = "VideoLAN.VLC" },
    @{name = "joncampbell123.DOSBox-X" },
    @{name = "Docker.DockerDesktop" },
    @{name = "CodeSector.TeraCopy" },
    @{name = "GitHub.GitHubDesktop" }
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
