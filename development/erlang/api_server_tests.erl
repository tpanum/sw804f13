-module(api_server_tests).

-include_lib("eunit/include/eunit.hrl").

decodeData_test() ->
    ?assertEqual(0, api_server:sum([])),
    ?assertEqual(0, api_server:sum([0])),
    ?assertEqual(6, api_server:sum([1,2,3,4,-4])).