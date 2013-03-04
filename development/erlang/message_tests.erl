-module(message_tests).

-include_lib("eunit/include/eunit.hrl").

init_test() ->
	Data = <<"{\"valid\":true}">>,
	Invalid_data = <<"This is surely not JSON">>,
	?assertEqual([{<<"valid">>,true}], message:init(Data)),
	% ?assertEqual({error, <<"Message not of JSON format">>}, message:init(Invalid_data)).
    ?assertException(error, _, message:init(Invalid_data)).

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

% determine_parameters_test() ->
%     Redirect = [{<<"command">>,<<"redirect">>}, {<<"params">>,[{<<"num">>, <<"42135642">>}]}, {<<"auth">>,<<"some_key">>},{<<"timestamp">>, <<"2002-02-02">>}],
%     WrongRedirect = [{<<"command">>,<<"redirect">>}, {<<"params">>,[{<<"status">>, <<"2">>]}, {<<"auth">>,<<"some_key">>},{<<"timestamp">>, <<"2002-02-02">>}],
%     ?assertEqual(ok, message:determine_parameters(redirect, Redirect)),
%     ?assertEqual(error, message:determine_parameters(redirect, WrongRedirect)).

validate_parameters_test() ->
    RedirectMessage = [{<<"command">>, <<"redirect">>}, {<<"params">>, [{<<"trololo">>, <<"dsajjdsaoi">>}, {<<"num">>, <<"42135642">>}]}, {<<"auth">>, <<"some_key">>}, {<<"timestamp">>, <<"2002-02-02">>}],
    WrongRedirectMessage = [{<<"command">>, <<"redirect">>}, {<<"params">>, [{<<"trololo">>, <<"dsajjdsaoi">>}, {<<"nudsafsam">>, <<"4213fsad25642">>}]}, {<<"auth">>, <<"some_key">>}, {<<"timestamp">>, <<"2002-02-02">>}],
    Update_statusMessage = [{<<"command">>, <<"updateStatus">>}, {<<"params">>, [{<<"trololo">>, <<"dsajjdsaoi">>}, {<<"status">>, <<"42135642">>}]}, {<<"auth">>, <<"some_key">>}, {<<"timestamp">>, <<"2002-02-02">>}],
    WrongUpdate_statusMessage = [{<<"command">>, <<"updateStatus">>}, {<<"params">>, [{<<"trololo">>, <<"dsajjdsaoi">>}, {<<"num">>, <<"42135642">>}]}, {<<"auth">>, <<"some_key">>}, {<<"timestamp">>, <<"2002-02-02">>}],
    LoginMessage = [{<<"command">>, <<"login">>}, {<<"params">>, [{<<"trololo">>, <<"dsajjdsaoi">>}, {<<"username">>, <<"bjarkehs">>}, {<<"password">>, <<"thomas er en derp">>}, {<<"num">>, <<"42135642">>}]}, {<<"auth">>, <<"some_key">>}, {<<"timestamp">>, <<"2002-02-02">>}],
    WrongLoginMessage = [{<<"command">>, <<"login">>}, {<<"params">>, [{<<"trololo">>, <<"dsajjdsaoi">>}, {<<"nudsafsam">>, <<"4213fsad25642">>}]}, {<<"auth">>, <<"some_key">>}, {<<"timestamp">>, <<"2002-02-02">>}],
    Fetch_contactsMessage = [{<<"command">>, <<"fetchContacts">>}, {<<"params">>, [{<<"trololo">>, <<"dsajjdsaoi">>}, {<<"username">>, <<"bjarkehs">>}, {<<"password">>, <<"thomas er en derp">>}, {<<"num">>, <<"42135642">>}]}, {<<"auth">>, <<"some_key">>}, {<<"timestamp">>, <<"2002-02-02">>}],
    WrongFetch_contactsMessage = [{<<"command">>, <<"fetchContacts">>}, {<<"auth">>, <<"some_key">>}, {<<"timestamp">>, <<"2002-02-02">>}],
    ?assertEqual({ok, [{num, <<"42135642">>}]}, message:validate_parameters(redirect, RedirectMessage)),
    ?assertException(error, _, message:validate_parameters(redirect, WrongRedirectMessage)),
    ?assertEqual({ok, [{status, <<"42135642">>}]}, message:validate_parameters(update_status, Update_statusMessage)),
    ?assertException(error, _, message:validate_parameters(update_status, WrongUpdate_statusMessage)),
    ?assertEqual({ok, [{username, <<"bjarkehs">>}, {password, <<"thomas er en derp">>}]}, message:validate_parameters(login, LoginMessage)),
    ?assertException(error, _, message:validate_parameters(login, WrongLoginMessage)),
    ?assertEqual({ok, []}, message:validate_parameters(fetch_contacts, Fetch_contactsMessage)),
    ?assertException(error, _, message:validate_parameters(fetch_contacts, WrongFetch_contactsMessage)).

api_redirect_test() ->
    RedirectParams = [{num, <<"213412332">>}],
    WrongRedirectParams = [{test, <<"dsadssss">>}],
    ?assertEqual({ok, {data, [{<<"num">>,<<"213412332">>}]}}, message:api_redirect(RedirectParams)),
    ?assertException(error, _, message:api_redirect(WrongRedirectParams)).

