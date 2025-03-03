#!/bin/bash

# Function to create a ZIP file 
create_zip() {
   local input_path="$1"
   local timestamp=$(date +"%Y%m%d%H%M%S")
   local zip_name="$(basename "$input_path")_$timestamp.zip"
   
   # Create the ZIP file
   zip -r "$zip_name" "$input_path" > /dev/null
   
   echo "$zip_name"
}

# Function to upload the ZIP file to S3
upload_to_s3() { 
   local file_path="$1"
   local bucket_name="$2"
   aws s3 cp "$file_path" "s3://$bucket_name/" > /dev/null
}

# path of the file or directory to back up
read -p "Enter the path of the directory or file to back up: " input_path
if [ ! -e "$input_path" ]; then
    echo "Error: The specified path does not exist."
    exit 1
fi

read -p "Enter the name of the S3 bucket: " bucket_name

# Create ZIP file
zip_file=$(create_zip "$input_path")
echo "Created ZIP file: $zip_file"

# Check if ZIP file was created
if [ ! -f "$zip_file" ]; then
    echo "Error: ZIP file was not created."
    exit 1
fi

# Upload ZIP file to S3
upload_to_s3 "$zip_file" "$bucket_name"
echo "Uploaded $zip_file to s3://$bucket_name/"

# Remove ZIP file after upload
rm "$zip_file"
echo "Removed local ZIP file: $zip_file"

