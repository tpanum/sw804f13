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
	{ok, R};

validate_format(Message, RequiredAttributes, Result) ->
	[Target|RA] = RequiredAttributes,
	Attribute = lists:keyfind(Target, 1, Message),
	case Attribute of
		{Target, Value} -> R = Result++[{Target,Value}], validate_format(Message, RA, R);

		false -> error %{error, <<"Missing attribute">>}
	end.
