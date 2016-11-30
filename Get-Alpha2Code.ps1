param(
    [string]$csv
  )

$list = Import-Csv $csv

foreach ( $a in $list ) {
  $searchStr = $a.Name.Replace(' ','%20')

  try {
    $result = Invoke-RestMethod -Uri "https://restcountries.eu/rest/v1/name/$($a.Name)?fullText=true)" -ErrorAction Stop
    $result = $result.alpha2Code
  } catch {
    $result = "Unable to find country"
  }

  $obj = [pscustomobject]@{
    Name = $a.Name
    Alpha2 = $result
    }

  $obj | Export-Csv -Path $csv -NoTypeInformation -Append
}

Write-Output "Results log saved here: $csv"

