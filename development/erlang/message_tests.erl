-module(message_tests).

-include_lib("eunit/include/eunit.hrl").

init_test() ->
	Data = <<"{\"valid\":true}">>,
	Invalid_data = <<"This is surely not JSON">>,
	?assertEqual([{<<"valid">>,true}], message:init(Data)),
	?assertEqual({error, <<"Message not of JSON format">>}, message:init(Invalid_data)).

validate_format_test() ->
	Data = [{<<"command">>, <<"true">>}, {<<"params">>, []}, {<<"auth">>, <<"some_key">>}, {<<"timestamp">>, <<"2002-02-02">>}],
    UnsortedData = [{<<"params">>, []}, {<<"command">>, <<"true">>}, {<<"auth">>, <<"some_key">>}, {<<"timestamp">>, <<"2002-02-02">>}],
	Invalid_data = [{<<"thisisnot">>,<<"alist">>}],
	?assertEqual({ok, [{<<"command">>,<<"true">>}, {<<"params">>,[]}, {<<"auth">>,<<"some_key">>},{<<"timestamp">>, <<"2002-02-02">>}]}, message:validate_format(Data)),
    ?assertEqual({ok, [{<<"command">>,<<"true">>}, {<<"params">>,[]}, {<<"auth">>,<<"some_key">>},{<<"timestamp">>, <<"2002-02-02">>}]}, message:validate_format(UnsortedData)),
	?assertEqual(error, message:validate_format(Invalid_data)).

% perform_command_test() ->
%     Data = [{<<"command">>, <<"true">>}, {<<"params">>, []}, {<<"auth">>, <<"some_key">>}, {<<"timestamp">>, <<"2002-02-02">>}],
%     UnsortedData = [{<<"params">>, []}, {<<"command">>, <<"true">>}, {<<"auth">>, <<"some_key">>}, {<<"timestamp">>, <<"2002-02-02">>}],
%     Invalid_data = [{<<"thisisnot">>,<<"alist">>}],

determine_command_test() ->
    Redirect = {<<"command">>, <<"redirect">>},
    Update_status = {<<"command">>, <<"updateStatus">>},
    Login = {<<"command">>, <<"login">>},
    Fetch_contacts = {<<"command">>, <<"fetchContacts">>},
    Create_contact = {<<"command">>, <<"createContact">>},
    Invalid_command = {<<"command">>, <<"invalid_command">>},
    Invalid_input = {<<"thisisnot">>,<<"alist">>},
    ?assertEqual({ok, redirect}, message:determine_command(Redirect)),
    ?assertEqual({ok, update_status}, message:determine_command(Update_status)),
    ?assertEqual({ok, login}, message:determine_command(Login)),
    ?assertEqual({ok, fetch_contacts}, message:determine_command(Fetch_contacts)),
    ?assertEqual({ok, create_contact}, message:determine_command(Create_contact)),
    ?assertEqual(error, message:determine_command(Invalid_command)),
    ?assertEqual(error, message:determine_command(Invalid_input)).
