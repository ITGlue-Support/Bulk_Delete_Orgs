$api_key = "Enter your API key"
$count = 0
$headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
$headers.Add("Content-Type", "application/vnd.api+json")
$headers.Add("x-api-key", $api_key)
$PatchUrl = "https://api.itglue.com/organizations?page[size]=1000"

$response = Invoke-RestMethod $PatchUrl -Method 'GET' -Headers $headers

$totalpage = $response.meta.'total-pages'

for($i=1; $i -le $totalpage; $i++){

$responseGet = Invoke-RestMethod $PatchUrl -Method 'GET' -Headers $headers

$asset_id_list = $responseGet.data.id

<#Delet organizations#>

foreach($id in $asset_id_list)
{
Write-Host "organization_id: "$id

$body = @"
{
    `"data`":
         {          
             `"type`": `"organizations`",
             `"attributes`": {
                `"id`":`"$id`"
             }
         }
 }

"@
$PatchUrldelete = 'https://api.itglue.com/organizations/'
$responsedelete = Invoke-RestMethod $PatchUrldelete -Method 'DELETE' -Headers $headers -Body $body

$count++
Write-Host "Count of item deleted successfully: "$count
}
}
