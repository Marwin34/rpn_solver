%%%-------------------------------------------------------------------
%%% @author marcin
%%% @copyright (C) 2019, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 22. Mar 2019 14:28
%%%-------------------------------------------------------------------
-module(onp).
-author("marcin").

%% API
-export([onp/1]).

onp(Input) ->
  [Result] = lists:foldl(fun action/2, [], string:tokens(Input, " ")),
  Result.


% Decydujemy co ma robic funkcja przekazywana do foldl jesli natrafimy na operator
action("+", [O1, O2 | Stack]) ->
  [O1 + O2 | Stack];
action("-", [O1, O2 | Stack]) ->
  [O1 - O2 | Stack];
action("*", [O1, O2 | Stack]) ->
  [O1 * O2 | Stack];
action("/", [O1, O2 | Stack]) ->
  [O2 / O1 | Stack];
action("^", [O1, O2 | Stack]) ->
  [math:pow(O2, O1) | Stack];
action("ln", [O1 | Stack]) ->
  [math:log(O1) | Stack];
action("log10", [O1 | Stack]) ->
  [math:log10(O1) | Stack];
action("tan", [O1 | Stack]) ->
  [math:tan(O1) | Stack];
action("ctan", [O1 | Stack]) ->
  [1/math:tan(O1) | Stack];
action("cos", [O1 | Stack]) ->
  [math:cos(O1) | Stack];
action("sin", [O1 | Stack]) ->
  [math:sin(O1) | Stack];
action("acos", [O1 | Stack]) ->
  [math:acos(O1) | Stack];
action("asin", [O1 | Stack]) ->
  [math:asin(O1) | Stack];
action("sqrt", [O1 | Stack]) ->
  [math:sqrt(O1) | Stack];

% Jesli to na co natrafilismy nie jest operatorem zakladamy zejest liczba i wrzucam ja na stos
action(Operand, Stack) ->
  case (catch list_to_float(Operand)) of
    {'EXIT', _} -> [list_to_integer(Operand) | Stack];
    Float_value -> [Float_value | Stack]
  end.
