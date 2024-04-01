##################################################################################
## Everything You Always Need to Know About Get-WinEvent (but were afraid to ask)
##################################################################################

## Example A
$codeA = {   
    Get-EventLog -LogName 'Application' -EntryType 'Error', 'Warning' -After (Get-Date).AddHours(-24)
}

## Example B
$codeB = {
    Get-WinEvent -LogName Application |  Where-Object -FilterScript {
      ($_.LevelDisplayName -eq 'Error' -or $_.LevelDisplayName -eq 'Warning') -and $_.TimeCreated -gt (Get-Date).AddHours(-24) 
    }
}

## Example C
$codeC = {
    $filterHt = @{ 
        'Logname'   = 'Application' 
        'Level'     = 2, 3
        'StartTime' = (Get-Date).AddHours(-24) 
    }
    Get-WinEvent -FilterHashtable $filterHt
}

## Example D
$codeD = {
    $filterXml = @'
<QueryList>
  <Query Id="0" Path="Application">
    <Select Path="Application">
    *[System[(Level=2 or Level=3) 
    and TimeCreated[timediff(@SystemTime) &lt;= 86400000]]]
    </Select>
  </Query>
</QueryList>
'@
    Get-WinEvent -FilterXml $filterXML
}

## Example E
$codeE = {
    $filterXPath = '*[System[(Level=2 or Level=3) and TimeCreated[timediff(@SystemTime) <= 86400000]]]'
    Get-WinEvent -LogName Application -FilterXPath $filterXPath
}

## Measure commands
Measure-Command -Expression $codeA | Select-Object -Property @{name = 'Code'; expression = { 'A: Get-EventLog ..' } }, TotalMilliseconds
Measure-Command -Expression $codeB | Select-Object -Property @{name = 'Code'; expression = { 'B: Get-WinEvent .. | Where-Object ..' } }, TotalMilliseconds
Measure-Command -Expression $codeC | Select-Object -Property @{name = 'Code'; expression = { 'C: Get-WinEvent -FilterHashtable .. ' } }, TotalMilliseconds
Measure-Command -Expression $codeD | Select-Object -Property @{name = 'Code'; expression = { 'D: Get-WinEvent -FilterXml ..' } }, TotalMilliseconds
Measure-Command -Expression $codeE | Select-Object -Property @{name = 'Code'; expression = { 'E: Get-WinEvent -FilterXPath ..' } }, TotalMilliseconds