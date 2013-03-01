-module(message_tests).

-include_lib("eunit/include/eunit.hrl").

init_test() ->
	Data = <<"{\"valid\":true}">>,
	Invalid_data = <<"This is surely not JSON">>,
	?assertEqual([{<<"valid">>,true}], message:init(Data)),
	?assertEqual({error, <<"Message not of JSON format">>}, message:init(Invalid_data)).

validate_format_test() ->
	Data = [{<<"command">>, <<"true">>}, {<<"params">>, []}, {<<"auth">>, <<"some_key">>}, {<<"timestamp">>, <<"2002-02-02">>}],
	Invalid_data = [{<<"thisisnot">>,<<"alist">>}],
	?assertEqual({ok, [{<<"command">>,<<"true">>}, {<<"params">>,[]}, {<<"auth">>,<<"some_key">>},{<<"timestamp">>, <<"2002-02-02">>}]}, message:validate_format(Data)),
	?assertEqual(error, message:validate_format(Invalid_data)).
