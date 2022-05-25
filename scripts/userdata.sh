 #!/bin/bash
         sudo apt update -y
         sudo apt install apache2 unzip -y 
         sudo systemctl start apache2.service       
         curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
         unzip awscliv2.zip 
         sudo ./aws/install
         cd /var/www/html  
         aws s3 cp s3://udacity-demo-1/udacity.zip .
         unzip -o udacity.zip
         EC2_AVAIL_ZONE=$(curl -s http://169.254.169.254/latest/meta-data/placement/availability-zone)
         echo "<h1>Hello World From $(hostname -f) in AZ $EC2_AVAIL_ZONE </h1>" >> index.html

         
        #  For quick test, replace lines 9-12 with this command <<echo "Your Cloud Formation Script Works!!" > index.html>>  