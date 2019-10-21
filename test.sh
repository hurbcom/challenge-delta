# Unix tty color prefix
COLOR_PREFIX="033";


# Colors definition
GRAY="\\${COLOR_PREFIX}[1;30m";
RED="\\${COLOR_PREFIX}[1;31m";
GREEN="\\${COLOR_PREFIX}[1;32m";
NO_COLOR="\\${COLOR_PREFIX}[0m";
BLUE="\\${COLOR_PREFIX}[1;36m";

# Success message
SUCCESS="${GREEN}OK${NO_COLOR}";


# Fail message
FAIL="${RED}FAIL${NO_COLOR}";


#
# Function that prints the test message
#
test_message ()
{
    echo -en "${GRAY}${1}: ";
}

#
# Function that executes commands 
#
test_command ()
{
    $1 &> /dev/null && echo -e ${SUCCESS} || {
        echo -e ${FAIL};
    }
}

echo
echo -e "${BLUE}Testing Delta Challenge${NO_COLOR}";
echo
test_message "Get all packages from /packages"
test_command "curl localhost/packages"
echo
test_message "Adding test package in database"
test_command "curl -X POST --header 'Content-Type: text/plain' -d teste_shell localhost/packages"
ID_TEST=$(docker exec -i delta_db mysql --user=user_packages --password='passwords' -e "call get_id_test();" packages 2> /dev/null | awk -F 'Id' '{print $1}' | tr -d '[:space:]');
echo
test_message "Removing test package from the database"
test_command 'curl -X DELETE localhost/packages/'$ID_TEST''
echo
echo -e "${GRAY}All tests completed!${NO_COLOR}";
echo