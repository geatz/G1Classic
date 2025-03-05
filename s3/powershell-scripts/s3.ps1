Import-Module AWS.Tools.S3

$region = "us-east-1"
$bucketName = Read-host -Prompt 'Enter the S3 bucket name'

Write-Host "S3 Bucket: $bucketName"
Write-Host "AWS Region: $region"

function BucketExists {
 $bucket = Get-S3Bucket -BucketName $bucketName -ErrorAction SilentlyContinue
 return $null -ne $bucket
}

if (-not (BucketExists)){
    Write-Host "bucket does not exist"
    New-S3Bucket -BucketName $bucketName -Region $region
} else {
    Write-Host "bucket already exists"
}

$fileName = 'myfile.txt'
$fileContent = 'Hello World'
Set-Content -Path $fileName -Value $fileContent

Write-S3Object -BucketName $bucketName -File $fileName -Key fileName