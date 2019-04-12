USERS=(george cluster)

echo ${USERS[@]}

# for each user
for i in ${USERS[@]}; do
    # create a folder
    sudo mkdir /home/$i/.sparkmagic
    # copy file
    sudo sh -c "cat config.json | sed -e 's/<user>/'$i'/g' > /home/$i/.sparkmagic/config.json"
done


#cat config.json | sed -e 's/<user>/george/g'
