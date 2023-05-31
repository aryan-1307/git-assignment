#!/bin/bash

ask_repo(){
    read -p " Enter rapo" name
    while ! [[ "$name" =~ ^.*aryan$ ]]
    do
    echo " Invalid "
    read -p " Enter rapo " name
    done
}
read -s -p " Enter password " key
read -p " Enter description " des
git init
if [[ "${#username}" -eq 0 ]];
then
read -p " Enter username " user
export username=$user
fi
ask_repo

response=$( curl -L -X POST -H "Authorization: Bearer $key" https://api.github.com/user/repos -d "{\"name\":\"$repo_name\",\"description\":\"$description\"}" )
while [[ "$response" =~ ^.*already\ exists.*$ ]]
do
echo " Repo already exists "
ask_repo
response=$( curl -L -X POST -H "Authorization: Bearer $key" https://api.github.com/user/repos -d "{\"name\":\"$repo_name\",\"description\":\"$description\"}" )
done
git add -A
git commit . -m " Initial commit "
git branch -m master main
git remote add origin "https://$key@github.com/$username/$repo_name.git"
echo "Done "
