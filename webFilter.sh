#! /bin/bash

# Ask if curl is installed
echo "Do you have curl installed? (yes/no)"
read answer

# Check the user's input
if [ "$answer" = "yes" ]; then
  echo "Continuing..."
elif [ "$answer" = "no" ]; then
  echo "Installing..."
  
  # Execute batch script to download curl
  bash -c "cmd curl-install.bat"
  
  # Wait for download
  sleep 10
else
  echo "Invalid input. Please enter 'yes' or 'no'."
fi

# Set the login endpoint URL
echo "Enter the login page link:"
read login_url

# Set the email and password
echo "Enter your email:"
read email
echo "Enter your password:"
read -s password

# Send a POST request to the login endpoint with the email and password form data
curl -X POST -d "email=$email" -d "password=$password" "$login_url"


# Set the search query
echo "Enter your search: "
read query

# Download the search results page
echo "Enter URL -- EX: google.com/search"
read url
results=$(curl "$url?q=$query")

# Launch chrome
start chrome $url?q=$query

# Extract the links from the search results page
links=$(echo "$results" | grep -oP 'href="/url\?q=\K[^&]*')

# Save the links to a file
echo "$links" > links.txt

# Read the user's search term
echo "Enter search term:"
read search_term

# Open and filter each link
while read -r link; do
  # Download the web page
  page=$(curl "$link")

  # Filter the web page based on the search term
  filtered=$(echo "$page" | grep "$search_term")

  # Append the filtered content to a file
  echo "$filtered" >> results.txt
done < links.txt

# Convert the results to Excel format
ssconvert -S results.txt results.xlsx

