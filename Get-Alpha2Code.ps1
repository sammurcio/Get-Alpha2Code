param(
    [Parameter(Mandatory=$true)
    [string]$csv
  )

$list = Import-Csv $csv
$outFile = = $env:USERPROFILE + "\Desktop\Countries.csv"

foreach ( $a in $list ) {
  $searchStr = $a.Country.Trim()
  $searchStr = $searchStr.Replace(' ','%20')

  try {
    $result = Invoke-RestMethod -Uri "https://restcountries.eu/rest/v1/name/$($searchStr)?fullText=true)" -ErrorAction Stop
    $result = $result.alpha2Code
  } catch {
    $result = "Unable to find country"
  }

  $obj = [pscustomobject]@{
    Name = $a.Country
    Alpha2 = $result
    }

  $obj | Export-Csv -Path $outFile -NoTypeInformation -Append
}

Write-Output "Results log saved here: $outFile"

