$RemoteOriginUrl = "https://github.com/JohnCroix/Git-Test.git"
$UserName = "$($env:Username)"
$UserMail = "dev@croix.at"
$ProjectName = "Git-Test"

#Create an empty Git repository or reinitialize an existing one
IF (!(Test-Path .\.git)){
    git init
}

# GIT CONFIG
git config remote.origin.url $RemoteOriginUrl
git config --global user.email $UserMail
git config --global user.name $UserName

# create changes
echo "# $($ProjectName)" | Out-File README.md
get-date | Out-File .\README.md -Append

# compare changes with remote repo
IF ($(git diff | Measure-Object).Count -ge 4){
    Write-Host "[i] change detected"
    Get-ChildItem | %{
        git add ".\$($_.Name)"
    }
    git commit -m "commit $($($(git log) -match "Author").count+1) by $($UserName)"
    git push --all -q
}