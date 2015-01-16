-module(cowboy_lager_app).
-behaviour(application).

-export([start/2]).
-export([stop/1]).

start(_Type, _Args) ->
    Dispatch = cowboy_router:compile([
        {'_', [
               {"/connect", ws_handler, []},
               {"/", cowboy_static, {priv_file, cowboy_lager, "static/index.html"}}
        ]}
    ]),
    cowboy:start_http(my_http_listener, 100, [{port, 8081}],
        [{env, [{dispatch, Dispatch}]}]
    ),
    cowboy_lager_sup:start_link().

stop(_State) ->
    ok.
