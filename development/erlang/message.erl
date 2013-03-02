-module(message).

-compile([debug_info, export_all]).

init(Data) ->
	case json:decode(Data) of
		{ok, {D}} ->
			D;
		{error,_} -> {error, <<"Message not of JSON format">>}
	end.

validate_format(M) ->
	validate_format(M, [], []).

validate_format(M, [], []) ->
	validate_format(M, [<<"command">>, <<"params">>, <<"auth">>, <<"timestamp">>], []);

validate_format(_, [], R) ->
	{ok, lists:reverse(R)};

validate_format(Message, RequiredAttributes, Result) ->
	[Target|RA] = RequiredAttributes,
	Attribute = lists:keyfind(Target, 1, Message),
	case Attribute of
		{Target, Value} -> validate_format(Message, RA, [{Target,Value}|Result]);

		false -> error %{error, <<"Missing attribute">>}
	end.

determine_command({<<"command">>, Name}) ->
	case Name of
		<<"redirect">> -> {ok, redirect};
		<<"updateStatus">> -> {ok, update_status};
		<<"login">> -> {ok, login};
		<<"fetchContacts">> -> {ok, fetch_contacts};
		<<"createContact">> -> {ok, create_contact};
		_ -> error
	end;
determine_command({_,_}) ->
	error.