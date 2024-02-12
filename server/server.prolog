:- use_module(library(http/thread_httpd)).
:- use_module(library(http/http_dispatch)).
:- use_module(library(http/http_client)).
:- use_module(library(http/json)).

:- http_handler(root(api), api_response, []).
:- http_server(http_dispatch, [port(8000)]).

api_response(Request) :-
    format('Content-type: application/json~n'),
    format('Access-Control-Allow-Origin: http://localhost:8080~n'),
    format('~n'),
    response_body(Request).


response_body(Request) :-
    member(method(get), Request), !,
    read_file_to_string('tasks.json', JsonAsString, []),
    write(JsonAsString).

response_body(Request) :-
    member(method(post), Request), !,
    format('{"task":'),
    http_read_data(Request, JsonText, []),
    atom_json_dict(JsonText, JsonData, []),
    write(JsonData.from),
    format('}').
