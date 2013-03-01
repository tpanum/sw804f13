-module(api_server).

-export([listen/1]).

-compile([debug_info, export_all]).

-define(TCP_OPTIONS, [binary, {packet, 0}, {active, false}, {reuseaddr, true}]).

% Call echo:listen(Port) to start the service.
listen(Port) ->
    {ok, LSocket} = gen_tcp:listen(Port, ?TCP_OPTIONS),
    accept(LSocket).

% Wait for incoming connections and spawn the echo loop when we get one.
accept(LSocket) ->
    {ok, Socket} = gen_tcp:accept(LSocket),
    spawn(fun() -> loop(Socket) end),
    accept(LSocket).

% Echo back whatever data we receive on Socket.
loop(Socket) ->
    gen_tcp:send(Socket, <<"Hello">>),
    ok = gen_tcp:close(Socket).
    % case gen_tcp:recv(Socket, 0) of
    %     {ok, Data} ->
    %         io:format("recv'd ~p", [Data]),
    %         gen_tcp:send(Socket, Data),
    %         loop(Socket);
    %     {error, closed} ->
    %         ok
    % end.

handleData(Data) ->
    {ok, {D}} = json:decode(Data),
    Status = handleAuthentication(D),
    case Status of
        {ok, ID} ->
            ID,
            handleCommand(D);
        {error, _} ->
            error
    end.

handleAuthentication(D) ->
    Auth = findAuthentication(D),
    authenticate(Auth).

handleCommand(D) ->
    Command = findCommand(D),
    Parameters = findParameters(D),
    performCommand(Command, Parameters).

findAttribute(List, Attribute) ->
    KeyValue = lists:keyfind(Attribute, 1, List),

    case KeyValue of
        {Attribute, Result} ->
            Result;
        false ->
            false
    end.

findCommand(List) ->
    findAttribute(List, <<"command">>).

performCommand(Command, Parameters) ->
    % case Command of
    %     <<"redirect">> ->
    %         <<"Received action Redirect">>
    % end.
    ok.

findParameters(List) ->
    findAttribute(List, <<"params">>).

findAuthentication(List) ->
    findAttribute(List, <<"auth">>).

authenticate(Authentication) ->
    case Authentication of
        <<"abcd">> ->
            {ok, 1};
        _ ->
            error
    end.






