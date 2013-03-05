-module(message).

-compile([debug_info, export_all]).

generate_response({message, Message}) ->
	try
		{ok, M1} = validate_format(Message),
		{ok, Command} = determine_command(M1),
		{ok, Params} = validate_parameters(Command, M1),
		{ok, {data, D}} = api(Command, Params),
		form_response(M1, D)
	catch
		error:{missing_attribute,Attribute} ->
			ErrorMessage = list_to_binary(io_lib:format("Missing Attribute: ~s", [Attribute])),
			form_response(Message, {error, missing_attribute, ErrorMessage});
		error:{command_not_found,Name} ->
			ErrorMessage = list_to_binary(io_lib:format("This command is not valid: ~s", [Name])),
			form_response(Message, {error, command_not_found, ErrorMessage});
		error:{missing_parameter,Parameter} ->
			ErrorMessage = list_to_binary(io_lib:format("Missing Parameter: ~s", [Parameter])),
			form_response(Message, {error, missing_parameter, ErrorMessage})
		% error:_ ->
		% 	form_response(Message, {error, error, <<"Unexpected error. Sorry, heavy load.">>})
	end;
generate_response(Data) ->
	try
		Message = init(Data),
		generate_response({message, Message})
	catch
		error:not_json ->
			form_response({error, not_json, <<"Received data is not of a valid JSON format">>})
	end.

init(Data) ->
	try mochijson2:decode(Data) of
		{struct, D} ->
			destruct(D)
	catch
		error:_ -> erlang:error(not_json)
	end.

destruct({struct, L}) ->
    destruct(L);
destruct([H | T]) ->
    [destruct(H) | destruct(T)];
destruct({K, V}) ->
    {K, destruct(V)};
destruct(Term) ->
    Term.

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

		false -> erlang:error({missing_attribute, Target})
	end.

determine_command(Message = [{<<"command">>,_}|_]) ->
	determine_command(lists:keyfind(<<"command">>, 1, Message));

determine_command({<<"command">>, Name}) ->
	case Name of
		<<"redirect">> -> {ok, redirect};
		<<"updateStatus">> -> {ok, update_status};
		<<"login">> -> {ok, login};
		<<"fetchContacts">> -> {ok, fetch_contacts};
		<<"createContact">> -> {ok, create_contact};
		_ -> erlang:error({command_not_found, Name})
	end;
determine_command(_) ->
	erlang:error(badarg).

validate_parameters(Command, Message = [{<<"command">>,_}|_]) ->
	% GENERAL CASE
	{_, Params} = lists:keyfind(<<"params">>, 1, Message),
	validate_parameters(Command, Params);

validate_parameters(redirect, Params) ->
	Num = find_parameter(<<"num">>, Params),
	{ok, [{num, Num}]};
validate_parameters(update_status, Params) ->
	Status = find_parameter(<<"status">>, Params),
	{ok, [{status, Status}]};
validate_parameters(fetch_contacts, _) ->
	{ok, []};
% validate_parameters(create_contact, Message) ->
% 	TO BE IMPLEMENTED;
validate_parameters(login, Params) ->
	Username = find_parameter(<<"username">>, Params),
	Password = find_parameter(<<"password">>, Params),
	{ok, [{username, Username}, {password, Password}]}.

find_parameter(Param, ListOfParams) ->
	case lists:keyfind(Param, 1, ListOfParams) of
		{Param, Value} ->
			Value;
		false ->
			erlang:error({missing_parameter, Param})
	end.

api(redirect, Params) ->
	api_redirect(Params);
api(update_status, Params) ->
	api_update_status(Params);
api(login, Params) ->
	api_login(Params).

api_redirect(Params) ->
	% IMPLEMENT CONNECTION TO CALL MANAGER
	[{num, Num}] = Params,
	{ok, {data, [{<<"num">>, Num}]}}.

api_update_status(Params) ->
	[{status, Status}] = Params,
	{ok, {data, [{<<"status">>, Status}]}}.

api_login(Params) ->
	[{username, Username}, {password, Password}] = Params,
	% IMPLEMENT stuff about login
	{ok, {data, [{<<"username">>, Username}, {<<"auth">>, <<"DbsjhfasJJNN23">>}]}}.

form_response({error, _, ErrorMessage}) ->
	Status = {<<"status">>, [{<<"type">>,<<"error">>}, {<<"message">>,[ErrorMessage]}]},

	Response = [Status],
	list_to_binary(mochijson2:encode(Response)).

form_response(Message, FullError = {error, _, ErrorMessage}) ->
	try
		{_, Timestamp} = lists:keyfind(<<"timestamp">>, 1, Message),
		TimeTuble = {<<"recv_timestamp">>, Timestamp},
		Status = {<<"status">>, [{<<"type">>,<<"error">>},{<<"message">>,[ErrorMessage]}]},
		list_to_binary(mochijson2:encode([Status, TimeTuble]))
	catch
		_ -> form_response(FullError)
	end;
form_response(Message, Data) ->
	Command = lists:keyfind(<<"command">>, 1, Message),
	{_,Timestamp} = lists:keyfind(<<"timestamp">>, 1, Message),
	TimeTuble = {<<"recv_timestamp">>, Timestamp},
	Status = {<<"status">>, [{<<"type">>,<<"ok">>},{<<"message">>,[]}]},
	DataTuble = {<<"data">>, Data},

	Response = [Command, Status, DataTuble, TimeTuble],
	list_to_binary(mochijson2:encode(Response)).






