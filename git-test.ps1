IF (!(Test-Path .\.git)){
    #Create an empty Git repository or reinitialize an existing one
    git init
}

# GIT CONFIG
git config remote.origin.url "https://github.com/JohnCroix/Git-Test.git"
git config --global user.email "johannes@croix.at"
git config --global user.name "$($env:Username)"

# create changes
echo "# Git-Test" | Out-File README.md
get-date | Out-File .\README.md -Append

# compare changes with remote repo
IF ($(git diff | Measure-Object).Count -ge 4){
    Write-Host "[i] change detected"
    Get-ChildItem | %{
        git add ".\$($_.Name)"
    }
    git commit -m "commit $($($(git log) -match "Author").count+1) by $($env:Username)"
    #Upload
    git push --all -q
}


<#
echo "# Git-Test" >> README.md
git init
git add README.md
git commit -m "first commit"
git branch -M main
git remote add origin https://github.com/JohnCroix/Git-Test.git
git push -u origin main
#>
