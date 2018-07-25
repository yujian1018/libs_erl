%%%-------------------------------------------------------------------
%%% @author yj
%%% @doc
%%%
%%% Created : 25. 七月 2018 上午9:03
%%%-------------------------------------------------------------------
-module(erl_utf8).

-export([
    char/1
]).

char(<<B1:8, Bin/binary>>) ->
    if
        B1 >= 1 andalso B1 =< 127 ->
            {<<B1:8>>, Bin};
        B1 > 192 andalso B1 =< 223 ->
            <<B2:8, RBin/binary>> = Bin,
            {<<B1:8, B2:8>>, RBin};
        B1 > 224 andalso B1 =< 239 ->
            <<B2:8, B3:8, RBin/binary>> = Bin,
            {<<B1:8, B2:8, B3:8>>, RBin};
        B1 > 240 andalso B1 =< 247 ->
            <<B2:8, B3:8, B4:8, RBin/binary>> = Bin,
            {<<B1:8, B2:8, B3:4, B4:8>>, RBin};
        B1 > 248 andalso B1 =< 251 ->
            <<B2:8, B3:8, B4:8, B5:8, RBin/binary>> = Bin,
            {<<B1:8, B2:8, B3:4, B4:8, B5:8>>, RBin};
        B1 > 252 andalso B1 =< 253 ->
            <<B2:8, B3:8, B4:8, B5:8, B6:8, RBin/binary>> = Bin,
            {<<B1:8, B2:8, B3:4, B4:8, B5:8, B6:8>>, RBin}
    end.
