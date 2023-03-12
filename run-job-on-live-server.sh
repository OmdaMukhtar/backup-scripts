#!/bin/bash
# Author: omda
# Date Created: 12-03-2023
# Descriptoin: because of cron job sevice not wokring on server 1*.*.*.* so this code will authenticat to the remote server as omda user and try to run the cron job of the server to backup files.
# Date Modified: 12-03-2023

# Available server urls you want to triger backup function inside it
urls=`cat /home/omda/server-url`

# loop
for url in $urls
do
	ssh omda@$url "/path/to/your/cronjob/on-remote/server/run-cron" > cron-job-error.txt

	if [ $? -ne 0 ]
	then
	
		errors=`cat /your/home/cron-job-error.txt`

                # Set the webhook URL
                WEBHOOK_URL="https://your-url-webhook/hooks/83dy1k3617gk5pdheyhswxj1aw"

                # Set the message you want to send
                MESSAGE=$errors

                # Send the message using curl
                curl -X POST -H "Content-Type: application/json" -d "{\"text\": \"$errors\"}" $WEBHOOK_URL
	fi
	echo "Process finished"
done
