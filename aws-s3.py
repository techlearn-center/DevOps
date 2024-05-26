import boto3


# Connect to AWS S3 through Boto3
s3 = boto3.client("s3")

#Specify a valid AWS region

region = 'us-east-1'

BUCKETNAME = "techlearnboto3"

# Create S3 Bucket with region constraint
bucketResponse =s3.create_bucket(
        Bucket=BUCKETNAME
)

# Get the bucket name from the response (optional, not needed for upload/download)
#BUCKETNAME = "techlearnboto3"

#Upload Files to the S3 bucket
filePath = "/opt/"
fileToUpload = "2136_kool_form_pack.zip"
fileToS3 = filePath + fileToUpload
s3.upload_file(fileToS3, BUCKETNAME, fileToUpload)
print(f"S3 bucket '{BUCKETNAME}' created successfully in region '{region}'")

# Download File from S3 Bucket
downloadFile = "downloaded_zip_file"
s3.download_file(BUCKETNAME, fileToUpload, downloadFile)

print(f"File '{fileToUpload}' downloaded from S3 bucket '{BUCKETNAME}' as '{downloadFile}'")
