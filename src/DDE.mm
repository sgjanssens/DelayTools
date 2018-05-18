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

This file is: DDE.mm

------------------------------------------------------------------------------------*)


DDE := module()
    export eval_at_delays, diff;


    eval_at_delays := proc(phi::operator, delays::list, $)::list;
        (* Evaluate phi at minus each delay in the list. If phi has n components and
        there are m + 1 delays - including the zero delay - then the resulting
        n by (m + 1) matrix is returned in column-major order as a flattened list.
        This makes it easier to use the result as input for function evaluation. *)

        local phi_at_delays;

        phi_at_delays := map(phi, -delays);
        return map(op, map(convert, phi_at_delays, 'list'));
    end proc;


    diff := proc(f::operator, E::procedure, r::posint, argfuncs::list, $)::Vector;
        (* Calculate the rth order derivative at zero of the right-hand side of a DDE
        and apply the result to r argument functions. *)

        return mldiff(f, r, map(E, argfuncs));
    end proc;


end module;
