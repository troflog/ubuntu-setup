wget -qO- https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add - 
sudo add-apt-repository "$(wget -qO- https://packages.microsoft.com/config/ubuntu/20.04/mssql-server-preview.list)"
curl https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add -
sudo apt-get update
sudo apt-get install -y mssql-server 
#After the package installation finishes 
run mssql-conf setup && 
#follow the prompts to set the SA password and choose your edition.
#As a reminder, the following SQL Server editions are freely licensed:
#Evaluation, Developer, and Express.
sudo /opt/mssql/bin/mssql-conf setup &&
#Remember to specify a strong password for the SA account. You need a
#minimum length 8 characters, including uppercase and lowercase
#letters, base-10 digits and/or non-alphanumeric symbols.

#Once the configuration is done, verify that the service is running:

systemctl status mssql-server --no-pager
