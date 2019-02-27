USERS=(george cluster)

echo ${USERS[@]}

# for each user
for i in ${USERS[@]}; do
    # create a folder
    # copy file
    echo user: $i
done


cat config.json | sed -e 's/<user>/george/g'
