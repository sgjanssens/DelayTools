(*------------------------------------------------------------------------------------

DelayTools - A Maple library for the analysis of delay equations

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
    export mlindex, mldiff, eval_at_delays, ddediff;
    # local eval_at_delays;


    mlindex := proc(d::posint, r::posint, $)::listlist;
        (* Recursively build a list containing d^r sublists. Each of these
        sublists is of the form [i[1],..,i[r]] where every element is in the
        range 1..d. *)

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

        d := nops([op([1,1], f)]);
        idx := mlindex(d, r);
        add(VectorCalculus:-D[op(i)](f)(0$d)*~mul(v[s][i[s]], s = 1..r), i in idx);
    end proc;


    eval_at_delays := proc(phi::operator, delays::list, $)::list;
        (* Evaluate phi at minus each delay in the list. If phi has n components and
        there are m + 1 delays - including the zero delay - then the resulting
        n by (m + 1) matrix is returned in column-major order as a flattened list.
        This makes it easier to use the result as input for function evaluation. *)

        local phi_at_delays;

        phi_at_delays := map(phi, -delays);
        return map(op, map(convert, phi_at_delays, list));
    end proc;


    ddediff := proc(f::operator, E::procedure, r::posint, argfuncs::list, $)::Vector;
        (* Calculate the rth order derivative at zero of the right-hand side of a DDE
        and apply the result to r argument functions. *)

        return mldiff(f, r, map(E, argfuncs));
    end proc;


    (* -------------------------------------------------------------------------
    mdiff := proc(y::algebraic, x::list, r::nonnegint, $)
        (* Recursively calculate the derivatives of order r of y w.r.t. the
        elements in x. In the result, the entry indexed by i[1],..,i[r] is
        the derivative of y w.r.t. x[i[r]],...,x[i[1]]. *)

        option remember;
        local d, i;

        d := numelems(x);

        if r = 0 then
            return y;
        else
            return ['diff(mdiff(y, x, r - 1), x[i])' $ i = 1..d];
        end if;
    end proc;
    ------------------------------------------------------------------------- *)

end module;
