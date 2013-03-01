-module(api_server_tests).

-include_lib("eunit/include/eunit.hrl").

findAuthentication_test() ->
    Data = [{<<"auth">>, <<"abcd">>}],
    IncorrectData = [{<<"noauth">>, <<"ndkjsa">>}],
    ?assertEqual(<<"abcd">>, api_server:findAuthentication(Data)),
    ?assertEqual(false, api_server:findAuthentication(IncorrectData)).

findCommand_test() ->
    Data = [{<<"command">>, <<"abcd">>}],
    IncorrectData = [{<<"nocommand">>, <<"ndkjsa">>}],
    ?assertEqual(<<"abcd">>, api_server:findCommand(Data)),
    ?assertEqual(false, api_server:findCommand(IncorrectData)).

findParameters_test() ->
    Data = [{<<"params">>, <<"abcd">>}],
    IncorrectData = [{<<"noparams">>, <<"ndkjsa">>}],
    ?assertEqual(<<"abcd">>, api_server:findParameters(Data)),
    ?assertEqual(false, api_server:findParameters(IncorrectData)).

authenticate_test() ->
    ?assertEqual({ok, 1}, api_server:authenticate(<<"abcd">>)),
    ?assertEqual(error, api_server:authenticate(<<"abcdde">>)).

handleAuthentication_test() ->
    Data = [{<<"auth">>, <<"abcd">>}],
    IncorrectData = [{<<"noauth">>, <<"ndkjsa">>}],
    ?assertEqual({ok, 1}, api_server:handleAuthentication(Data)),
    ?assertEqual(error, api_server:handleAuthentication(IncorrectData)).