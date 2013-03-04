-module(message).

-compile([debug_info, export_all]).

init(Data) ->
	case mochijson2:decode(Data) of
		{struct, D} ->
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

validate_parameters(redirect, Message) ->
	{_, Params} = lists:keyfind(<<"params">>, 1, Message),
	{_, Num} = lists:keyfind(<<"num">>, 1, Params),
	{ok, [{num, Num}]};
validate_parameters(update_status, Message) ->
	{_, Params} = lists:keyfind(<<"params">>, 1, Message),
	{_, Status} = lists:keyfind(<<"status">>, 1, Params),
	{ok, [{status, Status}]};
validate_parameters(fetch_contacts, Message) ->
	{_, _} = lists:keyfind(<<"params">>, 1, Message),
	{ok, []};
% validate_parameters(create_contact, Message) ->
% 	TO BE IMPLEMENTED;
validate_parameters(login, Message) ->
	{_, Params} = lists:keyfind(<<"params">>, 1, Message),
	{_, Username} = lists:keyfind(<<"username">>, 1, Params),
	{_, Password} = lists:keyfind(<<"password">>, 1, Params),
	{ok, [{username, Username}, {password, Password}]}.

api(redirect, Params) ->
	api_redirect(Params);
api(update_status, Params) ->
	api_fetch_contacts(Params).

api_redirect(Params) ->
	% IMPLEMENT CONNECTION TO CALL MANAGER
	[{num, Num}] = Params,
	{ok, {data, [{<<"num">>, Num}]}}.

api_fetch_contacts(Params) ->
	ok.

form_response(Message, Data) ->
	Command = lists:keyfind(<<"command">>, 1, Message),
	{_,Timestamp} = lists:keyfind(<<"timestamp">>, 1, Message),
	TimeTuble = {<<"recv_timestamp">>, Timestamp},
	Status = {<<"status">>, [{<<"type">>,<<"test">>},{<<"message">>,[]}]},
	DataTuble = {<<"data">>, Data},

	Response = [Command, Status, DataTuble, TimeTuble],
	list_to_binary(mochijson2:encode(Response)).






