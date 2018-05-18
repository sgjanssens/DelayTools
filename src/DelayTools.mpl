(*------------------------------------------------------------------------------------

DelayTools - A Maple package for the analysis of delay equations

Copyright 2018 Sebastiaan G. Janssens

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

Maple is a trademark of Waterloo Maple Inc.

This file is: DelayTools.mpl

------------------------------------------------------------------------------------*)


DelayTools := module()
    option package;
    export mlindex, mldiff, DDE;


$include "DDE.mm"


    mlindex := proc(d::posint, r::posint, $)::listlist;
        (* Recursively build a list containing d^r sublists. Each of these sublists is
        of the form [i[1],..,i[r]] where every element is in the range 1..d. *)

        option remember;
        local i, j;

        if r = 1 then
            return [[i] $ i = 1..d];
        else
            return ['seq([i, op(j)], j in mlindex(d, r - 1))' $ i = 1..d];
        end if;
    end proc;


    mldiff := proc(f::operator, r::posint, v::list, $)::Vector;
        (* Calculate the derivative of order r of the function f, at the origin,
        and apply the resulting r-linear form to v. If kernelopts(assertlevel)
        is non-zero, it is checked that v indeed has r elements. *)

        local d, idx, i, s;

        ASSERT(is(numelems(v), r), "An r-linear form requires r arguments.");

        d := nops([op([1,1], f)]); # number of arguments of f
        idx := mlindex(d, r);
        add(VectorCalculus:-D[op(i)](f)(0$d)*~mul(v[s][i[s]], s = 1..r), i in idx);
    end proc;


end module;
