# CE-158(X) build script
# Usage: './build.psa -l' builds left bank, '-r' right bank
#        './build.psa -b NAME' builds both banks and merge into file 'CE-158_ROM_NAME.bin'
# Building also creates a function map for each bank named 'CE-158_ROM_LOW.NAME.FMap'
# by - Hey Birt!

$bank = ''
$Env:TASMTABS = $Env:TASM + "\tasmTab\"
$exe = $Env:TASM + '\tasm323\Tasm323.exe'

# Create a 'build recipie' based on arguments passed
switch ($args[0]) 
{
    '-l' {$bank = 'LOW',''; Break}
    '-h' {$bank = 'HIGH',''; Break}
    '-b' {$bank = 'LOW', 'HIGH'; Break}
}

Write-Output "Will build bank(s): $bank"

# Loop through each recipie entry and build it
for ($i = 0; $i -lt $bank.count; $i++) 
{
    $bob = $bank[$i]

    if ($bob -ne '') 
    {
        $out_name = "CE-158_ROM_$bob.lh5801.asm"

        Write-Host "Building $out_name"
        & $exe -x7 -g3 -5801 $out_name 

        Start-Sleep -Seconds 1 # give time for .bin file to appear

        # We need to rename the .obj output by TASM to .bin
        if ([System.IO.File]::Exists("CE-158_ROM_$bob.bin")) {
            Remove-Item -Path "CE-158_ROM_$bob.bin"
        }
        else {
            Write-Host ""CE-158_ROM_$bob.bin" not found"
        }

        if ([System.IO.File]::Exists("CE-158_ROM_$bob.obj")) {
            Rename-Item -Path "CE-158_ROM_$bob.obj" -NewName "CE-158_ROM_$bob.bin"
        }
        else {
            Write-Host "CE-158_ROM_$bob.obj not found"
        }

        #Create a function map from .lst file and then prepend header to it
        $bobB = $bob
        if ($args[0] -eq '-b') {$bobB = "$bobB.$($args[1])"}
        Get-Content "CE-158_ROM_$bob.lst" | select-string -pattern ";%" -encoding ASCII | Set-Content "CE-158_ROM_$bob.FMap"
        Start-Sleep -Seconds 1 # give time for .FMap file to appear
        @("Line   Address          Name") + (Get-Content "CE-158_ROM_$bob.FMap") | Set-Content "CE-158_ROM_$bobB.FMap"
        Write-Host "$bob Bank Function Map generated"
    }

}

#Merge High and Low banks into one file with arg(1) appended to name
if ($args[0] -eq '-b')
{
    $mFile='CE-158_ROM_'
    if ($args.count -gt 1) {
        $mFile = $mFile + $args[1]
    }
    
    $mFile = $mFile + '.bin'
    Get-Content -Raw CE-158_ROM_LOW.bin, CE-158_ROM_HIGH.bin | Set-Content -NoNewline $mFile
    Write-Host "Banks merged into $mFile"
}

